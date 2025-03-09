import 'package:get/get.dart';
import 'package:myott/UI/Setting/Blogs/Model/blog_detail_model.dart';
import '../../../services/Setting_service.dart';
import 'Model/blog_model.dart';

class BlogController extends GetxController {

  final SettingService _settingService;
  BlogController(this._settingService);

  var blogs = <BlogModel>[].obs;
  var blogDetails = Rxn<BlogdetailsModel>();
  var isBlogsLoading = true.obs;
  var isBlogDetailsLoading = false.obs;
  var blogId = 0.obs;


  @override
  void onInit() {
    super.onInit();
    fetchBlogs();
    if (blogId.value != 0) {
      fetchBlogDetails(blogId.value);
    }
  }

  void setBlogId(int id) {
    blogId.value = id;
    fetchBlogDetails(id);
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

  Future<void> fetchBlogDetails(int blogId) async {
    try {
      isBlogDetailsLoading(true);
      var blog = await _settingService.fetchBlogDetails(blogId);
      blogDetails.value = blog;
    } catch (e) {
      print("Error fetching blog details: $e");
    } finally {
      isBlogDetailsLoading(false);
    }
  }
}
