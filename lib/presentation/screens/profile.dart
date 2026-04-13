import 'package:budget_pro/data/app_feature_list.dart';
import 'package:budget_pro/presentation/components/total_expense_and_income.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          profileDetails(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: twoBoxes(context),
          ),
          SizedBox(height: 30),
          appFeatureList(),
        ],
      ),
    );
  }

  SizedBox profileDetails() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              width: 124,
              height: 124,
              'assets/images/profile_image.png',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'User',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Text(
            'User@gmail.com',
            style: TextStyle(
              fontSize: 15,
              color: const Color.fromARGB(255, 82, 82, 82),
            ),
          ),
        ],
      ),
    );
  }

  AppFeatureList features = AppFeatureList();

  Container appFeatureList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(43, 0, 0, 0),
            offset: Offset(0, 0),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: features.featureList.map((item) {
          return Column(
            children: [
              featureListItem(
                item['icon'],
                item['iconColor'],
                item['iconBackgroundColor'],
                item['featureName'],
              ),
              features.featureList.indexOf(item) !=
                      features.featureList.length - 1
                  ? SizedBox(
                      height: 15,
                      child: Divider(
                        color: const Color.fromARGB(255, 224, 224, 224),
                      ),
                    )
                  : SizedBox(),
            ],
          );
        }).toList(),
      ),
    );
  }

  Material featureListItem(
    IconData icon,
    Color iconColor,
    Color iconBgColor,
    String featureName,
  ) {
    return Material(
      color: Colors.white,
      child: Ink(
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(icon, size: 20, color: iconColor),
                    ),
                    SizedBox(width: 10),
                    Text(
                      featureName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Icon(
                  FontAwesomeIcons.angleRight,
                  size: 20,
                  color: const Color.fromARGB(255, 85, 85, 85),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
