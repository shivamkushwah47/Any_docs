import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:any_docs/core/constant/url_constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:image_picker/image_picker.dart' as pic;


class HomePageController extends GetxController{
  // late StreamSubscription _intentSub;
  final _sharedFiles = <SharedMediaFile>[];
  RxBool isPasswordProtected = false.obs;
  RxBool openGallery = false.obs;
  TextEditingController passwordTextController = TextEditingController();

  @override
  void onInit() {
    // Listen to media sharing coming from outside the app while the app is in the memory.
    ReceiveSharingIntent.getMediaStream().listen((value) {

        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        debugPrint("app is in memory");
        print(value);
        debugPrint("app is in memory");
        print(_sharedFiles.map((f) => f.toMap()));
        if(value.isNotEmpty){

          if(_sharedFiles[0].path.contains(".pdf")){
          Get.toNamed(RouteConstant.pdfViewerPage,arguments: [_sharedFiles[0].path, _sharedFiles[0].path.substring(0,12)]);
          ReceiveSharingIntent.reset();

          }}
        ReceiveSharingIntent.reset();

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
        if(value.isNotEmpty){
        if(_sharedFiles[0].path.contains(".pdf")){
          Get.toNamed(RouteConstant.pdfViewerPage,arguments: [_sharedFiles[0].path, _sharedFiles[0].path.substring(0,12)]);
        }
        ReceiveSharingIntent.reset();

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


  Future<void> convertImageToPdf() async {
    final ImagePicker _picker = ImagePicker();

    //Create the PDF document
    PdfDocument document = PdfDocument();

    //Add the page
    PdfPage page = document.pages.add();


    /*

    List<XFile> selectedImages = []; // List of selected image

    final pickedFile = await _picker.pickMultiImage(
        imageQuality: 100, // To set quality of images
        maxHeight: 1000, // To set maxheight of images that you want in your app
        maxWidth: 1000); // To set maxheight of images that you want in your app
    List<XFile> xfilePick = pickedFile;

    // if atleast 1 images is selected it will add
    // all images in selectedImages
    // variable so that we can easily show them in UI
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(XFile(xfilePick[i].path));
      }
     } else {
      // If no image is selected it will show a
      // snackbar saying nothing is selected
    }
*/

// var cameraFile = await _picker.pickMultiImage();
    var cameraFile;
    if(openGallery.value==true) {
      cameraFile = await _picker.pickImage(source: ImageSource.gallery);
    }else {
      cameraFile = await _picker.pickImage(source: ImageSource.camera);
    }    // final bytes = await cameraFile!.readAsBytes(); // Converts the file to UInt8List

    final PdfImage image = PdfBitmap(await _readImageData(cameraFile));
    // final PdfImage image = PdfBitmap(await _readImageData(selectedImages));
    // List<int> imageBytes = cameraFile?.readAsBytes();

    // final PdfImage image = PdfBitmap(await _readImageData('assets/profile.jpg'));

    //draw image to the first page
    page.graphics.drawImage(
        image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));

    //Save the document
    List<int> bytes = await document.save();

    // Dispose the document
    document.dispose();

    //Save the file and launch/download
    saveAndLaunchFile(bytes, DateTime.now().toString().replaceAll('-', '').replaceAll(':','').replaceAll('.', '').trim()+'.pdf');
  }

  Future<List<int>> _readImageData(name) async {
    var data = await name!.readAsBytes(); // Converts the file to UInt8List

    // final ByteData data = await rootBundle.load('$name');
    // print();
     print( data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
     return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    //Get the storage folder location using path_provider package.
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory =
      await path_provider.getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file =
    File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      //Launch the file (used open_file package)
      print(path);
      print(fileName);
      await open_file.OpenFile.open('$path/$fileName'); // this will give option pdf in another app
      // Get.toNamed(RouteConstant.pdfViewerPage,arguments: [path,fileName]);

    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'], runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }

}