import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Director/Model/DirectorModel.dart';
import 'package:myott/services/DirectorService.dart'; // updated service

class DirectorController extends GetxController {
  final DirectorService _directorService = DirectorService(); // updated class

  var directorData = Rxn<DirectorDetailsModel>();
  var isLoading = false.obs;
  var showTitle = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.offset > 300) {
        showTitle.value = true;
      } else {
        showTitle.value = false;
      }
    });
  }

  void fetchDirectorDetails(String directorSlug) async {
    try {
      isLoading.value = true;
      var fetchedDirectorDetails = await _directorService.fetchDirectorDetails(directorSlug);
      if (fetchedDirectorDetails != null) {
        directorData.value = fetchedDirectorDetails;
      } else {
        print("Failed to fetch director details");
      }
    } catch (e) {
      print("Error fetching director details: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
