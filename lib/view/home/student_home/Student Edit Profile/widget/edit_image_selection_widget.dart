import 'package:flutter/material.dart';

import '../../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../constant/sizes/constant.dart';

class CircleAvatharImageSelectionWidget extends StatelessWidget {
  const CircleAvatharImageSelectionWidget({
    super.key,
  });

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
                onTap: () async {},
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
}
