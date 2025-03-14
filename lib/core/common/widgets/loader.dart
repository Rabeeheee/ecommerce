import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.totalImages});

  final int? totalImages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lotties/loading_lottie.json',
              height: 25,
              width: 25,
            ),
            const SizedBox(height: 20),
            if (totalImages != null)
              LoadingTextWidget(totalImages: totalImages!),
          ],
        ),
      ),
    );
  }
}

class LoadingTextWidget extends StatefulWidget {
  final int totalImages;

  const LoadingTextWidget({super.key, required this.totalImages});

  @override
  State<StatefulWidget> createState() {
   return _LoadingTextWidgetState();
  }
}

class _LoadingTextWidgetState extends State<LoadingTextWidget> {
  int currentImageIndex = 0;
  bool isLoadingComplete = false;

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  void startLoading() {
    // Simulate loading progress
    Future.delayed(const Duration(seconds: 1), () {
      if (currentImageIndex < widget.totalImages) {
        setState(() {
          currentImageIndex++;
        });
        startLoading();
      } else {
        setState(() {
          isLoadingComplete = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLoadingComplete)
          Text(
            'Uploading image $currentImageIndex of ${widget.totalImages}',
            style: const TextStyle(fontSize: 16),
          ),
        if (isLoadingComplete)
          const Text(
            'Please wait till the product is verified',
            style: TextStyle(fontSize: 16),
          ),
      ],
    );
  }
}
