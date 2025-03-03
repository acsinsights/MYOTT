import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_colors.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';

import 'Model/blog_model.dart';

class BlogDetailsScreen extends StatelessWidget {
  final BlogModel blog;

  BlogDetailsScreen({required this.blog});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/movies/SliderMovies/movie-1.png", // Replace with network image if needed
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                },
              ),
            ),
            SizedBox(height: 20),

            // Blog Title
            Text(blog.title, style: AppTextStyles.Headingb1),

            SizedBox(height: 10),

            // Blog Content
            Expanded(
              child: SingleChildScrollView(
                child: Text(blog.desc, style: AppTextStyles.Headingb4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Get.to(() => BlogDetailsScreen(blog: blog));
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myott/UI/Setting/Blogs/blog_controller.dart';
// import 'package:myott/Utils/app_text_styles.dart';
// import 'package:myott/Services/Setting_service.dart';
// import 'package:myott/Services/api_service.dart';
//
//
// class BlogDetailsScreen extends StatelessWidget {
//   final int blogId;
//
//   BlogDetailsScreen({required this.blogId});
//
//   final BlogController controller = Get.put(BlogController(SettingService(ApiService())));
//
//   @override
//   Widget build(BuildContext context) {
//     // Fetch blog details when the screen is built
//     controller.fetchBlogDetails(blogId);
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text("Blog Details", style: AppTextStyles.Heading4),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.blogDetails.value == null) {
//           return Center(child: Text("Error loading blog details",style: AppTextStyles.SubHeadingw3,));
//         }
//
//         final blog = controller.blogDetails.value!;
//
//         return Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Blog Image
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(
//                   blog.thumbnailImg ?? "",
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Blog Title
//               Text(blog.title, style: AppTextStyles.Headingb1),
//
//               SizedBox(height: 10),
//
//               // Blog Content
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Text(blog.desc, style: AppTextStyles.SubHeadingw3),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
