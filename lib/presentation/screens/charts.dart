import 'package:budget_pro/domain/bloc/show_details_on_expense_chart_cubit.dart';
import 'package:budget_pro/domain/bloc/show_details_on_income_chart_cubit.dart';
import 'package:budget_pro/domain/bloc/show_total_expense_cubit.dart';
import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:budget_pro/presentation/components/chart_breakdown_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_expenseTab(), _incomeTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _expenseTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 252, 253, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _expensePieChart(),
              SizedBox(height: 15),
              Container(
                // width: 300,
                alignment: Alignment.center,
                child: _expensePieChartProperties(),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        spendingBreakDown(),
        SizedBox(height: 20),
        // BlocBuilder<ShowDetailsOnExpenseChartCubit, DataState>(
        //   builder: (context, state) {
        //     if (state is DataInit) {
        //       return CircularProgressIndicator();
        //     } else if (state is DataLoading) {
        //       return CircularProgressIndicator();
        //     } else if (state is DataLoaded) {
        //       List<Map<String, dynamic>> data = state.chartDataList;
        //       data.map((item) {
        //         return chartBreakDownCard('Food', 100, 10.0);
        //       }).toList();
        //     }
        //     return CircularProgressIndicator();
        //   },
        // ),
      ],
    );
  }

  Widget _expensePieChart() {
    return Stack(
      alignment: Alignment.center,

      children: [
        BlocBuilder<ShowDetailsOnExpenseChartCubit, DataState>(
          builder: (context, state) {
            if (state is DataLoaded) {
              return Column(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 114, 114, 114),
                    ),
                  ),
                  BlocBuilder<ShowTotalExpenseCubit, int>(
                    builder: (context, state) {
                      return Text(
                        state.toString(),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Saira',
                        ),
                      );
                    },
                  ),
                  Text(
                    'spent',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 114, 114, 114),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
        SizedBox(
          width: 210,
          height: 210,
          child: BlocBuilder<ShowDetailsOnExpenseChartCubit, DataState>(
            builder: (context, state) {
              if (state is DataInit) {
                return CircularProgressIndicator();
              } else if (state is DataLoading) {
                return CircularProgressIndicator();
              } else if (state is DataLoaded) {
                List<Map<String, dynamic>> data = state.chartDataList;

                return PieChart(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOutCubic,
                  PieChartData(
                    centerSpaceRadius: double.nan,
                    startDegreeOffset: -90,
                    sectionsSpace: 2,
                    sections: data.map((item) {
                      return PieChartSectionData(
                        color: item['color'],
                        value: item['percentage'],
                        showTitle: false,
                        titleStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        radius: 30,
                        titlePositionPercentageOffset: -0.5,
                      );
                    }).toList(),
                  ),
                );
              } else if (state is DataEmpty) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 230, 230),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 235, 235, 235),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 15,
                          color: const Color.fromARGB(17, 0, 0, 0),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.circleExclamation,
                          color: const Color.fromARGB(255, 129, 129, 129),
                          size: 30,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text('Something went wrong!'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _expensePieChartProperties() {
    return BlocBuilder<ShowDetailsOnExpenseChartCubit, DataState>(
      builder: (context, state) {
        if (state is DataInit) {
          return CircularProgressIndicator();
        } else if (state is DataLoading) {
          return CircularProgressIndicator();
        } else if (state is DataLoaded) {
          List<Map<String, dynamic>> data = state.chartDataList;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 50,
              // childAspectRatio: 3.8,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 241, 241),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            item['category'],
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 7),
                          Text(
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            '${item['percentage'].toString()}%',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }

  String selectedSortItem = 'Maximum';
  List<String> sortItems = ['Maximum', 'Minimum'];

  Widget spendingBreakDown() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Spending breakdown',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 35,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 252, 252, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  alignment: AlignmentDirectional.center,
                  iconSize: 15,
                  icon: Icon(FontAwesomeIcons.arrowsUpDown),
                  value: selectedSortItem,
                  items: sortItems.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSortItem = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _incomeTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 251, 252, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _incomePieChart(),
              SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                width: 220,
                child: _incomePieChartProperties(),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        spendingBreakDown(),
        SizedBox(height: 20),
        // BlocBuilder<ShowDetailsOnExpenseChartCubit, DataState>(
        //   builder: (context, state) {
        //     if (state is DataLoaded) {
        //       List<Map<String, dynamic>> data = state.chartDataList;
        //       data.map((item) {
        //         return chartBreakDownCard(
        //           item['category'],
        //           item['amount'],
        //           item['percentage'],
        //         );
        //       }).toList();
        //     }
        //     return CircularProgressIndicator();
        //   },
        // ),
      ],
    );
  }

  Stack _incomePieChart() {
    return Stack(
      alignment: Alignment.center,

      children: [
        BlocBuilder<ShowDetailsOnIncomeChartCubit, IncomeDataState>(
          builder: (context, state) {
            if (state is DataLoaded) {
              return Column(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 114, 114, 114),
                    ),
                  ),
                  BlocBuilder<ShowTotalExpenseCubit, int>(
                    builder: (context, state) {
                      return Text(
                        state.toString(),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Saira',
                        ),
                      );
                    },
                  ),
                  Text(
                    'spent',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 114, 114, 114),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
        SizedBox(
          width: 210,
          height: 210,
          child: BlocBuilder<ShowDetailsOnIncomeChartCubit, IncomeDataState>(
            builder: (context, state) {
              if (state is IncomeDataInit) {
                return CircularProgressIndicator();
              } else if (state is IncomeDataLoading) {
                return CircularProgressIndicator();
              } else if (state is IncomeDataLoaded) {
                List<Map<String, dynamic>> data = state.chartDataList;

                return PieChart(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOutCubic,
                  PieChartData(
                    centerSpaceRadius: double.nan,
                    startDegreeOffset: -90,
                    sectionsSpace: 2,
                    sections: data.map((item) {
                      return PieChartSectionData(
                        color: item['color'],
                        value: item['percentage'],
                        showTitle: false,
                        titleStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        radius: 30,
                        titlePositionPercentageOffset: -0.5,
                      );
                    }).toList(),
                  ),
                );
              } else if (state is IncomeDataEmpty) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 230, 230),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 235, 235, 235),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 15,
                          color: const Color.fromARGB(17, 0, 0, 0),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.circleExclamation,
                          color: const Color.fromARGB(255, 129, 129, 129),
                          size: 30,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text('Something went wrong!'));
              }
            },
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> incomeChartProperties = [
    {'color': ChartColors.red, 'category': 'Salary'},
    {'color': ChartColors.orange, 'category': 'Investments'},
    {'color': ChartColors.yellow, 'category': 'Part time'},
  ];

  Widget _incomePieChartProperties() {
    return BlocBuilder<ShowDetailsOnIncomeChartCubit, IncomeDataState>(
      builder: (context, state) {
        if (state is IncomeDataInit) {
          return CircularProgressIndicator();
        } else if (state is IncomeDataLoading) {
          return CircularProgressIndicator();
        } else if (state is IncomeDataLoaded) {
          List<Map<String, dynamic>> data = state.chartDataList;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 50,
              // childAspectRatio: 3.8,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 241, 241),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 5),
                    Row(
                      children: [
                        Text(
                          item['category'],
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 7),
                        Text(
                          '${item['percentage'].toString()}%',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}


// expensePieChartData.map((item) {
//             return PieChartSectionData(
//               value: item['value'],
//               color: item['color'],
//               title: item['title'],
//               titleStyle: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//               radius: 30,
//               titlePositionPercentageOffset: -0.5,
//             );
//           }).toList(),