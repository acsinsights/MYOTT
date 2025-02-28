import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myott/Services/Setting_service.dart';
import 'package:myott/Services/api_service.dart';
import 'package:myott/Utils/app_colors.dart';
import 'package:myott/Utils/app_text_styles.dart';

import 'Blog_details_screen.dart';
import 'Model/blog_model.dart';
import 'blog_controller.dart';

class BlogScreen extends StatelessWidget {
  // Register controller lazily to avoid unnecessary re-initialization
  final BlogController blogController = Get.put(
    BlogController(SettingService(ApiService())), // Ensure SettingService is injected globally
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Blogs", style: AppTextStyles.Heading4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (blogController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (blogController.blogs.isEmpty) {
          return Center(
            child: Text("No blogs available", style: AppTextStyles.Heading4),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: blogController.blogs.length,
          itemBuilder: (context, index) {
            BlogModel blog = blogController.blogs[index];

            return GestureDetector(
              onTap: () {
                // Get.to(() => BlogDetailsScreen(blogId: blog.id));

                // Navigate to Blog Details Page (Uncomment when ready)
                Get.to(() => BlogDetailsScreen(blog: blog));
              },
              child: Card(
                color: AppColors.subwhite,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Blog Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/movies/SliderMovies/movie-1.png",
                          height: 100,
                          width: 100, // Fixed width for consistency
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                          },
                        ),
                      ),
                      SizedBox(width: 15),

                      // Blog Title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blog.title,
                              style: AppTextStyles.HeadingbLackB2,
                              maxLines: 2, // Prevents overflow
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              blog.desc,
                              style: AppTextStyles.SubHeadingw3,
                              maxLines: 2, // Prevents overflow
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              blog.createdAt != null
                                  ? DateFormat('dd MMM yyyy').format(blog.createdAt)
                                  : "No Date",
                              style: AppTextStyles.SubHeadingw3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
