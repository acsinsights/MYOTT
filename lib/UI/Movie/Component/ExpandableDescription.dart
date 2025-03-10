import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/services/MovieService.dart';
import 'package:myott/services/api_service.dart';

class ExpandableDescription extends StatelessWidget {
  final String description;
  final int minLines;

  ExpandableDescription({Key? key, required this.description, this.minLines = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieController controller =
    Get.put(MovieController(MoviesService(ApiService())));

    final textSpan = TextSpan(
      text: description,
      style: TextStyle(color: Colors.white, fontSize: 16),
    );

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: minLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 40);

    final bool showExpandButton = textPainter.didExceedMaxLines;

    return Column(
      children: [
        Obx(() => AnimatedSize(
          duration: Duration(milliseconds: 300),
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              description,
              style: TextStyle(color: Colors.white, fontSize: 16),
              maxLines: controller.isExpanded.value ? null : minLines,
              overflow:
              controller.isExpanded.value ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
          ),
        )),
        if (showExpandButton)
          Obx(() => IconButton(
            icon: Icon(
              controller.isExpanded.value
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            onPressed: () {
              controller.isExpanded.toggle();
            },
          )),
      ],
    );
  }
}