import 'package:get/get.dart';
import '../../Services/Search_service.dart';
import '../Model/searchable_content.dart';

class CustomSearchController extends GetxController {
  final SearchService _searchService = SearchService();

  var searchResults = <SearchableContent>[].obs; // Observable List
  var isLoading = false.obs;
  var query = "".obs;

  @override
  void onInit() {
    super.onInit();
    debounce(query, (_) {
      if (query.value.isNotEmpty) {
        fetchResults(query.value);
      } else {
        searchResults.clear();
      }
    }, time: Duration(milliseconds: 500));
  }

  void fetchResults(String value) async {
    isLoading.value = true;

    try {
      final results = await _searchService.fetchSearchResults(value);
      if (results.isNotEmpty) {
        searchResults.assignAll(results); // Efficient list update
      } else {
        searchResults.clear();
      }
    } catch (e) {
      print("Search error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updateQuery(String value) {
    if (query.value != value) {
      query.value = value;
    }
  }
}
