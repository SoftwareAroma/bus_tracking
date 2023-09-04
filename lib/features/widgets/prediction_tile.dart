import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PredictionTile extends StatelessWidget {
  final BusModel prediction;
  final VoidCallback? onPressed;

  const PredictionTile({
    Key? key,
    required this.prediction,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> nameSplit = prediction.name!.split(" - ");
    // debugPrint("nameSplit: $nameSplit");

    return GetBuilder<AppController>(
        init: AppController(),
        builder: (AppController appController) {
          return InkWell(
            onTap: onPressed ?? () => appController.updateActiveRoute(prediction),
            child: Card(
              elevation: 5.0,
              shadowColor: Colors.black12,
              margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Gap(8.0),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          Assets.imagesBus,
                          width: 50.0,
                          height: 50.0,
                        ),
                        const Gap(4.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: CustomText(
                                      nameSplit[0],
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16.0,
                                      maxLines: 5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Gap(8.0),
                                  const Icon(
                                    LineAwesomeIcons.angle_right,
                                  ),
                                  const Gap(8.0),
                                  Expanded(
                                    child: CustomText(
                                      nameSplit[1],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(2.0),
                              CustomText(
                                prediction.description ?? "",
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12.0,
                                maxLines: 5,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(8.0),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
