// import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
// import 'package:flutter/material.dart';


// class PF extends StatefulWidget {
//    PF({super.key}); 

//    bool isLoading = false;

//   @override
//   State<PF> createState() => _PFState();
// } 

// class _PFState extends State<PF> { 
//   PDFDocument? doc;

//   @override
//   void initState() {
//     super.initState(); 
//     ff();

//   } 

//   ff()async{
//     setState(() {
//       widget.isLoading = true;
//     });
//      doc = await PDFDocument.fromURL('https://firebasestorage.googleapis.com/v0/b/dujo-kerala-schools-1a6c5.appspot.com/o/files%2Fstudymaterials%2FEnglish%2FJohny%20Johny%2Ffab221c0-f545-11ed-829a-11b8e7490871?alt=media&token=21f0bd88-b03e-41fd-8267-8a013aa3e80d'); 
//     setState(() {
//       widget.isLoading = false;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//         title: const Text('PDF Viewer'),
//       ),
//       // body: Container(
//       //     child: SfPdfViewer.network(
//       //         'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'))
//       body: Center(
//           child: widget.isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : PDFViewer(document: doc!)),
//     );
//   }
// }