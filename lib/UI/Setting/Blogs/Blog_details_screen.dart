import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/Utils/app_text_styles.dart';
import 'blog_controller.dart';

class BlogDetailsScreen extends StatelessWidget {
  final int blogId;

  BlogDetailsScreen({required this.blogId});

  @override
  Widget build(BuildContext context) {
    final BlogController blogController = Get.find<BlogController>();


    blogController.setBlogId(blogId);

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
          return Center(child: CircularProgressIndicator());
        }

        final blog = blogController.blogDetails.value;
        if (blog == null || blog.data == null) {
          return Center(child: Text("Blog details not available", style: AppTextStyles.SubHeadingw3));
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  blog.data.thumbnailImg,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(blog.data.title, style: AppTextStyles.Headingb1),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(blog.data.desc, style: AppTextStyles.SubHeadingw3),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
