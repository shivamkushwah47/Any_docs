import 'package:get/get.dart';

class PdfViewerController extends GetxController {
  dynamic arguments;

  String filePath = '';
  String fileName = '';
  // Initial Selected Value

  RxInt currentPage = 0.obs;
  RxString totalPages = "".obs;

  @override
  void onInit() {
    arguments = Get.arguments;
    filePath = arguments[0];
    fileName = arguments[1];
    super.onInit();
  }
}
