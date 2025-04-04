import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/Utils/app_text_styles.dart';
import '../../Components/Comment_section.dart';
import 'blog_controller.dart';

class BlogDetailsScreen extends StatelessWidget {
  final String blogSlug;

  BlogDetailsScreen({Key? key, required this.blogSlug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BlogController blogController = Get.find<BlogController>();
    blogController.setBlogSlug(blogSlug);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Blog Details", style: AppTextStyles.Heading4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (blogController.isBlogDetailsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final blog = blogController.blogDetails.value;

        if (blog == null || blog.data.isEmpty) {
          return Center(
            child: Text("Blog details not available", style: AppTextStyles.SubHeadingw3),
          );
        }

        final blogData = blog.data.first;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  blogData.bannerImg,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(blogData.title, style: AppTextStyles.Headingb1),
              const SizedBox(height: 8),

              // Category badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  blogData.categoryId.toUpperCase(), // assuming categoryId is like "Tech", "Life"
                  style: AppTextStyles.SubHeadingw3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.white.withOpacity(0.3)),
              const SizedBox(height: 12),

              // Blog Description
              Text(
                blogData.description,
                style: AppTextStyles.SubHeadingw3.copyWith(height: 1.5),
              ),
              Divider(color: Colors.grey,),

              // Comment Section
              CommentSection(
                comments: blog.comments,
                controller: blogController.commentController,
                onSend: () {
                  blogController.addCommentForBlog(blogData.id, blogData.slug);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
