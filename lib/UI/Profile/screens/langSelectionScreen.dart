import 'package:flutter/material.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String selectedLanguage = "English"; // Default selected language

  final List<Map<String, String>> languages = [
    {"name": "English", "flag": "🇺🇸"},
    {"name": "Hindi", "flag": "🇮🇳"},
    {"name": "Arabic", "flag": "🇦🇪"},
    {"name": "French", "flag": "🇫🇷"},
    {"name": "German", "flag": "🇩🇪"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Language", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];

          return ListTile(
            leading: Text(language["flag"]!, style: TextStyle(fontSize: 24)),
            title: Text(
              language["name"]!,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            trailing: selectedLanguage == language["name"]
                ? Icon(Icons.check_circle, color: Colors.white)
                : null,
            onTap: () {
              setState(() {
                selectedLanguage = language["name"]!;
              });
            },
          );
        },
      ),
    );
  }
}
