import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocxViewerView extends GetView{
  const DocxViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Docx',style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

}