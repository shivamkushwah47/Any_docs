import 'package:any_docs/feature/pdf_viewer_view/controller/pdf_viewer_controller.dart';
import 'package:get/get.dart';

class PdfViewerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PdfViewerController());
  }

}