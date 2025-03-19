import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myott/services/Setting_service.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/Core/Utils/app_colors.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';

import '../../Components/network_image_widget.dart';
import 'Blog_details_screen.dart';
import 'Model/blog_model.dart';
import 'blog_controller.dart';

class BlogScreen extends StatelessWidget {
  final BlogController blogController = Get.put(
    BlogController(SettingService(ApiService())),
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
        if (blogController.isBlogsLoading.value) {
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
                final BlogController controller = Get.find<BlogController>();
                controller.setBlogId(blog.id); // Set the blog ID before navigation
                Get.to(() => BlogDetailsScreen(blogId: blog.id));
              },

              child: Card(
                color: Color(0xff191818),
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
                        child: NetworkImageWidget(
                            imageUrl: blog.thumbnailImg,
                            errorAsset: "assets/images/CommingSoon/comming_movie.png",
                            width: 100.w, height: 100.h)
                      ),
                      SizedBox(width: 15),

                      // Blog Title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blog.title,
                              style: AppTextStyles.Headingb3,
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
