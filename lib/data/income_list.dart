import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeList {
  static List<Map<String, dynamic>> incomeItemData = [
    {
      'icon': FontAwesomeIcons.moneyBill,
      'itemName': 'salary',
      'amount': 50000.00,
    },
    {
      'icon': FontAwesomeIcons.chartColumn,
      'itemName': 'investments',
      'amount': 10000.00,
    },
  ];
}
