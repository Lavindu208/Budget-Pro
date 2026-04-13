import 'package:budget_pro/domain/bloc/display_category_cubit.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:budget_pro/presentation/components/custom_numpad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_pro/data/models/expenses_categories.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpense();
}

class _AddExpense extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Item')),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: ExpensesCategories.expenseItems.map((item) {
                return expensesCategoryItem(item['icon'], item['category']);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget expensesCategoryItem(IconData icon, String categoryName) {
    return InkWell(
      onTap: () {
        context.read<DisplayCategoryCubit>().displayExpenseCategory(
          categoryName,
        );
        final currentRoute =
            ModalRoute.of(context)?.settings.name ?? 'expense_item';
        if (categoryName != 'Add New') {
          showModalBottomSheet(
            context: context,
            isScrollControlled: false,
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            builder: (BuildContext context) {
              return CustomNumpad(previousRoute: currentRoute);
            },
          );
        }
      },
      child: Column(
        children: [
          categoryName == 'Add New'
              ? Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(icon, color: Colors.grey),
                )
              : Container(
                  width: 55,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.boxGreen,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
          SizedBox(height: 5),
          Expanded(
            child: Text(
              categoryName,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
