import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          Assets.imagesError,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.15,
          left: MediaQuery.of(context).size.width * 0.3,
          right: MediaQuery.of(context).size.width * 0.3,
          child: CustomButton(
            buttonColor: const Color(0xFF6B92F2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              context.go(routerHomeLocation);
            },
            child: CustomText(
              "Go Home".toUpperCase(),
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
