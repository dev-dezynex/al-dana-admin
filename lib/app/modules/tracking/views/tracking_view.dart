import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../data/constants/api_routes.dart';
import '../../../data/theme/colors.dart';
import '../../../data/theme/styles.dart';
import '../providers/tracking_provider.dart';

class TrackingView extends StatefulWidget {
  final String bookingId;
  const TrackingView({super.key, required this.bookingId});

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  @override
  void initState() {
    super.initState();
    Provider.of<TrackingProvider>(context, listen: false)
        .fetchTracking(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final track = Provider.of<TrackingProvider>(context);
    final tracking = Provider.of<TrackingProvider>(context).tracking?.data?[0];
    final trackingStatus = Provider.of<TrackingProvider>(context)
        .tracking
        ?.data?[0]
        .trackingStatus;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: const Text(
            'Tracking Status',
            style: TextStyle(color: white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: white,
            ),
          ),
          bottom: const TabBar(tabs: [
            Tab(text: 'Tracking Progress'),
            Tab(text: 'Images'),
          ]),
        ),
        body: track.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primary,
                ),
              )
            : track.hasError
                ? const Center(
                    child: Text('Error'),
                  )
                : TabBarView(
                    children: [
                      TrackingStatusTab(
                        trackingStatus: trackingStatus,
                        bookingId: widget.bookingId,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              'Before Image',
                              style: tsPoppins(
                                weight: FontWeight.w600,
                                color: textDark80,
                                size: 18,
                              ),
                            ),
                            Container(
                              height: 2,
                              width: 30,
                              decoration: BoxDecoration(
                                color: accent60,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            if (tracking!.beforeImage!.isNotEmpty ||
                                tracking.beforeImage != [] ||
                                tracking.beforeImage != null)
                              SizedBox(
                                height: height * 0.3,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tracking.beforeImage!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.network(
                                        "$domainName${tracking.beforeImage?[index]}",
                                        height: height * 0.3,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Text('No Image');
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            GestureDetector(
                              onTap: () {
                                _pickImages(tracking.sId ?? '', 'beforeImage');
                              },
                              child: CircleAvatar(
                                radius: height * 0.02,
                                child: Icon(
                                  Icons.add,
                                  size: height * 0.02,
                                ),
                              ),
                            ),
                            Text(
                              'After Image',
                              style: tsPoppins(
                                weight: FontWeight.w600,
                                color: textDark80,
                                size: 18,
                              ),
                            ),
                            Container(
                              height: 2,
                              width: 30,
                              decoration: BoxDecoration(
                                color: accent60,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            if (tracking.afterImage!.isNotEmpty ||
                                tracking.afterImage != [] ||
                                tracking.afterImage != null)
                              SizedBox(
                                height: height * 0.3,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tracking.afterImage!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.network(
                                        "$domainName${tracking.afterImage?[index]}",
                                        height: height * 0.3,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Text('No Image');
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            GestureDetector(
                              onTap: () {
                                _pickImages(tracking.sId ?? '', 'afterImage');
                              },
                              child: CircleAvatar(
                                radius: height * 0.02,
                                child: Icon(
                                  Icons.add,
                                  size: height * 0.02,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Future<void> _pickImages(String trackingId, String key) async {
    final picker = ImagePicker();
    List<File> images = [];
    final pickedFiles = await picker.pickMultiImage(
        maxWidth: 200, maxHeight: 200, imageQuality: 100);
    if (pickedFiles.isNotEmpty) {
      for (XFile image in pickedFiles) {
        var imagesTemporary = File(image.path);
        images.add(imagesTemporary);
      }
      log('image length');
      log(images.length.toString());
      // List<File> images =
      //     pickedFiles.map((imageXFile) => File(imageXFile.path)).toList();
      List<String> imageStrings =
          await TrackingProvider().uploadImageFiles(images);
      log("imageStrings");
      log(imageStrings.toString());
      if (imageStrings.isNotEmpty) {
        log('booking id');
        log(widget.bookingId);
        TrackingProvider()
            .addBeforeOrAfterImage(trackingId, key, imageStrings)
            .then(
              (_) => Provider.of<TrackingProvider>(context, listen: false)
                  .fetchTracking(widget.bookingId),
            );
      }
    }
  }
}

class TrackingStatusTab extends StatelessWidget {
  const TrackingStatusTab({
    super.key,
    required this.trackingStatus,
    required this.bookingId,
  });

  final String? trackingStatus;
  final String? bookingId;

  @override
  Widget build(BuildContext context) {
    final tracking = Provider.of<TrackingProvider>(context).tracking?.data?[0];
    return Column(
      children: [
        Stepper(
          controlsBuilder: (context, details) => const SizedBox(),
          currentStep: 3,
          steps: <Step>[
            Step(
              isActive: trackingStatus == 'Pending',
              title: const Text('Pending'),
              content: const Text(''),
            ),
            Step(
              isActive: trackingStatus == 'Started',
              title: const Text('Started'),
              content: const Text('Content for Step 2'),
            ),
            Step(
              isActive: trackingStatus == 'On Progress',
              title: const Text('On Progress'),
              content: const Text(''),
            ),
            Step(
              isActive: trackingStatus == 'Completed',
              title: const Text('Completed'),
              content: const Text(''),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            log(trackingStatus.toString());
            log(tracking!.sId!);
            if (trackingStatus.toString() == "Pending") {
              TrackingProvider()
                  .changeTrackingStatus(tracking.sId ?? '', 'Started');

              Provider.of<TrackingProvider>(context, listen: false)
                  .fetchTracking(bookingId ?? '');
            } else if (trackingStatus.toString() == "Started") {
              TrackingProvider()
                  .changeTrackingStatus(tracking.sId ?? '', 'On Progress');

              Provider.of<TrackingProvider>(context, listen: false)
                  .fetchTracking(bookingId ?? '');
            } else if (trackingStatus.toString() == "On Progress") {
              TrackingProvider()
                  .changeTrackingStatus(tracking.sId ?? '', 'Completed');

              Provider.of<TrackingProvider>(context, listen: false)
                  .fetchTracking(bookingId ?? '');
            } else {
              Get.snackbar('Sorry', 'Progress is completed',
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
          child: const Text('Change status'),
        ),
      ],
    );
  }
}
