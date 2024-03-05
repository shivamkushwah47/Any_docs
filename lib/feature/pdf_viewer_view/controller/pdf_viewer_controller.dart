import 'package:get/get.dart';

class PdfViewerController extends GetxController {
  dynamic arguments;

  String filePath = '';
  String fileName = '';
  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

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
