import 'package:any_docs/core/constant/url_constant.dart';
import 'package:any_docs/core/utils/app_colour.dart';
import 'package:any_docs/feature/home_page/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Center(
          child: Text('Any Docs',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    controller.onPdfButtonPressed();
                  },
                  child: Text(
                    'Open PDF',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: appColor),
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    Get.snackbar("Hii Snow", "i will fix it after sometime",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundGradient:
                            LinearGradient(begin: Alignment.topCenter, colors: [
                          Colors.red[500]!,
                          Colors.red[400]!,
                          Colors.red[300]!,
                        ]));

                    Get.toNamed(RouteConstant.docxViewerPage);
                    return;
                  },
                  child: Text(
                    'Open DOCX',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: appColor),
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.snackbar("Hii Snow", "i will fix it after sometime",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundGradient:
                            LinearGradient(begin: Alignment.topCenter, colors: [
                          Colors.red[500]!,
                          Colors.red[400]!,
                          Colors.red[300]!,
                        ]));
                  },
                  child: Text(
                    'Open XLS',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: appColor),
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.bottomSheet(
                        backgroundColor: Colors.white,
                        barrierColor: Colors.red[50],
                        isDismissible: true,
                        enableDrag: true,
                        SizedBox(
                          height: Get.height * 0.20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/camera.jpg',
                                      height: Get.height * 0.15,
                                      width: Get.width * 0.20,
                                    ),
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: appColor),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  controller.openGallery.value = false;
                                  controller.convertImageToPdf();
                                },
                              ),
                              InkWell(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/gallery.png',
                                        height: Get.height * 0.15,
                                        width: Get.width * 0.20,
                                      ),
                                      Text(
                                        'Gallery',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: appColor),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    controller.openGallery.value = true;
                                    controller.convertImageToPdf();
                                  }),
                            ],
                          ),
                        ));
                  },
                  child: Text(
                    'Convert Image to PDF',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: appColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
