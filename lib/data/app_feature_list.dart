import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppFeatureList {
  final List<Map<String, dynamic>> featureList = [
    {
      'icon': FontAwesomeIcons.userGear,
      'iconColor': const Color.fromARGB(255, 18, 51, 236),
      'iconBackgroundColor': const Color.fromARGB(45, 18, 51, 236),
      'featureName': 'Manage Account',
    },
    {
      'icon': FontAwesomeIcons.sliders,
      'iconColor': const Color.fromARGB(255, 209, 45, 24),
      'iconBackgroundColor': const Color.fromARGB(45, 209, 45, 24),
      'featureName': 'App Preferences',
    },
    {
      'icon': FontAwesomeIcons.database,
      'iconColor': const Color.fromARGB(255, 17, 180, 66),
      'iconBackgroundColor': const Color.fromARGB(45, 17, 180, 66),
      'featureName': 'Manage Data',
    },
    {
      'icon': FontAwesomeIcons.userGear,
      'iconColor': const Color.fromARGB(255, 201, 204, 28),
      'iconBackgroundColor': const Color.fromARGB(45, 201, 204, 28),
      'featureName': 'About',
    },
  ];
}
