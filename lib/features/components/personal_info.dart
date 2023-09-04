import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RadialProgress(
            width: 3.0,
            goalCompleted: 0.8,
            child: RoundedImage(
              imagePath: userController.currentUser?.avatar ?? ProjectVariables.defaultUserIcon,
              size: const Size.fromWidth(100.0),
            ),
          ),
          const SizedBox(height: 10.0),
          CustomText(
            "${userController.currentUser?.firstName} ${userController.currentUser?.lastName}".toUpperCase(),
            color: BrandColors.kColorWhiteAccent,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
          const Gap(10.0),
        ],
      ),
    );
  }
}
