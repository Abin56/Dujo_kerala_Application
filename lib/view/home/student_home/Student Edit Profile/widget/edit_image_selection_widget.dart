import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../constant/sizes/constant.dart';
import '../../../../widgets/bottom_container_profile_photo_container.dart';

class CircleAvatharImageSelectionWidget extends StatelessWidget {
  CircleAvatharImageSelectionWidget({
    super.key,
  });
  GetImage getImageController = Get.put(GetImage());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage:
              UserCredentialsController.studentModel?.profileImageUrl == null ||
                      UserCredentialsController
                          .studentModel!.profileImageUrl.isEmpty
                  ? const NetworkImage(netWorkImagePathPerson)
                  : NetworkImage(
                      UserCredentialsController.studentModel?.profileImageUrl ??
                          " ") as ImageProvider,
          radius: 60,
          child: Stack(
            children: [
              InkWell(
                onTap: () async {
                  _getCameraAndGallery(context);
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color.fromARGB(255, 52, 50, 50),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () async {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomProfilePhotoContainerWidget(
              getImageController: getImageController);
        }).then((value) {
      if (getImageController.pickedImage.value.isNotEmpty) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to change profile picture'),
                actions: [
                  TextButton(onPressed: () {}, child: const Text('Update')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        getImageController.pickedImage.value = "";
                      },
                      child: const Text('Cancel')),
                ],
              );
            });
      }
    });
  }
}
