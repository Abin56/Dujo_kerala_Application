import 'dart:developer';
import 'dart:io';

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
    log(widget.urlPdf);
    routingPDfPage(context);
    return const Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.red,
      )),
    );
  }

  routingPDfPage(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));


    // ignore: use_build_context_synchronously
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PDFViewerScaffold(path: _pefFilePath);
      },
    ));
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String? pefFilePath;
  const PDFViewerScreen(this.pefFilePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
               Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("PDF Document"),
        ),
        path: pefFilePath);
  }
}