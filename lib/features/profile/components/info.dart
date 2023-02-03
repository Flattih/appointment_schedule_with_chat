import 'dart:io';

import 'package:appointment_schedule_app/core/common/loader.dart';
import 'package:appointment_schedule_app/core/extensions/context_extension.dart';
import 'package:appointment_schedule_app/core/utils/utils.dart';
import 'package:appointment_schedule_app/features/profile/controller/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicons/unicons.dart';

class Info extends ConsumerStatefulWidget {
  final String name, profilePic, uid;

  const Info(
      {super.key,
      required this.name,
      required this.profilePic,
      required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoState();
}

File? _image;

class _InfoState extends ConsumerState<Info> {
  void selectProfileImage() async {
    final res = await pickImageFromGallery(context);
    setState(() {
      _image = res;
    });
    save();
  }

  void save() {
    ref
        .read(userProfileControllerProvider.notifier)
        .editProfile(profileFile: _image, context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(userProfileControllerProvider);
    return SizedBox(
      height: 240, // 240
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: 150, //150
              color: context.primaryColor,
            ),
          ),
          Center(
            child: isLoading
                ? Loader()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10), //10
                            height: 140, //140
                            width: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.primaryColor,
                                width: 8, //8
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.profilePic),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            right: 20,
                            child: SizedBox(
                              height: 40,
                              child: IconButton(
                                onPressed: selectProfileImage,
                                icon: Icon(
                                  UniconsLine.image,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 22, // 22
                          //color: Pallete.textColor,
                        ),
                      ),
                      const SizedBox(height: 5), //5
                    ],
                  ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
