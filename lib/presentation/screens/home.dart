import 'package:budget_pro/domain/bloc/show_select_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../appColors/app_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('This month so far...', style: TextStyle(fontSize: 17)),
                SizedBox(height: 20),
                Row(
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
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
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
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
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
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //---------------progress bars--------------
                Container(
                  padding: EdgeInsets.only(top: 30, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.only(left: 20),
                        child: Text(
                          'Expenses',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                        backgroundColor: const Color.fromARGB(
                          255,
                          214,
                          214,
                          214,
                        ),
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
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                        backgroundColor: const Color.fromARGB(
                          255,
                          214,
                          214,
                          214,
                        ),
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
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                        backgroundColor: const Color.fromARGB(
                          255,
                          214,
                          214,
                          214,
                        ),
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
                ),

                //----------Net Exchange--------------
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Net Exchange',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
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
                                        color: const Color.fromARGB(
                                          92,
                                          68,
                                          98,
                                          162,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
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
                                    Text(
                                      'To Receive',
                                      style: TextStyle(fontSize: 17),
                                    ),
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
                              height:
                                  20, // Total height of the box containing the line
                              thickness: 1, // Thickness of the line itself
                              indent:
                                  55, // Empty space at the beginning of the line
                              endIndent:
                                  0, // Empty space at the end of the line
                            ),

                            Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 47,
                                      height: 47,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          92,
                                          66,
                                          179,
                                          96,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
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
                                    Text(
                                      'To Pay',
                                      style: TextStyle(fontSize: 17),
                                    ),
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
                ),

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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.boxGreen,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.food_bank_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text('Lunch'),
                        ],
                      ),
                      Spacer(),
                      Text(
                        '250.00',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<ShowSelectOption, bool>(
            builder: (context, isShow) {
              if (isShow) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(76, 0, 0, 0),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 248, 248, 248),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => context
                                        .read<ShowSelectOption>()
                                        .showOption(context),
                                    child: Icon(Icons.close, size: 30),
                                  ),
                                ],
                              ),
                              // --------Add new expenses row-------------
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        131,
                                        240,
                                        89,
                                        89,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.attach_money_outlined,
                                        size: 30,
                                        color: const Color.fromARGB(
                                          255,
                                          196,
                                          49,
                                          49,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      height: 47,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: const Color.fromARGB(
                                              255,
                                              168,
                                              168,
                                              168,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: const Text(
                                          'Add New Expense',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              // --------------add new lend row--------------
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        118,
                                        68,
                                        98,
                                        162,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.handshake_outlined,
                                        size: 30,
                                        color: const Color.fromARGB(
                                          255,
                                          34,
                                          61,
                                          180,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      height: 47,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: const Color.fromARGB(
                                              255,
                                              168,
                                              168,
                                              168,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: const Text(
                                          'Add New Lend',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 16),
                              // ---------------add new debt row-----------------
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        115,
                                        66,
                                        179,
                                        96,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.money,
                                        size: 30,
                                        color: const Color.fromARGB(
                                          255,
                                          34,
                                          170,
                                          46,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      height: 47,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: const Color.fromARGB(
                                              255,
                                              168,
                                              168,
                                              168,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: const Text(
                                          'Add New Debt',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
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
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
