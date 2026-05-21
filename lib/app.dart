import 'package:budget_pro/data/models/navigation_list.dart';
import 'package:budget_pro/domain/authentication/auth_repository.dart';
import 'package:budget_pro/domain/bloc/bottomNavigator/navigator_event.dart';
import 'package:budget_pro/domain/bloc/select_expense_items_cubit.dart';
import 'package:budget_pro/domain/bloc/select_income_items_cubit.dart';
import 'package:budget_pro/domain/bloc/show_action_buttons_cubit.dart';
import 'package:budget_pro/domain/delete_expense_income_items.dart';
import 'package:budget_pro/domain/show_select_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Map<String, dynamic>> navIcons = [
    {'icon': Icons.home_outlined, 'label': 'Home'},
    {'icon': Icons.attach_money_outlined, 'label': 'Cashflow'},
    {'icon': Icons.pie_chart_outline, 'label': 'Charts'},
    {'icon': Icons.person_outline, 'label': 'Profile'},
  ];
  List<String> popupMenuOptions = ['Sign out'];
  AuthRepository authRepository = AuthRepository();

  CheckScreen checkScreen = CheckScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 239, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 239, 245),
        title: BlocBuilder<NavigatorCubit, int>(
          builder: (context, state) {
            return Text(
              NavigationList.titles[state],
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            );
          },
        ),

        actions: [
          BlocBuilder<ShowActionButtonsCubit, bool>(
            builder: (context, state) {
              return state
                  ? Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.solidPenToSquare,
                            size: 21,
                            color: const Color.fromARGB(255, 90, 32, 216),
                          ),
                        ),
                        SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirm Action"),
                                  content: Text(
                                    "Are you sure you want to proceed?",
                                  ),
                                  actions: <Widget>[
                                    // CANCEL BUTTON
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                        ); // Closes the dialog
                                      },
                                    ),
                                    // OK BUTTON
                                    TextButton(
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            201,
                                            30,
                                            30,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        int currentTabIdx =
                                            CheckScreen.tabIndex;
                                        DeleteExpenseIncomeItems
                                        deleteExpenseIncomeItems =
                                            DeleteExpenseIncomeItems();
                                        if (currentTabIdx == 0) {
                                          bool isDeleted =
                                              await deleteExpenseIncomeItems
                                                  .deleteData(
                                                    'expenses',
                                                    context
                                                        .read<
                                                          SelectExpenseItemCubit
                                                        >()
                                                        .selectedItems,
                                                  );
                                          if (context.mounted) {
                                            if (isDeleted) {
                                              context
                                                  .read<
                                                    SelectExpenseItemCubit
                                                  >()
                                                  .initializedWithLoadData();
                                            }
                                          }
                                        } else {
                                          bool isDeleted =
                                              await deleteExpenseIncomeItems
                                                  .deleteData(
                                                    'income',
                                                    context
                                                        .read<
                                                          SelectIncomeItemsCubit
                                                        >()
                                                        .selectedItems,
                                                  );
                                          if (context.mounted) {
                                            if (isDeleted) {
                                              context
                                                  .read<
                                                    SelectIncomeItemsCubit
                                                  >()
                                                  .initializedWithLoadData();
                                            }
                                          }
                                        }
                                        // int len = context
                                        //     .read<AddNewExpenseBloc>()
                                        //     .state
                                        //     .length;
                                        // context
                                        //     .read<SelectExpenseItem>()
                                        //     .createInitList(len);
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                          context
                                              .read<ShowActionButtonsCubit>()
                                              .hideButtons([]);
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(
                            FontAwesomeIcons.trash,
                            size: 21,
                            color: const Color.fromARGB(255, 232, 55, 43),
                          ),
                        ),
                      ],
                    )
                  : SizedBox();
            },
          ),

          SizedBox(width: 15),
          IconButton(
            onPressed: authRepository.logOut,
            icon: Icon(FontAwesomeIcons.ellipsisVertical, size: 25),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 15),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkScreen.checkScreen(context);
        },
        shape: CircleBorder(),
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...navIcons.sublist(0, 2).map((data) => _buildNavItem(data)),
              const SizedBox(width: 48),
              ...navIcons.sublist(2).map((data) => _buildNavItem(data)),
            ],
          ),
        ),
      ),
      body: BlocBuilder<NavigatorCubit, int>(
        builder: (context, index) {
          return NavigationList.screens[index];
        },
      ),
    );
  }

  Widget _buildNavItem(Map<String, dynamic> data) {
    int index = navIcons.indexOf(data);
    int currentIndex = context.watch<NavigatorCubit>().state;
    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<NavigatorCubit>().setValue(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              data['icon'],
              color: currentIndex == index
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : const Color.fromARGB(255, 175, 175, 175),
              size: 30,
            ),
            Text(
              data['label'],
              style: TextStyle(
                color: currentIndex == index
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : const Color.fromARGB(255, 175, 175, 175),
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect bottomNavBar() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      child: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...navIcons.sublist(0, 2).map((data) => _buildNavItem(data)),
            const SizedBox(width: 48),
            ...navIcons.sublist(2).map((data) => _buildNavItem(data)),
          ],
        ),
      ),
    );
  }
}
