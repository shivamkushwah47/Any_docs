import 'dart:io';

import 'package:any_docs/core/constant/url_constant.dart';
import 'package:any_docs/core/utils/app_colour.dart';
import 'package:any_docs/feature/home_page/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        actions: [
          IconButton(
            color: whiteColor,
              onPressed: () {
                exit(0);
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      /*body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width,
              height: 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
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
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width,
              height: 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(

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
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width,
              height: 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
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
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width,
              height: 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.bottomSheet(
                        backgroundColor: Colors.white,
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
            ),
          ],
        ),
      ),*/
      body:  GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
          childAspectRatio: 0.85, // Aspect ratio of each child (width / height)
        ),
        children: [
          InkWell(
            onTap: () {
              controller.onPdfButtonPressed();
            },
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.picture_as_pdf, size: 50,color: Colors.red[400]), // Example icon
                  Text('Open pdf',style: TextStyle(color: Colors.red[400])), // Example text
                ],
              ),

            ),
          ),
          InkWell(
            onTap: () {
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
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(CupertinoIcons.doc_fill,size: 50,color: Colors.red[400]), // Example icon
                  Text('Open docx',style: TextStyle(color: Colors.red[400])), // Example text
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.snackbar("Hii Snow", "i will fix it after sometime",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundGradient:
                  LinearGradient(begin: Alignment.topCenter, colors: [
                    Colors.red[500]!,
                    Colors.red[400]!,
                    Colors.red[300]!,
                  ]));
            },
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.fileExcel, size: 50,color: Colors.red[400]), // Example icon
                  Text('Open xls',style: TextStyle(color: Colors.red[400])), // Example text
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.bottomSheet(
                  backgroundColor: Colors.white,
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
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.image, size: 50,color: Colors.red[400]), // Example icon
                  Text('Image to pdf',style: TextStyle(color: Colors.red[400])), // Example text
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
