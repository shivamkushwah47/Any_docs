import 'package:any_docs/feature/docx_viewer/controller/docx_viewer_controller.dart';
import 'package:get/get.dart';

class DocxViewerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(DocxViewerController());
  }

}