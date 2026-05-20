import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNumpad extends StatelessWidget {
  final Function(String) onNumberSelected;
  final VoidCallback onBackPress;
  const CustomNumpad({
    super.key,
    required this.onNumberSelected,
    required this.onBackPress,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> padKeys = [
      '7',
      '8',
      '9',
      '4',
      '5',
      '6',
      '1',
      '2',
      '3',
      '.',
      '0',
      'Del',
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      physics: const NeverScrollableScrollPhysics(),
      children: padKeys.map((key) {
        return _buildNumberButton(key);
      }).toList(),
    );
  }

  InkWell _buildNumberButton(String key) {
    return InkWell(
      onTap: () {
        key == 'Del' ? onBackPress() : onNumberSelected(key);
      },
      borderRadius: BorderRadius.circular(5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 60, 60, 60),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: key == 'Del'
            ? Icon(FontAwesomeIcons.deleteLeft, color: Colors.white)
            : Text(key, style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
