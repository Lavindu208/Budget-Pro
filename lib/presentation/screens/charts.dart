import 'package:budget_pro/presentation/appColors/app_colors.dart';
import 'package:budget_pro/presentation/components/chart_breakdown_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              child: TabBar(
                controller: _tabController,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
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
                children: [
                  _expenseTab(),
                  Center(child: Text('income')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expenseTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 235, 235, 235),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _pieChart(),
              Container(child: _pieChartProperties()),
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

  Widget _pieChart() {
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
          sections: [
            PieChartSectionData(
              value: 40,
              color: AppColors.boxRed,
              title: '40%',
              titleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              radius: 30,
              titlePositionPercentageOffset: -0.7,
            ),
            PieChartSectionData(
              value: 35,
              color: AppColors.boxBlue,
              title: '35%',
              titleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              radius: 30,
              titlePositionPercentageOffset: -0.7,
            ),
            PieChartSectionData(
              value: 25,
              color: AppColors.boxGreen,
              title: '25%',
              titleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              radius: 30,
              titlePositionPercentageOffset: -0.7,
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> chartProperties = [
    {'color': AppColors.boxRed, 'category': 'Food'},
    {'color': const Color.fromARGB(255, 243, 106, 64), 'category': 'Food'},
    {'color': const Color.fromARGB(255, 157, 170, 35), 'category': 'Food'},
    {'color': const Color.fromARGB(255, 175, 240, 89), 'category': 'Food'},
    {'color': const Color.fromARGB(255, 48, 163, 64), 'category': 'Food'},
  ];

  Widget _pieChartProperties() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: chartProperties.length,
      itemBuilder: (BuildContext context, int index) {
        final item = chartProperties[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
        Row(
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
                border: Border.all(
                  color: const Color.fromARGB(255, 202, 202, 202),
                  width: 1,
                ),
              ),
              child: DropdownButton<String>(
                alignment: AlignmentDirectional.center,
                iconSize: 35,
                value: selectedSortItem,
                items: sortItems.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
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
      ],
    );
  }
}
