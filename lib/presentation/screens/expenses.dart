import 'package:budget_pro/domain/bloc/date_selector.dart';
import 'package:budget_pro/presentation/components/expenseItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<String> categories = [
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
  ];
  String selectedValue = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                categorySelector(),
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
                  style: TextStyle(
                    color: const Color.fromARGB(255, 58, 58, 58),
                  ),
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
      ),
    );
  }

  //--------------category selector------------------
  Widget categorySelector() {
    return Container(
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
        // padding: EdgeInsets.all(8),
        iconSize: 35,
        value: selectedValue,
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedValue = value!;
          });
        },
      ),
    );
  }

  //---------------date selector---------------
  Widget dateSelector() {
    return InkWell(
      onTap: () => context.read<DateSelectorCubit>().selectDate(context),
      child: Container(
        width: 150,
        height: 35,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 231, 231, 231),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 202, 202, 202),
            width: 1,
          ),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<DateSelectorCubit, String>(
              builder: (context, date) {
                return Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    date,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
            Icon(Icons.arrow_drop_down, size: 35),
          ],
        ),
      ),
    );
  }
}
