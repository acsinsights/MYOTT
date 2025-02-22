import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/Utils/app_colors.dart';
import 'package:myott/Utils/app_text_styles.dart';

class MovieAttributes extends StatefulWidget {
  final String title;
  final List<String> items;

  const MovieAttributes({required this.title, required this.items});

  @override
  _MovieAttributesState createState() => _MovieAttributesState();
}

class _MovieAttributesState extends State<MovieAttributes> {
  Set<String> selectedItems = {}; // Stores selected items

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyles.SubHeadingb1,
        ),
        SizedBox(height: 5),
        Wrap(
          spacing: 8.0,
          children: widget.items.map((item) {
            bool isSelected = selectedItems.contains(item);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedItems.remove(item);
                  } else {
                    selectedItems.add(item);
                  }
                });
              },
              child: Chip(
                label: Text(
                  item,
                  style: GoogleFonts.poppins(
                    color: AppColors.white, // Text color changes
                  ),
                ),
                backgroundColor: isSelected ? AppColors.primary2 : Colors.grey[800], // Full red on selection
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppColors.primary2, // **Always Red Border Initially**
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20), // Optional rounded corners
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
