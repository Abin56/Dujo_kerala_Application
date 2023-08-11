import 'dart:developer';
import 'dart:io';

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_flutter/pdf_viewer_flutter.dart';

class PDFSectionScreen extends StatefulWidget {
  var urlPdf;
  PDFSectionScreen({super.key, required this.urlPdf});
  @override
  // ignore: library_private_types_in_public_api
  _PDFSectionScreenState createState() => _PDFSectionScreenState();
}

class _PDFSectionScreenState extends State<PDFSectionScreen> {
  String _pefFilePath = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((file) {
      setState(() {
        _pefFilePath = file.path;
        print(_pefFilePath);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    log("Pdf url Data >>>>>>>>>>>>>>>>>>>${widget.urlPdf}<<<<<<<");
    final url = widget.urlPdf;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    routingPDfPage(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Loading ...  "),
          backgroundColor: adminePrimayColor,
        ),
        body: const Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        )),
      ),
    );
  }

  Future<void> routingPDfPage(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    // ignore: use_build_context_synchronously
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PDFViewerScaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              backgroundColor: adminePrimayColor,
              title: const Text("PDF"),
              automaticallyImplyLeading: false,
            ),
            path: _pefFilePath);
      },
    ));
  }
}
