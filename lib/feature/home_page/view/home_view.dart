import 'package:any_docs/core/constant/url_constant.dart';
import 'package:any_docs/feature/home_page/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: const Text('Any Docs',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(height:  Get.height*0.05),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width * 0.90, Get.height * 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      controller.onPdfButtonPressed();
                    },
                    child: const Text('Open PDF')),
                SizedBox(height:  Get.height*0.05),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width * 0.90, Get.height * 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      // Get.toNamed(RouteConstant.docxViewerPage);
                      // return;

                      /*FilePickerResult? result = await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          type: FileType.custom,
                          allowedExtensions: ['JPEG','PNG']);
                      var fileName = result?.names[0];
                      if (result != null) {
                        List<File> files = result.paths.map((path) => File(path!)).toList();
                        Get.toNamed(RouteConstant.docxViewerPage,arguments: [files[0].path,fileName]);
                      }
                      else {
                        // User canceled the picker
                      }*/
                    },
                    child: const Text('Open DOCX')),
                SizedBox(height:  Get.height*0.05),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width * 0.90, Get.height * 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Open XLS')),
                SizedBox(height:  Get.height*0.05),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(Get.width * 0.90, Get.height * 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Get.bottomSheet(

                        backgroundColor: Colors.white,
                        SizedBox( height: Get.height*0.20,
                          child: Container(
                            height: 10,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  // SizedBox(width: 20,),
                                  InkWell(child:
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     crossAxisAlignment: CrossAxisAlignment.center,

                                     children: [
                                       Image.asset(
                                         'assets/camera.jpg',
                                         height: Get.height*0.15,
                                         width: Get.width*0.20,
                                       ), //
                                      const Text('Camera',),
                                     ],
                                   ) ,
                                  onTap: (){

                                    controller.openGallery.value = false;
                                    controller.convertImageToPdf();

                                  },
                                  ),
                                  // SizedBox(width: 20,),

                                  InkWell(child:Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [
                                      Image.asset(
                                        'assets/gallery.png',
                                        height: Get.height*0.15,
                                        width: Get.width*0.20,
                                      ), //
                                      const Text('Gallery',),
                                    ],
                                  ) ,
                                      onTap: (){
                                    controller.openGallery.value = true;
                                    controller.convertImageToPdf();

                                      }),
                                ],
                              ),
                          )
                        ),
                        // barrierColor: Colors.red[50],
                        isDismissible: true,
                        enableDrag: true,


                      );
                    },
                    child: const Text('Convert Image to PDF')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
