import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:any_docs/core/constant/url_constant.dart';
import 'package:any_docs/core/utils/loaderScreen.dart';
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
import 'package:flutter_native_splash/flutter_native_splash.dart';


class HomePageController extends GetxController {
  
  final _sharedFiles = <SharedMediaFile>[];
  RxBool isPasswordProtected = false.obs;
  RxBool openGallery = false.obs;
  RxBool showLoader = false.obs;
  TextEditingController passwordTextController = TextEditingController();

  @override
  void onInit() {
    FlutterNativeSplash.remove();

    
    ReceiveSharingIntent.getMediaStream().listen((value) {
      _sharedFiles.clear();
      _sharedFiles.addAll(value);
      debugPrint("app is in memory");
      print(value);
      debugPrint("app is in memory");
      print(_sharedFiles.map((f) => f.toMap()));
      if (value.isNotEmpty) {
        if (_sharedFiles[0].path.contains(".pdf")) {
              print('_sharedFiles[0].path',);
              print(_sharedFiles[0].path,);
              print(  _sharedFiles[0].path.substring(0, 12));
          Get.toNamed(RouteConstant.pdfViewerPage, arguments: [
            _sharedFiles[0].path,
            _sharedFiles[0].path.substring(0, 12)
          ]);
          ReceiveSharingIntent.reset();
        }
      }
      ReceiveSharingIntent.reset();
    }, onError: (err) {
      debugPrint("getIntentDataStream error: $err");
    });

    
    ReceiveSharingIntent.getInitialMedia().then((value) async {
      _sharedFiles.clear();
      _sharedFiles.addAll(value);
      debugPrint("app is in closed");
      print(value);
      debugPrint("app is in closed");
      print(_sharedFiles.map((f) => f.toMap()));
      if (value.isNotEmpty) {
        if (_sharedFiles[0].path.contains(".pdf")) {
          Get.toNamed(RouteConstant.pdfViewerPage, arguments: [
            _sharedFiles[0].path,
            _sharedFiles[0].path.substring(0, 12)
          ]);
        }
        ReceiveSharingIntent.reset();
      }
      ReceiveSharingIntent.reset();
    });

    super.onInit();
  }

  onPdfButtonPressed() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.custom, allowedExtensions: ['pdf']);
    String fileName = result?.files[0].name ?? '';
    debugPrint(result.toString());
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      bool isEncrypted(List<int> bytes) {
        final signature = bytes.sublist(0, 8);
        final String hexSignature =
        signature.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
        log('hexSignature.toUpperCase()');
        log('hex string: ${hexSignature.toUpperCase()}');
        return hexSignature.toUpperCase() ==
            '255044462D312E34'; 
      }

      File file = File(files[0].path);
      List<int> bytes = await file.readAsBytes();
      
      if (isEncrypted(bytes)) {
        isPasswordProtected.value = true;
      } else {
        isPasswordProtected.value = false;
      }

      if (isPasswordProtected.value == false) {
        Get.toNamed(RouteConstant.pdfViewerPage,
            arguments: [files[0].path, fileName]);
      } else {
        Get.defaultDialog(
            title: "Security Alert!",
            content: Column(
              children: [
                const Text("PDF is password protected."),
                TextFormField(
                  controller: passwordTextController,
                  decoration:
                  const InputDecoration(labelText: "Enter password"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        Get.back();
                        showDialog(
                          context: Get.overlayContext!,
                          builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                        );
                        await Future.delayed(const Duration(seconds: 2));
                        Future<List<int>> readDocumentData(String name) async {
                          print("namenamenamenamejg;sdf;name");
                          print(name);

                          File file = File(name);
                          Uint8List bytes = await file.readAsBytes();
                          
                          ByteData byteData = bytes.buffer.asByteData();

                          final ByteData data = byteData;
                          return data.buffer.asUint8List(
                              data.offsetInBytes, data.lengthInBytes);
                        }

                        Future<void> launchPdf(
                            List<int> bytes, String fileName) async {
                          Directory? directory =
                          await getExternalStorageDirectory();

                          String path = directory!.path;
                          File file = File('$path/$fileName');
                          await file.writeAsBytes(bytes, flush: true);
                          Get.back();
                          Get.toNamed(RouteConstant.pdfViewerPage,
                              arguments: ['$path/$fileName', fileName]);
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
                      } catch (e) {
                        Get.back();
                        if (e.toString().contains('The password is invalid')) {
                          Get.defaultDialog(
                              title: 'Invalid Password',
                              content: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('ok')));
                        }
                      }
                    },
                    child: const Text('Enter'))
              ],
            ));
      }
    } else {
      
    }
  }

  Future<void> convertImageToPdf() async {
    final ImagePicker picker = ImagePicker();
    PdfDocument document = PdfDocument();

    if (openGallery.value == true) {
      final List<XFile> pickedFile = await picker.pickMultiImage(
          imageQuality: 100,
          maxHeight: 1000, 
          maxWidth: 1000); 
      if (pickedFile.isNotEmpty) {
        showLoader.value==true?showDialog(
          context: Get.overlayContext!,
          barrierDismissible: true,
          builder: (_) => PopScope(
            canPop:  false,
            onPopInvoked: (didPop) {
            },
            child:  Center(child: Loading()),
          ),
        ): const Center();

        showLoader.value=true;

        for (var image in pickedFile) {
          PdfPage page = document.pages.add(); 
          final PdfImage bitImage = PdfBitmap(await _readImageData(image));
          page.graphics.drawImage(
              bitImage, Rect.fromLTWH(0, 0, page.size.width, page.size.height));
        }
        List<int> bytes = await document.save();
        document.dispose();
        
        saveAndLaunchFile(bytes, '${DateTime.now().toString().replaceAll('-', '').replaceAll(':', '').replaceAll('.', '').trim()}.pdf');
      } else {
        
      }
    } else {
      XFile? cameraFile = await picker.pickImage(source: ImageSource.camera);
      if(cameraFile != null){
        showLoader.value=true;
        showLoader.value==true?showDialog(
          context: Get.overlayContext!,
          barrierDismissible: true,
          builder: (_) => PopScope(
            canPop:  false,
            onPopInvoked: (didPop) {
            },
            child:  Center(child: Loading()),
          ),
        ): const Center();

        PdfPage page = document.pages.add(); 
        final PdfImage image = PdfBitmap(await _readImageData(cameraFile));
        page.graphics.drawImage(
            image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));
        List<int> bytes = await document.save();
        document.dispose();
        
        saveAndLaunchFile(bytes, '${DateTime.now().toString().replaceAll('-', '').replaceAll(':', '').replaceAll('.', '').trim()}.pdf');
      }
    }
    
  }

  Future<List<int>> _readImageData(name) async {
    var data = await name!.readAsBytes(); 
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {

    
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
      Get.back();
      Get.back();
      showLoader.value=false;
      await open_file.OpenFile.open(
          '$path/$fileName'); 
     } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'],
          runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }
}
