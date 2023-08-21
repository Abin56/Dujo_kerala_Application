import 'package:dujo_kerala_application/view/home/parent_home/parent_profile_edit/widgets/edit_list_tile_widget.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_profile_edit/widgets/parent_email_update_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/student_controller/profile_edit_controllers/parent_profile_edit_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../utils/utils.dart';
import '../../../colors/colors.dart';
import '../../../widgets/fonts/google_poppins.dart';
import 'widgets/circle_avatar_image_widget.dart';
import 'widgets/update_text_form_widget.dart';

class ParentEditProfileScreen extends StatelessWidget {
  ParentEditProfileScreen({super.key});
  final ParentProfileEditController parentProfileEditController =
      Get.put(ParentProfileEditController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: adminePrimayColor,
          title: const Text("Profile"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 300.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.h),
                    bottomRight: Radius.circular(12.h)),
                color: adminePrimayColor,
              ),
              child: CircleAvatharImageSelectionWidgetParent(),
            ),
            ParentEditListileWidget(
              voidCallback: () async {
                await profileUpdate(
                  context: context,
                  textEditingController:
                      parentProfileEditController.textEditingController,
                  documentKey: "parentName",
                  textInputType: TextInputType.text,
                  hint: 'Name',
                );
              },
              icon: Icons.person,
              subtitle: UserCredentialsController.parentModel?.parentName ?? "",
              title: "Name",
              editicon: Icons.edit,
            ),

            //phone number
            ParentEditListileWidget(
              voidCallback: () async {
                await profileUpdate(
                  context: context,
                  textEditingController:
                      parentProfileEditController.textEditingController,
                  documentKey: "parentPhoneNumber",
                  textInputType: TextInputType.phone,
                  hint: 'Phone Number',
                );
              },
              icon: Icons.call,
              subtitle:
                  UserCredentialsController.parentModel?.parentPhoneNumber ??
                      "",
              title: "Phone No.",
              editicon: Icons.edit,
            ),

            //email
            ParentEditListileWidgetEmail(
              icon: Icons.email,
              subtitle: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.parentModel?.parentEmail ?? "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Email".tr, fontsize: 12.h),
              editicon: Icons.edit,
            ),

            //House Name
            ParentEditListileWidget(
              voidCallback: () async {
                await profileUpdate(
                  context: context,
                  textEditingController:
                      parentProfileEditController.textEditingController,
                  documentKey: "houseName",
                  textInputType: TextInputType.text,
                  hint: 'House Name',
                );
              },
              icon: Icons.home,
              subtitle: UserCredentialsController.parentModel?.houseName ?? "",
              title: "House Name",
              editicon: Icons.edit,
            ),

            //district
            ParentEditListileWidget(
              voidCallback: () async {
                await profileUpdate(
                  context: context,
                  textEditingController:
                      parentProfileEditController.textEditingController,
                  documentKey: "district",
                  textInputType: TextInputType.text,
                  hint: 'District',
                );
              },
              icon: Icons.place,
              subtitle: UserCredentialsController.parentModel?.district ?? "",
              title: "District",
              editicon: Icons.edit,
            ),

            //Gender

            ParentEditListileWidget(
              voidCallback: () async {
                await profileUpdate(
                  context: context,
                  textEditingController:
                      parentProfileEditController.textEditingController,
                  documentKey: "gender",
                  textInputType: TextInputType.text,
                  hint: 'Gender',
                );
              },
              icon: Icons.person,
              subtitle: UserCredentialsController.parentModel?.gender ?? "",
              title: "Gender",
              editicon: Icons.edit,
            ),
            //pincode
            ParentEditListileWidget(
              voidCallback: () async {
                await profileUpdate(
                  context: context,
                  textEditingController:
                      parentProfileEditController.textEditingController,
                  documentKey: "pincode",
                  textInputType: TextInputType.number,
                  hint: 'Pincode',
                );
              },
              icon: Icons.pin,
              subtitle: UserCredentialsController.parentModel?.pincode ?? "",
              title: "Pincode",
              editicon: Icons.edit,
            ),
            //place
            ParentEditListileWidget(
              voidCallback: () async {
                await profileUpdate(
                  context: context,
                  textEditingController:
                      parentProfileEditController.textEditingController,
                  documentKey: "place",
                  textInputType: TextInputType.text,
                  hint: 'Place',
                );
              },
              icon: Icons.place,
              subtitle: UserCredentialsController.parentModel?.place ?? "",
              title: "Place",
              editicon: Icons.edit,
            ),
            //state
            ParentEditListileWidget(
              voidCallback: () async {
                await profileUpdate(
                  context: context,
                  textEditingController:
                      parentProfileEditController.textEditingController,
                  documentKey: "state",
                  textInputType: TextInputType.text,
                  hint: 'State',
                );
              },
              icon: Icons.place,
              subtitle: UserCredentialsController.parentModel?.state ?? "",
              title: "State",
              editicon: Icons.edit,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> profileUpdate({
    required BuildContext context,
    required TextEditingController textEditingController,
    required String documentKey,
    required String hint,
    required TextInputType textInputType,
  }) {
    return showDialog(
      context: context,
      builder: (context) => updateTextFormField(
        context: context,
        hintText: hint,
        textEditingController: textEditingController,
        voidCallback: () async {
          if (textEditingController.text.isNotEmpty) {
            await parentProfileEditController.updateParentProfile(
              value: textEditingController.text,
              documentKey: documentKey,
            );
          } else {
            return showToast(msg: "Please enter a valid data");
          }
        },
        textInputType: textInputType,
      ),
    );
  }
}
