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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width * 0.55, Get.height * 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    controller.onPdfButtonPressed();
                  },
                  child: const Text('Open PDF')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width * 0.55, Get.height * 0.1),
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width * 0.55, Get.height * 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Open XLS')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width * 0.55, Get.height * 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Convert Image to PDF')),
            ],
          ),
        ],
      ),
    );
  }
}
