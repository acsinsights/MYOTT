import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myott/services/MovieService.dart';
import 'package:myott/services/api_service.dart';

import '../../Components/custom_button.dart';
import '../Controller/ratingController.dart';

class RatingBottomSheet extends StatelessWidget {
  final int movieId;
  final String type;
  final RatingController ratingController = Get.put(RatingController());

  RatingBottomSheet({required this.movieId, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Rate this Movie", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          SizedBox(height: 10),

          // Star Rating Row
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < ratingController.selectedRating.value
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 32,
                ),
                onPressed: () {
                  ratingController.selectedRating.value = index + 1;
                },
              );
            }),
          )),

          SizedBox(height: 8),

          Obx(() {
            String ratingText = "";
            switch (ratingController.selectedRating.value) {
              case 1:
                ratingText = "Poor";
                break;
              case 2:
                ratingText = "Fair";
                break;
              case 3:
                ratingText = "Good";
                break;
              case 4:
                ratingText = "Very Good";
                break;
              case 5:
                ratingText = "Excellent";
                break;
              default:
                ratingText = "";
            }
            return Text(ratingText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500));
          }),

          SizedBox(height: 10),

          // Review Text Field
          TextField(
            onChanged: (value) => ratingController.reviewText.value = value,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Write a review (optional)",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),

          SizedBox(height: 16),

          // Submit Button
          CustomButton(
            text: "Done",
            onPressed: () => ratingController.submitRating(movieId, type),
          ),
        ],
      ),
    );
  }
}
