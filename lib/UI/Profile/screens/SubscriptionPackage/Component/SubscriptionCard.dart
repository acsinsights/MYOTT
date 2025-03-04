import 'package:flutter/material.dart';
import 'package:myott/UI/Profile/screens/SubscriptionPackage/Model/PackageModel.dart';

class SubscriptionCard extends StatelessWidget {
  final PackageModel plan;
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;

  const SubscriptionCard({
    Key? key,
    required this.plan,
    required this.index,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 2,
          ),
        ),
        color: Colors.grey[900],
        margin: EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(plan.name, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(plan.currency +plan.amount.toString(), style: TextStyle(color: Colors.white70, fontSize: 16)),
              SizedBox(height: 8),
              Text(plan.features, style: TextStyle(color: Colors.white60, fontSize: 14), textAlign: TextAlign.center),
              SizedBox(height: 12),
              Radio<int>(
                value: index,
                groupValue: isSelected ? index : -1, // ✅ Always compare with an actual int
                onChanged: (val) => onSelect(),
                activeColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
