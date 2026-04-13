import 'package:budget_pro/data/models/expense_item.dart';
import 'package:budget_pro/data/models/income_item.dart';
import 'package:budget_pro/domain/bloc/add_new_expense_bloc.dart';
import 'package:budget_pro/domain/bloc/add_new_income_bloc.dart';
import 'package:budget_pro/domain/bloc/calculate_total_expense_cubit.dart';
import 'package:budget_pro/domain/bloc/select_expense_item.dart';
import 'package:budget_pro/domain/bloc/date_selector.dart';
import 'package:budget_pro/domain/bloc/show_action_buttons_cubit.dart';
import 'package:budget_pro/domain/show_select_option.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:budget_pro/presentation/components/expenseItem.dart';
import 'package:budget_pro/presentation/components/incomeItem.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses>
    with SingleTickerProviderStateMixin {
  List<String> expenseCategories = [
    'All',
    'Food',
    'Education',
    'Entertainment',
    'Transportation',
    'Vehicle',
    'Electronics',
    'Travel',
    'Clothing',
    'Donation',
    'Repair',
    'Gift',
    'Sports',
    'Home',
    'Rental',
    'Shopping',
  ];

  List<String> incomeCategories = ['All', 'Salary', 'Investments', 'Part time'];

  List<String> sortBy = ['Daily', 'Monthly', 'Today'];
  String selectedExpenseCategoryValue = 'All';
  String selectedIncomeCategoryValue = 'All';
  String selectedSortValue = 'Today';
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      CheckScreen.tabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            child: TabBar(
              controller: _tabController,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              indicatorColor: AppColors.navigatorColor,
              labelColor: AppColors.navigatorColor,
              indicatorWeight: 4,
              tabs: [
                Tab(text: 'Expenses'),
                Tab(text: 'Income'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [expenseTabbarView(context), incomeTabbarView()],
            ),
          ),
        ],
      ),
    );
  }

  //--------------category selector------------------
  Widget expenseCategorySelector(List<String> categories) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 35,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 202, 202, 202),
          width: 1,
        ),
      ),
      child: DropdownButton<String>(
        underline: SizedBox(),
        alignment: AlignmentDirectional.center,
        iconSize: 33,
        value: selectedExpenseCategoryValue,
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(
              category,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedExpenseCategoryValue = value!;
          });
        },
      ),
    );
  }

  Widget incomeCategorySelector(List<String> categories) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 35,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 202, 202, 202),
          width: 1,
        ),
      ),
      child: DropdownButton<String>(
        underline: SizedBox(),
        alignment: AlignmentDirectional.center,
        iconSize: 33,
        value: selectedIncomeCategoryValue,
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(
              category,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedIncomeCategoryValue = value!;
          });
        },
      ),
    );
  }

  //---------------date selector---------------
  Widget dateSelector() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 33,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 202, 202, 202),
          width: 1,
        ),
      ),
      child: DropdownButton<String>(
        underline: SizedBox(),
        alignment: AlignmentDirectional.center,
        iconSize: 35,
        value: selectedSortValue,
        items: sortBy.map((sortItem) {
          return DropdownMenuItem(
            onTap: () {
              if (sortItem == 'Today') {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<DateSelectorCubit>().selectDate(context);
                });
              }
            },
            value: sortItem,
            child: Text(
              sortItem,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedSortValue = value!;
          });
        },
      ),
    );
  }

  Widget expenseTabbarView(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              expenseCategorySelector(expenseCategories),
              SizedBox(width: 10),
              dateSelector(),
            ],
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total : ${context.watch<CalculateTotalExpenseCubit>().state}.00',
                style: TextStyle(color: const Color.fromARGB(255, 58, 58, 58)),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<AddNewExpenseBloc, List<ExpenseItem>>(
            builder: (context, items) {
              if (items.isEmpty) {
                return const Center(
                  child: Text(
                    'No expenses yet. Add your first one!',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                );
              }
              if (context.watch<SelectExpenseItem>().state.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return BlocBuilder<SelectExpenseItem, List<dynamic>>(
                  builder: (context, selectedItems) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final listItem = items[index];
                        bool isSelectedItem = index == selectedItems[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                context
                                    .read<SelectExpenseItem>()
                                    .selectFirstItem(index);
                                context
                                    .read<ShowActionButtonsCubit>()
                                    .showButtons();
                              },
                              onTap: () {
                                context
                                    .read<SelectExpenseItem>()
                                    .selectMultipleItems(index);
                                final itemList = context
                                    .read<SelectExpenseItem>()
                                    .items;
                                context
                                    .read<ShowActionButtonsCubit>()
                                    .hideButtons(itemList);
                              },
                              child: expenseItem(
                                listItem.icon,
                                listItem.categoryName,
                                listItem.amount,
                                isSelectedItem ? true : false,
                              ),
                            ),
                            if (index != items.length - 1)
                              Divider(
                                indent: 15,
                                endIndent: 15,
                                color: Color.fromARGB(255, 233, 233, 233),
                                thickness: 1,
                                height: 0,
                              ),
                          ],
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget incomeTabbarView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              incomeCategorySelector(incomeCategories),
              SizedBox(width: 10),
              dateSelector(),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total : 250.00',
                style: TextStyle(color: const Color.fromARGB(255, 58, 58, 58)),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<AddNewIncomeBloc, List<IncomeItem>>(
              builder: (context, items) {
                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No income yet. Add your first one!',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final listItem = items[index];
                    return incomeItem(
                      listItem.icon,
                      listItem.categoryName,
                      listItem.amount,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
