// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// class SendPushMessages {
//   Future<void> sendPushMessage(String token, String body, String title) async {
//     try {
//       final reponse = await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization':
//               'key=AAAALjI6HsE:APA91bEz3rtgQLxHVbM5U1mFmeKmPzz3AV9m_1-oTYHFnQ4L1PBk0FlN_FCguoEHwR-fNKGX7x2jDB8s0hvsPQC_5j8aaLocXUv2ge3FXHppV7a2MNSOvAnMwT5WZFrEcV4ApbmefBKu'
//         },
//         body: jsonEncode(
//           <String, dynamic>{
//             'priority': 'high',
//             'data': <String, dynamic>{
//               'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//               'status': 'done',
//               'body': body,
//               'title': title,
//             },
//             "notification": <String, dynamic>{
//               'title': title,
//               'body': body,
//               // 'android_channel_id': 'high_importance_channel'
//             },
//             //'to':
//             //device_id[1], token
//           },
//         ),
//       );
//       log(reponse.body.toString());
//     } catch (e) {
//       if (kDebugMode) {
//         log("error push Notification");
//       }
//     }
//   }
// }
