import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myott/services/ActorService.dart';
import '../Model/ActorDetailsModel.dart';

class ActorController extends GetxController {
  final ActorSerivce _actorService =ActorSerivce();

  var actorData = Rxn<ActorDetailsModel>();
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

  void fetchActorDetails(String actorSlug) async {
    try {
      isLoading.value = true;
      var fetchedActorDetails = await _actorService.fetchActorsDetails(actorSlug);
      if (fetchedActorDetails != null) {
        actorData.value = fetchedActorDetails;
      } else {
        print("Failed to fetch actor details");
      }
    } catch (e) {
      print("Error fetching actor details: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
