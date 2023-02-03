import 'package:appointment_schedule_app/core/common/app_button.dart';
import 'package:appointment_schedule_app/core/common/loader.dart';
import 'package:appointment_schedule_app/features/auth/controller/auth_controller.dart';
import 'package:appointment_schedule_app/features/auth/screens/components/backgorund.dart';
import 'package:appointment_schedule_app/features/auth/screens/components/login_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);

    return SafeArea(
      child: Background(
        child: SingleChildScrollView(
          child: isLoading
              ? const Loader()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const WelcomeImage(),
                    Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 9,
                          child: AppButton(
                              icon: FontAwesomeIcons.google,
                              text: "sign-in",
                              onTap: () => ref
                                  .watch(authControllerProvider.notifier)
                                  .signInWithGoogle(context)),
                        )
                            .animate(
                              delay: 1.seconds,
                            )
                            .fadeIn(duration: 1.seconds),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                      ),
                      child: AppButton(
                        onTap: () {
                          ref
                              .read(authControllerProvider.notifier)
                              .signInAnonymously(context);
                        },
                        text: "Sign In With Anonymously",
                        icon: FontAwesomeIcons.userSecret,
                      )
                          .animate(
                            delay: 1.seconds,
                          )
                          .fadeIn(duration: 1.seconds),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
