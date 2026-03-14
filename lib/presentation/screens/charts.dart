import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:budget_pro/presentation/components/chart_breakdown_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
            color: const Color.fromARGB(255, 235, 235, 235),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _expensePieChart(),
              SizedBox(height: 15),
              Container(
                width: 250,
                alignment: Alignment.center,
                child: _expensePieChartProperties(),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        spendingBreakDown(),
        SizedBox(height: 20),
        chartBreakDownCard(),
      ],
    );
  }

  List<Map<String, dynamic>> expensePieChartData = [
    {'value': 40.0, 'color': ChartColors.red, 'title': '40%'},
    {'value': 24.0, 'color': ChartColors.orange, 'title': '24%'},
    {'value': 19.0, 'color': ChartColors.yellow, 'title': '19%'},
    {'value': 7.0, 'color': ChartColors.lightGreen, 'title': '7%'},
    {'value': 10.0, 'color': ChartColors.darkGreen, 'title': '10%'},
  ];

  Widget _expensePieChart() {
    return SizedBox(
      width: 210,
      height: 210,
      child: PieChart(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        PieChartData(
          centerSpaceRadius: double.nan,
          startDegreeOffset: -90,
          sectionsSpace: 2,
          sections: expensePieChartData.map((item) {
            return PieChartSectionData(
              value: item['value'],
              color: item['color'],
              title: item['title'],
              titleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              radius: 30,
              titlePositionPercentageOffset: -0.5,
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> expenseChartProperties = [
    {'color': ChartColors.red, 'category': 'Food'},
    {'color': ChartColors.orange, 'category': 'Transportation'},
    {'color': ChartColors.lightGreen, 'category': 'Sport'},
    {'color': ChartColors.yellow, 'category': 'Education'},
    {'color': ChartColors.darkGreen, 'category': 'Others'},
  ];

  Widget _expensePieChartProperties() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.8,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: expenseChartProperties.length,
      itemBuilder: (BuildContext context, int index) {
        final item = expenseChartProperties[index];
        return Row(
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
            Text(
              item['category'],
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        );
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
                  color: const Color.fromARGB(255, 236, 236, 236),
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
            color: const Color.fromARGB(255, 235, 235, 235),
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
        chartBreakDownCard(),
      ],
    );
  }

  List<Map<String, dynamic>> incomePieChartData = [
    {'value': 40.0, 'color': ChartColors.red, 'title': '40%'},
    {'value': 24.0, 'color': ChartColors.orange, 'title': '24%'},
    {'value': 10.0, 'color': ChartColors.yellow, 'title': '10%'},
  ];

  Widget _incomePieChart() {
    return SizedBox(
      width: 210,
      height: 210,
      child: PieChart(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        PieChartData(
          centerSpaceRadius: double.nan,
          startDegreeOffset: -90,
          sectionsSpace: 2,
          sections: incomePieChartData.map((item) {
            return PieChartSectionData(
              value: item['value'],
              color: item['color'],
              title: item['title'],
              titleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              radius: 30,
              titlePositionPercentageOffset: -0.5,
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> incomeChartProperties = [
    {'color': ChartColors.red, 'category': 'Salary'},
    {'color': ChartColors.orange, 'category': 'Investments'},
    {'color': ChartColors.yellow, 'category': 'Part time'},
  ];

  Widget _incomePieChartProperties() {
    return GridView.builder(
      itemCount: incomeChartProperties.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final item = incomeChartProperties[index];
        return Row(
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
            Text(
              item['category'],
              style: TextStyle(fontWeight: FontWeight.w400),
              softWrap: true,
            ),
          ],
        );
      },
    );
  }
}
