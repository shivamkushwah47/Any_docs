import 'package:any_docs/core/utils/app_colour.dart';
import 'package:any_docs/feature/pdf_viewer_view/controller/pdf_viewer_controller.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PdfViewerPage extends GetView<PdfViewerController>{
  const PdfViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Material(child: WillPopScope(
       onWillPop: () async {
         
         return true;
       },
       child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
         onTap:(){
           Get.back();
         },
                child:
                Icon(Icons.arrow_back,color: whiteColor,)
            ),

            backgroundColor: Colors.red[900],
            title: Text('${controller.fileName.substring(0,5)}...',style: TextStyle(fontWeight: FontWeight.normal,color: whiteColor),),
       actions: [
         Obx(()=> Padding(
           padding: EdgeInsets.only(right: Get.width*0.05),
           child: Text('${controller.currentPage.value}/${controller.totalPages.value}',style: TextStyle(fontWeight: FontWeight.normal,color: whiteColor),),
         )),
         IconButton(
           icon:  Icon(Icons.share,color: whiteColor,),
           
           tooltip: 'Download',
           onPressed: () async {
             print("on press hit");
             if (controller.filePath != null) {
               await Share.shareXFiles(
                 [XFile(controller.filePath)],
                 sharePositionOrigin: Rect.fromCircle(
                   radius: Get.width * 0.25,
                   center: const Offset(0, 0),
                 ),
               );
             } else {
               
             }


               
           },
         ),

       ],
     ),
     
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
           
           
       },
       onError: (error) {
         print(error.toString());
       },
       onPageError: (page, error) {
         print('$page: ${error.toString()}');
       },
       onViewCreated: (PDFViewController pdfViewController) {
         
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
   )));
  }

}