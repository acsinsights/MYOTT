import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Model/BaseCommentsModel.dart';

import '../../Core/Utils/app_text_styles.dart';
import 'custom_text_field.dart';


class CommentSection extends StatelessWidget {
  final List<BaseCommentModel> comments;
  final TextEditingController controller;
  final VoidCallback onSend;

  const CommentSection({
    super.key,
    required this.comments,
    required this.controller,
    required this.onSend,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Comments",
            style: AppTextStyles.SubHeadingb1,
          ),
        ),
        SizedBox(
          height: 200,
          child: comments.isNotEmpty
              ? ListView.builder(
            itemCount: comments.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final comment = comments[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.name,
                        style: AppTextStyles.SubHeading1,
                      ),
                      SizedBox(height: 5),
                      Text(
                        DateFormat("dd-MM-yyyy").format(comment.createdAt ?? DateTime.now()),
                        style: AppTextStyles.SubHeadingSubW4,
                      ),
                      SizedBox(height: 5),
                      Text(
                        comment.comment,
                        style: AppTextStyles.SubHeadingGrey2,
                      ),
                      SizedBox(height: 5),
                      const Divider(color: Colors.white),
                    ],
                  ),
                ),
              );
            },
          )
              : Center(
            child: Text(
              "No comments available",
              style: AppTextStyles.SubHeadingGrey2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomTextField(
            controller: controller,
            hintText: "Write a comment",
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            suffixIcon: IconButton(
              onPressed: onSend,
              icon: const Icon(Icons.send, color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}
