import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myott/Core//Utils/app_text_styles.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("MovieDetails",style: AppTextStyles.Headingb4,),
        leading: Icon(Icons.arrow_back,color: Colors.white,),
      ),
      body: Container(
      child: Text("No Movie Deatils"),
      ),
    );
  }
}
