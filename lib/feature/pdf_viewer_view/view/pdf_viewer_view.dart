import 'package:any_docs/feature/pdf_viewer_view/controller/pdf_viewer_controller.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PdfViewerPage extends GetView<PdfViewerController>{
  const PdfViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.white,
       title: Text(controller.fileName),
       actions: [
         Obx(()=> Padding(
           padding: EdgeInsets.only(right: Get.width*0.05),
           child: Text('${controller.currentPage.value}/${controller.totalPages.value}',style: TextStyle(fontWeight: FontWeight.normal),),
         ))
       ],
     ),
     // body: DocumentViewer(filePath: controller.files,),
     body: PDFView(
       filePath: controller.filePath,
       enableSwipe: true,
       swipeHorizontal: false,
       autoSpacing: false,
       pageFling: false,
       onRender: (_pages) {
         print("_pages.toString()");
         print(_pages.toString());
         controller.totalPages.value = _pages.toString();
           // pages = _pages;
           // isReady = true;
       },
       onError: (error) {
         print(error.toString());
       },
       onPageError: (page, error) {
         print('$page: ${error.toString()}');
       },
       onViewCreated: (PDFViewController pdfViewController) {
         // _controller.complete(pdfViewController);
       },
       onPageChanged: (int? page, int? total) {
         if(page != null && total != null){
         print('page change: ${page++}/$total');
         controller.currentPage.value = page++;
         }
         else{
           controller.currentPage.value = 0;
         }

       },
     ),
   );
  }

}