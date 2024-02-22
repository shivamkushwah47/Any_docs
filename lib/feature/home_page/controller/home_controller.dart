import 'dart:async';

import 'package:any_docs/core/constant/url_constant.dart';
import 'package:get/get.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class HomePageController extends GetxController{
  late StreamSubscription _intentSub;
  final _sharedFiles = <SharedMediaFile>[];

  @override
  void onInit() {
    // Listen to media sharing coming from outside the app while the app is in the memory.
    _intentSub = ReceiveSharingIntent.getMediaStream().listen((value) {
      print("app is in memory");
      print(value);
      print("app is in memory");
        _sharedFiles.clear();
        _sharedFiles.addAll(value);

        print(_sharedFiles.map((f) => f.toMap()));

    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // Get the media sharing coming from outside the app while the app is closed.
    ReceiveSharingIntent.getInitialMedia().then((value) async {
      // setState(() {
        _sharedFiles.clear();
        _sharedFiles.addAll(value);
        print("app is in closed");
        print( await value);
        print("app is in closed");

        print(_sharedFiles.map((f) => f.toMap()));
        print('_sharedFiles[0]');
        print(_sharedFiles[0]);
        print(_sharedFiles[0].path);
        print(_sharedFiles[0].path.contains(".pdf"));
        if(_sharedFiles[0].path.contains(".pdf")){
          Get.toNamed(RouteConstant.pdfViewerPage,arguments: [_sharedFiles[0].path, _sharedFiles[0].path.substring(0,12)]);
        }
        ReceiveSharingIntent.reset();
      // });
    });

    super.onInit();
  }

}