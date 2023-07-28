import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/student_controller/profile_edit_controllers/parent_profile_edit_controller.dart';
import '../../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../constant/sizes/constant.dart';
import '../../../../widgets/bottom_container_profile_photo_container.dart';

class CircleAvatharImageSelectionWidgetParent extends StatelessWidget {
  CircleAvatharImageSelectionWidgetParent({
    super.key,
  });
  final GetImage getImageController = Get.put(GetImage());
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: UserCredentialsController.parentModel?.profileImageURL ==
                  null ||
              UserCredentialsController.parentModel!.profileImageURL!.isEmpty
          ? const NetworkImage(netWorkImagePathPerson)
          : NetworkImage(
                  UserCredentialsController.parentModel?.profileImageURL ?? " ")
              as ImageProvider,
      radius: 100,
      child: Stack(
        children: [
          InkWell(
            onTap: () async {
              _getCameraAndGallery(context);
            },
            child: const Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Color.fromARGB(255, 52, 50, 50),
                child: Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BottomProfilePhotoContainerWidget(
          getImageController: getImageController,
        );
      },
    ).then((value) {
      if (getImageController.pickedImage.value.isNotEmpty) {
        showDialog(
          context: context,
          barrierDismissible:
              false, // Added to prevent dialog dismissal on tap outside
          builder: (context) {
            return Obx(
              () => Get.find<ParentProfileEditController>().isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : AlertDialog(
                      title: Text('Do you want to change profile picture?'.tr),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.find<ParentProfileEditController>()
                                .updateParentProfilePicture();
                          },
                          child: const Text('Update'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            getImageController.pickedImage.value = '';
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
            );
          },
        );
      }
    });
  }
}
