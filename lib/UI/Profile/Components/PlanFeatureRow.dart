import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanFeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSupported;

  const PlanFeatureRow({
    Key? key,
    required this.icon,
    required this.text,
    required this.isSupported,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: isSupported ? Colors.green : Colors.red, size: 15),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14))),
      ],
    );
  }
}
