import 'package:budget_pro/domain/bloc/add_new_expense_bloc.dart';
import 'package:budget_pro/presentation/components/expenseItem.dart';
import 'package:budget_pro/presentation/components/total_expense_and_income.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../appColors/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ExpenseList expenseList = ExpenseList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 20),
              // ---------------------Total balance-------------------
              balance(),
              SizedBox(height: 20),
              // --------------------two boxes----------------------
              twoBoxes(),
              SizedBox(height: 20),
              // ---------------------Top expenses-------------------
              topExpenses(),
              SizedBox(height: 10),
              //---------------Recently added-------------------
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 10),
                child: Text(
                  'Recently Added',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: BlocBuilder<AddNewExpenseBloc, List<dynamic>>(
                  builder: (context, items) {
                    if (items.isEmpty) {
                      return const Center(
                        child: Text(
                          'No recently added expenses.',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final listItem = items[index];
                        if (index < 4) {
                          return expenseItem(
                            listItem.icon,
                            listItem.categoryName,
                            listItem.amount,
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column balance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Total Balance', style: TextStyle(fontSize: 18)),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '4600.00',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 14, 64, 173),
              ),
            ),
            SizedBox(width: 5),
            Text(
              'LKR',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 14, 64, 173),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  final List<Map<String, dynamic>> _pieChartData = [
    {'value': 40.0, 'color': ChartColors.red, 'title': '40%'},
    {'value': 35.0, 'color': ChartColors.orange, 'title': '35%'},
    {'value': 25.0, 'color': ChartColors.yellow, 'title': '25%'},
  ];

  final List<Map<String, dynamic>> _pieChartProperties = [
    {'color': ChartColors.red, 'category': 'Food', 'percentage': 40},
    {'color': ChartColors.orange, 'category': 'Education', 'percentage': 35},
    {'color': ChartColors.yellow, 'category': 'Sport', 'percentage': 25},
  ];

  Padding topExpenses() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Expenses',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: PieChart(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOutCubic,
                  PieChartData(
                    centerSpaceRadius: double.nan,
                    startDegreeOffset: -90,
                    sectionsSpace: 2,
                    sections: _pieChartData.map((item) {
                      return PieChartSectionData(
                        value: item['value'],
                        color: item['color'],
                        title: item['title'],
                        titleStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        radius: 20,
                        titlePositionPercentageOffset: -0.7,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 140,
                child: Column(
                  children: _pieChartProperties.map((item) {
                    return Column(
                      children: [
                        categoryWithPercentage(
                          item['color'],
                          item['category'],
                          item['percentage'],
                        ),
                        _pieChartProperties.indexOf(item) !=
                                _pieChartProperties.length
                            ? SizedBox(height: 8)
                            : SizedBox(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row categoryWithPercentage(
    Color iconColor,
    String categoryName,
    int percentValue,
  ) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(width: 5),
            Text(categoryName),
          ],
        ),
        Spacer(),
        Text('$percentValue%', style: TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
