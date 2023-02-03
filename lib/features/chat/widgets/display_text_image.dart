import 'package:appointment_schedule_app/core/enums/message_enum.dart';
import 'package:appointment_schedule_app/core/common/loader.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DisplayTextImageVideo extends StatefulWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextImageVideo({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  State<DisplayTextImageVideo> createState() => _DisplayTextImageVideoState();
}

class _DisplayTextImageVideoState extends State<DisplayTextImageVideo> {
  AudioPlayer? audioPlayer;
  @override
  void dispose() {
    audioPlayer!.dispose();

    super.dispose();
  }

  bool isPlaying = false;
  @override
  void initState() {
    audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == MessageEnum.text
        ? Text(
            widget.message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : widget.type == MessageEnum.audio
            ? IconButton(
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer!.pause();
                    setState(
                      () {
                        isPlaying = false;
                      },
                    );
                  } else {
                    await audioPlayer!.play(UrlSource(widget.message));
                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 50,
                ),
              )
            : CachedNetworkImage(
                imageUrl: widget.message,
                placeholder: (context, url) => CustomLoader(),
              );
  }
}
