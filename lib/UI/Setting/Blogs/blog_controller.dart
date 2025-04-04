import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Setting/Blogs/Model/blog_detail_model.dart';
import 'package:myott/services/commentService.dart';
import '../../../Core/Utils/app_common.dart';
import '../../../services/Setting_service.dart';
import 'Model/blog_model.dart';

class BlogController extends GetxController {

  final SettingService _settingService=SettingService();
  final CommentService commentService=CommentService();
  TextEditingController commentController = TextEditingController();
  var blogs = <BlogModel>[].obs;
  var blogDetails = Rxn<BlogdetailsModel>();
  var isBlogsLoading = true.obs;
  var isBlogDetailsLoading = false.obs;
  var blogslug ="".obs;


  @override
  void onInit() {
    super.onInit();
    fetchBlogs();
    if (blogslug.value != 0) {
      fetchBlogDetails(blogslug.value);
    }
  }

  void setBlogSlug(String slug) {
    blogslug.value = slug;
    fetchBlogDetails(slug);
  }


  Future<void> fetchBlogs() async {
    try {
      isBlogsLoading(true);
      var fetchedBlogs = await _settingService.fetchBlogs();
      if (fetchedBlogs.isEmpty) {
      }
      blogs.assignAll(fetchedBlogs);
    } catch (e) {
      print("Error fetching blogs: $e");
    } finally {
      isBlogsLoading(false);
      print("Blog fetching completed. Blogs length: ${blogs.length}");
    }
  }

  Future<void> fetchBlogDetails(String slug) async {
    try {
      isBlogDetailsLoading(true);

      var blog = await _settingService.fetchBlogDetails(slug);

      if (blog != null) {
        blogDetails.value = blog;
        blogDetails.refresh(); // Ensures UI updates if needed
      } else {
        print("Blog details response is null");
      }
    } catch (e) {
      print("Error fetching blog details: $e");
      // You could also use a snackbar or logging service instead of print
    } finally {
      isBlogDetailsLoading(false);
    }
  }

  Future<void> addCommentForBlog(int blogId, String slug) async {
    if (commentController.text.trim().isEmpty) {
      Get.snackbar("Error", "Comment cannot be empty");
      return;
    }

    try {
      isBlogsLoading(true);

      Map<String, dynamic> formData = {
        "comment": commentController.text.trim(),
        "type": "B",
        "id": blogId
      };

      var response = await commentService.sendComment(formData);

      if (response != null && response['status'] == "success") {
        commentController.clear();
        showSnackbar("Success", response['message'] ?? "Comment added successfully");
        fetchBlogDetails(slug);
      } else {
        showSnackbar("Error", response['message'] ?? "Failed to add comment",isError: true);
      }
    } catch (e) {
      print("Error adding comment: $e");
      showSnackbar("Error", "Something went wrong",isError: true);

    } finally {
      isBlogsLoading(false);
    }
  }


}
