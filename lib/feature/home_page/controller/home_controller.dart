import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:any_docs/core/constant/url_constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class HomePageController extends GetxController{
  // late StreamSubscription _intentSub;
  final _sharedFiles = <SharedMediaFile>[];
  RxBool isPasswordProtected = false.obs;
  TextEditingController passwordTextController = TextEditingController();

  @override
  void onInit() {
    // Listen to media sharing coming from outside the app while the app is in the memory.
    ReceiveSharingIntent.getMediaStream().listen((value) {
      debugPrint("app is in memory");
      print(value);
      debugPrint("app is in memory");
        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        print(_sharedFiles.map((f) => f.toMap()));
    }, onError: (err) {
      debugPrint("getIntentDataStream error: $err");
    });

    // Get the media sharing coming from outside the app while the app is closed.
    ReceiveSharingIntent.getInitialMedia().then((value) async {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        debugPrint("app is in closed");
        print(value);
        debugPrint("app is in closed");
        print(_sharedFiles.map((f) => f.toMap()));
        if(_sharedFiles[0].path.contains(".pdf")){
          Get.toNamed(RouteConstant.pdfViewerPage,arguments: [_sharedFiles[0].path, _sharedFiles[0].path.substring(0,12)]);
        }
        ReceiveSharingIntent.reset();
    });

    super.onInit();
  }


  onPdfButtonPressed() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf']);
      String fileName = result?.files[0].name ?? '';
      debugPrint(result.toString());
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        bool isEncrypted(List<int> bytes) {
          final signature = bytes.sublist(0, 8);
          final String hexSignature = signature.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
          log('hexSignature.toUpperCase()');
          log('hex string: ${hexSignature.toUpperCase()}');
          return hexSignature.toUpperCase() == '255044462D312E34'; // PDF header signature
        }

        File file = File(files[0].path);
        List<int> bytes = await file.readAsBytes();
        // Check if the PDF is encrypted
        if (isEncrypted(bytes)) {
          isPasswordProtected.value = true;
        }
        else{
          isPasswordProtected.value = false;
        }

        if(isPasswordProtected.value == false){
          Get.toNamed(RouteConstant.pdfViewerPage,arguments: [files[0].path,fileName]);
        }
        else{
          Get.defaultDialog(
              title: "Security Alert!",
              content: Column(
                children: [
                  const Text("PDF is password protected."),
                  TextFormField(
                    controller: passwordTextController,
                    decoration: const InputDecoration(
                        labelText: "Enter password"
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {

                        try {
                          Get.back();
                          showDialog(
                            context: Get.overlayContext!,
                            builder: (_) => const Center(
                                child: CircularProgressIndicator()
                            ),
                          );
                          await Future.delayed(const Duration(seconds: 2));
                          Future<List<int>> readDocumentData(String name) async {
                            print("namenamenamenamejg;sdf;name");
                            print(name);

                            File file = File(name);
                            Uint8List bytes = await file.readAsBytes();
                            // Convert bytes to ByteData
                            ByteData byteData = bytes.buffer.asByteData();

                            final ByteData data = byteData;
                            return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
                          }

                          Future<void> launchPdf(List<int> bytes, String fileName) async {
                            Directory? directory = await getExternalStorageDirectory();

                            String path = directory!.path;
                            File file = File('$path/$fileName');
                            await file.writeAsBytes(bytes, flush: true);
                            Get.back();
                            Get.toNamed(RouteConstant.pdfViewerPage,arguments: ['$path/$fileName', fileName]);
                          }

                          PdfDocument document = PdfDocument(
                              inputBytes: await readDocumentData(files[0].path),
                              password: passwordTextController.text);
                          debugPrint('controller.passwordTextController.text');
                          debugPrint(passwordTextController.text);
                          PdfSecurity security = document.security;
                          security.userPassword = '';
                          List<int> bytes = await document.save();
                          document.dispose();
                          await launchPdf(bytes, fileName);
                        }
                        catch (e) {
                          Get.back();
                          if(e.toString().contains('The password is invalid')){
                            Get.defaultDialog(
                                title: 'Invalid Password',
                                content: ElevatedButton(onPressed: () {
                                  Get.back();
                                }, child: const Text('ok'))
                            );
                          }
                        }

                      },
                      child: const Text('Enter'))
                ],
              )
          );
        }
      }
      else {
        // User canceled the picker
      }
  }
  
  
  
  

}