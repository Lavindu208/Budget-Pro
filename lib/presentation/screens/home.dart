import 'package:budget_pro/domain/bloc/add_new_expense_bloc.dart';
import 'package:budget_pro/domain/bloc/calculate_income_expense_balance_cubit.dart';
import 'package:budget_pro/domain/bloc/show_total_expense_cubit.dart';
import 'package:budget_pro/domain/bloc/show_total_income_cubit.dart';
import 'package:budget_pro/presentation/components/homescreen_expense_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
      body: SingleChildScrollView(
        child: SizedBox(
          // height: screenHeight(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                // ---------------------Total balance-------------------
                balance(),
                SizedBox(height: 20),
                // ---------------------Top expenses-------------------
                Text(
                  'Top Expenses',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
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
                BlocBuilder<AddNewExpenseBloc, List<dynamic>>(
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
                          return homeScreenExpenseItem(
                            listItem.category.icon,
                            listItem.category.label,
                            listItem.note,
                            listItem.amount,
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container balance() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(255, 27, 27, 27),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            Positioned(
              right: -40,
              top: -50,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 56, 56, 56),
                ),
              ),
            ),
            Positioned(
              left: 50,
              bottom: -80,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 56, 56, 56),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL BALANCE',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BlocBuilder<CalculateIncomeExpenseBalanceCubit, int>(
                        builder: (context, state) {
                          return Text(
                            '$state.00',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontFamily: "Saira",
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 3),
                      Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 6),
                        child: const Text(
                          'LKR',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(170, 89, 89, 89),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.arrowTrendDown,
                                    color: const Color.fromARGB(
                                      255,
                                      242,
                                      98,
                                      88,
                                    ),
                                    size: 15,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'EXPENSES',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              BlocBuilder<ShowTotalExpenseCubit, int>(
                                builder: (context, state) {
                                  return Text(
                                    '$state.00',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 242, 98, 88),
                                      fontFamily: 'Saira',
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'this month',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color.fromARGB(
                                    255,
                                    132,
                                    132,
                                    132,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(170, 89, 89, 89),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.arrowTrendUp,
                                    color: const Color.fromARGB(
                                      255,
                                      108,
                                      244,
                                      108,
                                    ),
                                    size: 15,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'INCOME',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              BlocBuilder<ShowTotalIncomeCubit, int>(
                                builder: (context, state) {
                                  return Text(
                                    '$state.00',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 108, 244, 108),
                                      fontFamily: 'Saira',
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'this month',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color.fromARGB(
                                    255,
                                    132,
                                    132,
                                    132,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _pieChartData = [
    {'value': 40.0, 'color': HomeCharColors.red, 'title': '40%'},
    {'value': 35.0, 'color': HomeCharColors.blue, 'title': '35%'},
    {'value': 25.0, 'color': HomeCharColors.green, 'title': '25%'},
  ];

  final List<Map<String, dynamic>> _pieChartProperties = [
    {'color': HomeCharColors.red, 'category': 'Food', 'percentage': 40},
    {'color': HomeCharColors.blue, 'category': 'Education', 'percentage': 35},
    {'color': HomeCharColors.green, 'category': 'Sport', 'percentage': 25},
  ];

  Container topExpenses() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 251, 251, 255),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  Column categoryWithPercentage(
    Color iconColor,
    String categoryName,
    int percentValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
            Text(
              '$percentValue%',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 5),
        LinearPercentIndicator(
          animation: true,
          curve: Curves.easeOut,
          animationDuration: 1000,
          lineHeight: 6,
          padding: EdgeInsets.zero,
          percent: 0.4,
          backgroundColor: const Color.fromARGB(255, 233, 233, 233),
          progressColor: iconColor,
          barRadius: Radius.circular(10),
        ),
      ],
    );
  }
}
