import 'package:appointment_schedule_app/core/constants/constants.dart';
import 'package:appointment_schedule_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/effects/effects.dart';
import 'package:flutter_animate/extensions/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Background extends ConsumerWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    this.topImage = Constants.loginTopImagePath,
    this.bottomImage = Constants.loginBottomImagePath,
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  topImage,
                  width: 120,
                ),
              )
                  .animate(
                    delay: 1.seconds,
                  )
                  .fadeIn(duration: 3.seconds),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(bottomImage, width: 120),
              )
                  .animate(
                    delay: 1.seconds,
                  )
                  .fadeIn(duration: 3.seconds),
              SafeArea(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
