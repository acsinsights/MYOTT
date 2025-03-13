import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ShimmerLoader.dart';

class MovieShrimmerLoader extends StatelessWidget {
  const MovieShrimmerLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,  // Ensure the shimmer effect has a fixed height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // Showing 3 shimmer items as placeholders
        padding: EdgeInsets.symmetric(horizontal: 16), // ✅ Optimized padding
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0), // ✅ Space between shimmer items
            child: ShimmerLoader(height: 180, width: 120), // Adjusted width for better alignment
          );
        },
      ),
    );
  }
}

class ActorShimmerLoader extends StatelessWidget {
  const ActorShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4, // Showing 3 shimmer items as placeholders
        padding: EdgeInsets.symmetric(horizontal: 16), // Optimized padding
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0), // Space between shimmer items
            child: CircleAvatar(
              radius: 35,
              child: ShimmerLoader(
                height: 70,
                width: 70,
                borderRadius: 70,
              ),
            ),
          );
        },
      ),
    );
  }
}
