import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myott/services/ActorService.dart';
import '../Model/ActorDetailsModel.dart';

class ActorController extends GetxController {
  final ActorSerivce _actorService;
  final int actorId;

  var actorData = Rxn<ActorDetialsModel>();
  var isLoading = false.obs;
  var showTitle = false.obs;
  ScrollController scrollController = ScrollController();

  ActorController(this._actorService, this.actorId);

  @override
  void onInit() {
    super.onInit();
    fetchActorDetails();

    // Listen to scroll changes
    scrollController.addListener(() {
      if (scrollController.offset > 300) {
        showTitle.value = true; // Show title when scrolled down
      } else {
        showTitle.value = false; // Hide title when at top
      }
    });
  }

  void fetchActorDetails() async {
    try {
      isLoading.value = true;
      var fetchedActorDetails = await _actorService.fetchActorsDetails(actorId);
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
