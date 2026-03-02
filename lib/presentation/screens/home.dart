import 'package:budget_pro/presentation/components/expenseItem.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../appColors/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
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

                expenseItem(),
                expenseItem(),
                expenseItem(),
                expenseItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget balance() {
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

  Widget topExpenses() {
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
                width: 180,
                height: 180,
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
                        radius: 20,
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
                        radius: 20,
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
                        radius: 20,
                        titlePositionPercentageOffset: -0.7,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 140,
                child: Column(
                  children: [
                    categoryWithPercentage(AppColors.boxRed, 'Food', 40),
                    SizedBox(height: 8),
                    categoryWithPercentage(AppColors.boxBlue, 'Education', 35),
                    SizedBox(height: 8),
                    categoryWithPercentage(AppColors.boxGreen, 'Food', 25),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryWithPercentage(
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

  Widget twoBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.boxRed,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                // Optional: Adds a subtle shadow for depth
                BoxShadow(
                  color: const Color.fromARGB(66, 0, 0, 0),
                  blurRadius: 12,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '-5200.00',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'LKR',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Total Expenses',
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.boxGreen,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                // Optional: Adds a subtle shadow for depth
                BoxShadow(
                  color: const Color.fromARGB(66, 0, 0, 0),
                  blurRadius: 12,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '+10000.00',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'LKR',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Total Expenses',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
