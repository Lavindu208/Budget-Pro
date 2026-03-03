import 'package:budget_pro/domain/bloc/date_selector.dart';
import 'package:budget_pro/domain/show_select_option.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:budget_pro/presentation/components/expenseItem.dart';
import 'package:budget_pro/presentation/components/incomeItem.dart';
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
      if (_tabController.indexIsChanging) return;
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
              children: [expenseTabbarView(), incomeTabbarView()],
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
        alignment: AlignmentDirectional.center,
        iconSize: 35,
        value: selectedExpenseCategoryValue,
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
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
        alignment: AlignmentDirectional.center,
        iconSize: 35,
        value: selectedIncomeCategoryValue,
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
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
            child: Text(sortItem),
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

  Widget expenseTabbarView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              expenseCategorySelector(expenseCategories),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                  expenseItem(),
                ],
              ),
            ),
          ),
        ],
      ),
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
            child: SingleChildScrollView(
              child: Column(children: [incomeItem()]),
            ),
          ),
        ],
      ),
    );
  }
}
