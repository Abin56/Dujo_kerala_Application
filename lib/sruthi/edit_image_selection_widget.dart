import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/constant/sizes/constant.dart';
import '../view/home/sample/under_maintance.dart';

class CircleAvatharImageSelectionWidget extends StatelessWidget {
  ImageProvider<Object>? backgroundImage;
  CircleAvatharImageSelectionWidget({
    this.backgroundImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: const NetworkImage(netWorkImagePathPerson),
          radius: 60,
          child: Stack(
            children: [
              InkWell(
                onTap: () async {},
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        // ignore: prefer_const_constructors
                        Color.fromARGB(255, 52, 50, 50),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                        onPressed: () async {
                          Get.to(const UnderMaintanceScreen(
                            text: '',
                          ));
                        },
                      ),
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
}
