import 'package:flutter/material.dart';

import '../../model/Signup_Image_Selction/image_selection.dart';
import '../constant/sizes/sizes.dart';
import '../fonts/fonts.dart';

class BottomProfilePhotoContainerWidget extends StatelessWidget {
  const BottomProfilePhotoContainerWidget({
    super.key,
    required this.getImageController,
  });

  final GetImage getImageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 160,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile Photo",
                    style: DGoogleFonts.subHeadStyle,
                  ),
                  const Icon(Icons.delete)
                ],
              ),
            ),
            kHeight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await getImageController.getCamera();
                      },
                      child: CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Colors.blue[300],
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    kHeight10,
                    Text(
                      "Camera",
                      style: DGoogleFonts.smallTextStyle,
                    )
                  ],
                ),
                kWidth30,
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await getImageController.getGallery();
                      },
                      child: CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Colors.blue[300],
                        child: const Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    kHeight10,
                    Text(
                      "Gallery",
                      style: DGoogleFonts.smallTextStyle,
                    )
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}