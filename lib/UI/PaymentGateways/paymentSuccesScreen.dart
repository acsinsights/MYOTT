import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Home/Main_screen.dart';
import '../../Core/Utils/app_common.dart';
import '../Movie/Controller/Movie_controller.dart';
import '../TvSeries/Controller/tv_series_controller.dart';
import '../Video/Controller/VideoDetailsController.dart'; // Assuming you store MediaType here

class PaymentSuccessScreen extends StatefulWidget {
  final String transactionId;
  final String slug;
  final String contentType;

  const PaymentSuccessScreen({
    super.key,
    required this.transactionId,
    required this.slug,
    required this.contentType,
  });

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  int countdown = 5;
  Timer? _timer;
  bool found = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCountdownAndRedirect();
    });
  }


  void _startCountdownAndRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return; // prevent calling setState or navigation after dispose

      if (countdown == 1) {
        timer.cancel();
        _redirectToContentDetails();
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }


  void _redirectToContentDetails() {
    Get.until((route) {
      if (route.settings.name == '/moviedetails' ||
          route.settings.name == '/tvSeriesDetails' ||
          route.settings.name == '/videoDetails') {
        found = true;
        return true;
      }
      return false;
    });

    if (!found) {
      if (widget.contentType == MediaType.movie.name) {
        Get.offNamed('/movieDetails', arguments: {'slug': widget.slug});
      } else if (widget.contentType == MediaType.series.name) {
        Get.offNamed('/verticalPlayer', arguments: {'slug': widget.slug});
      } else if (widget.contentType == MediaType.video.name) {
        Get.offNamed('/videoDetails', arguments: {'slug': widget.slug});
      }else{
        Get.offAll(MainScreen());
      }
    }

    // 🔄 Refresh the correct content controller
    if (widget.contentType == MediaType.movie.name) {
      final controller = Get.put(MovieController());
      controller.fetchMovieDetails(widget.slug);
    } else if (widget.contentType == MediaType.series.name) {
      final controller = Get.find<TVSeriesController>();
      controller.fetchTVSeriesDetails(widget.slug);
    } else if (widget.contentType == MediaType.video.name) {
      final controller = Get.find<VideoDetailsController>();
      controller.fetchVideoDetails(widget.slug);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/paymentSucces.png',
              height: 240,
            ),
            const SizedBox(height: 32),
            const Text(
              "Payment Successful!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Your transaction ID is:\n${widget.transactionId}\n\nYou’ll be redirected in $countdown seconds...",
              style: const TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Go Now",
                onPressed: _redirectToContentDetails,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
