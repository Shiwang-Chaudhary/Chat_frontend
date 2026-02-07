import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pdfrx/pdfrx.dart';

import '../controllers/pdf_open_controller.dart';

class PdfOpenView extends GetView<PdfOpenController> {
  const PdfOpenView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    final String pdfUrl = args["pdfUrl"];
    final String fileName = args["fileName"] ?? "PDF File";

    return Scaffold(
      appBar: AppBar(title: Text(fileName, overflow: TextOverflow.ellipsis)),

      body: PdfViewer.uri(
        Uri.parse(pdfUrl),

        // ✅ Loading indicator

        // ✅ Error widget
      ),
    );
  }
}
