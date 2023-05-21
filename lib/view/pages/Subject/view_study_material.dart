// // import 'dart:developer';
// // import 'dart:io';

// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:pdf_viewer_flutter/pdf_viewer_flutter.dart';

// // class ViewStudyMaterials extends StatefulWidget {
// //   var urlPdf;
// //   ViewStudyMaterials({required this.urlPdf});
// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _ViewStudyMaterialsState createState() => _ViewStudyMaterialsState();
// // }

// // class _ViewStudyMaterialsState extends State<ViewStudyMaterials> {
// //   String _pefFilePath = "";

// //   @override
// //   void initState() {
// //     super.initState();
// //     createFileOfPdfUrl().then((file) {
// //       setState(() {
// //         _pefFilePath = file.path;
// //         print(_pefFilePath);
// //       });
// //     });
// //   }

// //   Future<File> createFileOfPdfUrl() async {
// //     log("Pdf url Data >>>>>>>>>>>>>>>>>>>${widget.urlPdf}<<<<<<<");
// //     final url = widget.urlPdf;
// //     final filename = url.substring(url.lastIndexOf("/") + 1);
// //     var request = await HttpClient().getUrl(Uri.parse(url));
// //     var response = await request.close();
// //     var bytes = await consolidateHttpClientResponseBytes(response);
// //     String dir = (await getApplicationDocumentsDirectory()).path;
// //     File file = new File('$dir/$filename');
// //     await file.writeAsBytes(bytes);
// //     return file;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     routingPDfPage(context);
// //     return const Scaffold(
// //       body: Center(
// //           child: CircularProgressIndicator(
// //         color: Colors.red,
// //       )),
// //     );
// //   }

// //   routingPDfPage(BuildContext context) async {
// //     await Future.delayed(const Duration(seconds: 1));

// //     // ignore: use_build_context_synchronously
// //     Navigator.of(context).push(MaterialPageRoute(
// //       builder: (context) {
// //         return PDFViewerScaffold(path: _pefFilePath);
// //       },
// //     ));
// //   }
// // }

// // class PDFViewerScreen extends StatelessWidget {
// //   final String? pefFilePath;
// //   const PDFViewerScreen(this.pefFilePath, {super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return PDFViewerScaffold(
// //         appBar: AppBar(
// //           leading: IconButton(
// //               onPressed: () {
// //                 Get.back();
// //               },
// //               icon: const Icon(Icons.arrow_back)),
// //           title: const Text("PDF Document"),
// //         ),
// //         path: pefFilePath);
// //   }
// // } 

// import 'dart:developer';

// import 'package:flutter/material.dart';
// //import 'package:flutter_pdfview/flutter_pdfview.dart';
// //import 'package:flutter_file_view/flutter_file_view.dart';
// //import 'package:flutter_pdfview/flutter_pdfview.dart';

// class PDFViewPage extends StatefulWidget {
//   final String pdfPath;

//   const PDFViewPage({Key? key, required this.pdfPath}) : super(key: key);

//   @override
//   _PDFViewPageState createState() => _PDFViewPageState();
// } 



// class _PDFViewPageState extends State<PDFViewPage> {
//   int pages = 0;
//   int currentPage = 0;
//   bool isReady = false;

//   //PDFViewController? controller; 
//   late PdfController pdfController; 
  
  
//   loadController(){
//     pdfController = PdfController(document: PdfDocument.openFile(widget.pdfPath));
//   }


//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState(); 
//     loadController();
//     log('HWGED: ${widget.pdfPath}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PDF Viewer'),
//       ), 
//       body: PdfView(controller: pdfController)
//       // body: Stack(
//       //   children: <Widget>[
//       //     PDFView(
//       //       filePath: widget.pdfPath,
//       //       onViewCreated: (PDFViewController pdfViewController) {
//       //         setState(() {
//       //           controller = pdfViewController;
//       //         });
//       //         _loadPdf();
//       //       },
//       //       onRender: (pages) {
//       //         setState(() {
//       //           pages = pages!;
//       //           isReady = true;
//       //         });
//       //       },
//       //       onPageChanged: ( int? page, int? total) {
//       //         setState(() {
//       //           currentPage = page!;
//       //         });
//       //       },
//       //       onError: (error) {
//       //         print(error);
//       //       },
//       //       onPageError: (page, error) {
//       //         print('$page: ${error.toString()}');
//       //       },
//       //     ),
//       //     if (isReady)
//       //       Positioned(
//       //         bottom: 10.0,
//       //         right: 10.0,
//       //         child: Text(
//       //           'Page: ${currentPage + 1} / $pages',
//       //           style: const TextStyle(
//       //             fontSize: 16.0,
//       //             fontWeight: FontWeight.bold,
//       //             color: Colors.white,
//       //           ),
//       //         ),
//       //       ),
//       //   ],
//       // ),
//     );
//   }

//   // _loadPdf() async {
//   //   controller!.setPage(currentPage);
//   // }
// }
