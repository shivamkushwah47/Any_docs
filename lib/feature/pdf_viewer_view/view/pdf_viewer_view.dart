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
         // Get.snackbar("Press back arrow", "",snackPosition: SnackPosition.BOTTOM);
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
           // icon: const Icon(Icons.more_vert),
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
               // Fluttertoast.showToast(msg: "Failed to share");
             }


             /*  PopupMenuButton<int>(
               offset: Offset(0, 100),
               color: Colors.grey,
               elevation: 2,

               itemBuilder: (context) => [
                 // PopupMenuItem 1
                 const PopupMenuItem(
                   value: 1,
                   // row with 2 children
                   child: Row(
                     children: [
                       Icon(Icons.star),
                       SizedBox(
                         width: 10,
                       ),
                       Text("Get The App")
                     ],
                   ),
                 ),
                 // PopupMenuItem 2
               const  PopupMenuItem(
                   value: 2,
                   // row with two children
                   child: Row(
                     children: [
                       Icon(Icons.chrome_reader_mode),
                       SizedBox(
                         width: 10,
                       ),
                       Text("About")
                     ],
                   ),
                 ),
               ],
               // on selected we show the dialog box
               onSelected: (value) {
                 // if value 1 show dialog
                 if (value == 1) {
                   // _showDialog(context);
                   // if value 2 show dialog
                 } else if (value == 2) {
                   // _showDialog(context);
                 }
               },
             );
           */  // handle the press
           },
         ),

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
   )));
  }

}