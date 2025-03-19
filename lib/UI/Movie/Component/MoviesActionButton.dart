import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';

class MovieActionButtons extends StatelessWidget {
  final bool isWatchlisted;
  final bool isLiked;
  final VoidCallback toggleWatchlist;
  final VoidCallback toggleLike;

  const MovieActionButtons({
    required this.isWatchlisted,
    required this.isLiked,
    required this.toggleWatchlist,
    required this.toggleLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      color: Color(0xff1e1c1c),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            label: "Like",
            onPressed: toggleLike,
            color: isLiked ? Colors.red : Colors.white,
          ),
          _buildActionButton(
            icon: isWatchlisted ? Icons.check : Icons.add,
            label: "Watchlist",
            onPressed: toggleWatchlist,
            color: isWatchlisted ? Colors.green : Colors.white,
          ),
          _buildActionButton(
            icon: Icons.share,
            label: "Share",
            onPressed: () {}, // Implement sharing functionality
            color: Colors.white,
          ),
          _buildActionButton(
            icon: Icons.picture_in_picture_alt,
            label: "pip",
            onPressed: () {}, // Implement sharing functionality
            color: Colors.white,
          ),
          _buildActionButton(
            icon: Icons.cast,
            label: "cast",
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onPressed, required Color color}) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color, size: 28),
          onPressed: onPressed,
        ),
        Text(label, style: AppTextStyles.SubHeadingw3),
      ],
    );
  }
}
