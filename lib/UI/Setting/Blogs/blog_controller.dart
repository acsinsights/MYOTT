import 'package:get/get.dart';
import '../../../Services/Setting_service.dart';
import 'Model/blog_model.dart';

class BlogController extends GetxController {
  final SettingService _settingService;
  var blogs = <BlogModel>[].obs;
  var blogDetails = Rxn<BlogModel>();  // Nullable observable
  var isLoading = true.obs;

  BlogController(this._settingService);

  @override
  void onInit() {
    fetchBlogs();
    super.onInit();
  }

  Future<void> fetchBlogs() async {
    try {
      isLoading(true);
      var fetchedBlogs = await _settingService.fetchBlogs();
      print("fetched blog $fetchedBlogs");// ✅ Correct method call
      blogs.assignAll(fetchedBlogs);
    } catch (e) {
      print("Error fetching blogs: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchBlogDetails(int blogId) async {
    try {
      isLoading(true);
      var fetchedBlog = await _settingService.fetchBlogDetails(blogId);
      blogDetails.value = fetchedBlog;
    } catch (e) {
      print("Error fetching blog details: $e");
    } finally {
      isLoading(false);
    }
  }
}
