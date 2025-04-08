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
  final Function(BaseCommentModel comment)? onDelete;
  final int currentUserId;

  const CommentSection({
    super.key,
    required this.comments,
    required this.controller,
    required this.onSend,
    this.onDelete,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Comments",
            style: AppTextStyles.SubHeadingb1.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: comments.isNotEmpty
                ? ListView.builder(
              itemCount: comments.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar Initials
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade700,
                        child: Text(
                          comment.name.isNotEmpty
                              ? comment.name[0].toUpperCase()
                              : '?',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Comment Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.name,
                              style: AppTextStyles.SubHeading1.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              DateFormat("dd MMM, yyyy").format(
                                  comment.createdAt ?? DateTime.now()),
                              style: AppTextStyles.SubHeadingSubW4
                                  .copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              comment.comment,
                              style: AppTextStyles.SubHeadingGrey2
                                  .copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ),
                      if (onDelete != null &&
                          comment.userId == currentUserId)
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.redAccent),
                          onPressed: () => onDelete!(comment),
                        ),
                    ],
                  ),
                );
              },
            )
                : Center(
              child: Text(
                "No comments yet. Be the first!",
                style: AppTextStyles.SubHeadingGrey2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Comment Input
          CustomTextField(
            controller: controller,
            hintText: "Write a comment...",
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            suffixIcon: IconButton(
              onPressed: onSend,
              icon: const Icon(Icons.send_rounded, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
