import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CustomWindow extends StatelessWidget {
  final InfoWindowModel info;
  final Color? triangleColor;
  final Color? tileColor;
  const CustomWindow({
    Key? key,
    required this.info,
    this.triangleColor,
    this.tileColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: BrandColors.kColorDarkBlue.withOpacity(.4),
                    spreadRadius: 2.0,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (info.type == InfoWindowType.position)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      color: BrandColors.kColorDarkGreen,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(
                            info.time != null ? '${(info.time!.inMinutes) % 60}' : '',
                            color: BrandColors.kColorWhiteAccent,
                            fontSize: 14.0,
                            verticalMargin: 0.0,
                            fontWeight: FontWeight.w900,
                          ),
                          CustomText(
                            info.time != null
                                ? info.time?.inMinutes.isGreaterThan(1) == true
                                    ? 'mins'.toCapitalized()
                                    : 'min'.toCapitalized()
                                : '',
                            color: BrandColors.kColorWhiteAccent,
                            fontSize: 12.0,
                            verticalMargin: 0.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ],
                      ),
                    ),
                  const Gap(4.0),
                  Expanded(
                    child: CustomText(
                      '${info.name}',
                      textAlign: TextAlign.start,
                      // color: BrandColors.kColorText,
                      verticalMargin: 0.0,
                      horizontalMargin: 0.0,
                      fontSize: 16.0,
                      maxLines: 5,
                    ),
                  ),
                  const Gap(2.0),
                  Icon(
                    LineAwesomeIcons.angle_right,
                    size: 18.0,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const Gap(2.0),
                ],
              ),
            ),
          ),
        ),
        DownTriangle(
          size: 10.0,
          color: triangleColor ?? BrandColors.kColorBackground,
        ),
      ],
    );
  }
}
