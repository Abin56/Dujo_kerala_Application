import 'package:flutter/material.dart';

class CircleAvatharImageSelectionWidget extends StatelessWidget {
  const CircleAvatharImageSelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
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
                        Color.fromARGB(255, 52, 50, 50),
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

