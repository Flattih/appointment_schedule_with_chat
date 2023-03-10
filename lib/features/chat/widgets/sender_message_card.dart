import 'package:appointment_schedule_app/core/enums/message_enum.dart';
import 'package:appointment_schedule_app/features/chat/widgets/display_text_image.dart';
import 'package:flutter/material.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.type,
    required this.date,
  }) : super(key: key);
  final String message;
  final String date;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color.fromRGBO(37, 45, 49, 1),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                  padding: type == MessageEnum.text
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 25),
                  child: DisplayTextImageVideo(message: message, type: type)),
              Positioned(
                bottom: 2,
                right: 10,
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
