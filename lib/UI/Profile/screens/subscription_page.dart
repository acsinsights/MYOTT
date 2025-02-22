import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int? selectedPlanIndex;

  final List<Map<String, dynamic>> plans = [
    {
      "title": "Elite Plan",
      "price": "₹6,800.00 / one year",
      "description":
      "The Elite Plan grants yearly access to all content, including premium and exclusive features.",
      "discount": false,
      "features": {
        "Ads": "Ads will not be shown",
        "Devices": "Up to 8 devices simultaneously",
        "Resolution": "480P/720P/1080P/1440P/2K/4K/8K",
        "Supported": ["Mobile", "Laptop", "Tablet"],
        "Profiles": "Up to 4 profiles",
      },
    },
    {
      "title": "Premium Plan",
      "price": "₹1,550.00 / one month",
      "description":
      "The Premium Plan provides monthly access to a wider range of content, including exclusive shows.",
      "discount": true,
      "features": {
        "Ads": "Ads will not be shown",
        "Devices": "Up to 2 devices simultaneously",
        "Resolution": "480P/720P/1080P/1440P",
        "Supported": ["Mobile", "Tablet"],
        "Profiles": "Up to 3 profiles",
      },
    },
    {
      "title": "Basic Plan",
      "price": "₹430.00 / one week",
      "description":
      "The Basic Plan offers access to a limited selection of content on a weekly basis, perfect for casual viewers.",
      "discount": false,
      "features": {
        "Ads": "Ads will be shown",
        "Devices": "Up to 1 device simultaneously",
        "Resolution": "480P/720P/1080P",
        "Supported": ["Mobile"],
        "Profiles": "Up to 2 profiles",
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Image.asset("assets/Icons/app_logo.png", height: 20),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Subscribe now and dive into endless streaming",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  return SubscriptionCard(
                    plan: plans[index],
                    index: index, // Pass index here
                    isSelected: selectedPlanIndex == index,
                    onSelect: () {
                      setState(() {
                        selectedPlanIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: selectedPlanIndex != null
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pay ${plans[selectedPlanIndex!]["price"].split('/')[0]}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                // Handle payment
              },
              child: Text("Next", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      )
          : null,
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final Map<String, dynamic> plan;
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
            color: isSelected ? Colors.red : Colors.transparent, // Red border when selected
            width: 2,
          ),
        ),
        color: Colors.grey[900], // Keep the background color the same for all
        margin: EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center-align content
            mainAxisAlignment: MainAxisAlignment.center, // Vertically center content
            children: [
              if (plan["discount"])
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Save 10%",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              SizedBox(height: 8),
              Text(
                plan["title"],
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                plan["price"],
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                plan["description"],
                style: TextStyle(color: Colors.white60, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              PlanFeatureRow(icon: Icons.block, text: plan["features"]["Ads"], isSupported: true),
              PlanFeatureRow(icon: Icons.devices, text: plan["features"]["Devices"], isSupported: true),
              PlanFeatureRow(icon: Icons.video_settings, text: plan["features"]["Resolution"], isSupported: true),
              PlanFeatureRow(icon: Icons.account_circle, text: plan["features"]["Profiles"], isSupported: true),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center align supported devices
                children: [
                  Text(
                    "Supported Devices: ",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  ...plan["features"]["Supported"].map<Widget>((device) {
                    return Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        device == "Mobile"
                            ? Icons.smartphone
                            : device == "Laptop"
                            ? Icons.laptop
                            : Icons.tablet,
                        color: Colors.green,
                        size: 20,
                      ),
                    );
                  }).toList(),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center align radio button
                children: [
                  Text(
                    "Select Plan",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 10),
                  Radio<int>(
                    value: index,
                    groupValue: isSelected ? index : null,
                    onChanged: (val) => onSelect(),
                    activeColor: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
