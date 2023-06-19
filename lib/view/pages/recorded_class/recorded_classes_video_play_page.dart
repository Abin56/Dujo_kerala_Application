// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// /// Stateful widget to fetch and then display video content.
// class RecordedClassVideoPlayerPage extends StatefulWidget {
//   const RecordedClassVideoPlayerPage({super.key, required this.networkUrl});
//   final String networkUrl;

//   @override
//   State<RecordedClassVideoPlayerPage> createState() =>
//       _RecordedClassVideoPlayerPageState();
// }

// class _RecordedClassVideoPlayerPageState
//     extends State<RecordedClassVideoPlayerPage> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.networkUrl)
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _controller.value.isInitialized
//             ? SizedBox(
//                 height: MediaQuery.of(context).size.height / 1.3,
//                 child: AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: Stack(children: [
//                     VideoPlayer(_controller),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 seekBackward(const Duration(seconds: 3));
//                               });
//                             },
//                             icon: const Icon(
//                               Icons.arrow_back_ios_rounded,
//                               color: Colors.white,
//                               size: 35,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 _controller.value.isPlaying
//                                     ? _controller.pause()
//                                     : _controller.play();
//                               });
//                             },
//                             icon: Icon(
//                               _controller.value.isPlaying
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                               color: Colors.white,
//                               size: 35,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 seekForward(const Duration(seconds: 3));
//                               });
//                             },
//                             icon: const Icon(
//                               Icons.arrow_forward_ios_rounded,
//                               color: Colors.white,
//                               size: 35,
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ]),
//                 ),
//               )
//             : Container(),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   void seekForward(Duration duration) {
//     final currentPosition = _controller.value.position;
//     final newPosition = currentPosition + duration;
//     _controller.seekTo(newPosition);
//   }

//   void seekBackward(Duration duration) {
//     final currentPosition = _controller.value.position;
//     final newPosition = currentPosition - duration;
//     _controller.seekTo(newPosition);
//   }
// }
