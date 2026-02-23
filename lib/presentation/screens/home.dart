import 'package:budget_pro/domain/show_select_option.dart';
import 'package:budget_pro/presentation/components/expenseItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../appColors/app_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // CheckScreen checkScreen = CheckScreen();
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
                SizedBox(height: 10),
                Text('This month so far...', style: TextStyle(fontSize: 17)),
                SizedBox(height: 20),
                // --------------------three boxes----------------------
                threeBoxes(),

                //---------------progress bars--------------
                progressBars(),

                //----------Net Exchange--------------
                netExchange(),

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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget threeBoxes() {
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
                Text(
                  '1000 LKR',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.boxBlue,
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
                  Text(
                    '1000 LKR',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
                  Text(
                    '1000 LKR',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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

  Widget progressBars() {
    return Container(
      padding: EdgeInsets.only(top: 30, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 20),
            child: Text(
              'Expenses',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          LinearPercentIndicator(
            animation: true,
            animationDuration: 1000,
            lineHeight: 14.0,
            percent: 0.55,
            trailing: Text(
              '55%',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 214, 214, 214),
            barRadius: Radius.circular(10),
            linearGradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 218, 73, 63),
                const Color.fromARGB(255, 248, 170, 53),
              ],
            ),
          ),
          SizedBox(height: 14),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 20),
            child: Text(
              'Lend',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          LinearPercentIndicator(
            animation: true,
            animationDuration: 1000,
            lineHeight: 14.0,
            percent: 0.3,
            trailing: Text(
              '30%',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 214, 214, 214),
            barRadius: Radius.circular(10),
            linearGradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 54, 51, 228),
                const Color.fromARGB(255, 43, 179, 189),
              ],
            ),
          ),
          SizedBox(height: 14),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 20),
            child: Text(
              'Debt',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          LinearPercentIndicator(
            animation: true,
            animationDuration: 1000,
            lineHeight: 14.0,
            percent: 0.15,
            trailing: Text(
              '15%',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 214, 214, 214),
            barRadius: Radius.circular(10),
            linearGradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 32, 192, 45),
                const Color.fromARGB(255, 112, 228, 59),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget netExchange() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Net Exchange',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 47,
                          height: 47,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(92, 68, 98, 162),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.handshake,
                              color: AppColors.boxBlue,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('To Receive', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '3500.00 LKR',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: const Color.fromARGB(
                    255,
                    189,
                    189,
                    189,
                  ), // Color of the line
                  height: 20, // Total height of the box containing the line
                  thickness: 1, // Thickness of the line itself
                  indent: 55, // Empty space at the beginning of the line
                  endIndent: 0, // Empty space at the end of the line
                ),

                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 47,
                          height: 47,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(92, 66, 179, 96),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.money,
                              color: AppColors.boxGreen,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('To Pay', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '3500.00 LKR',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
