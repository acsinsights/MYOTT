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
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ShimmerLoader(height: 180, width: 120),
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
        itemCount: 4,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
