import 'package:appointment_schedule_app/core/common/app_text_field.dart';
import 'package:appointment_schedule_app/core/theme/palette.dart';
import 'package:appointment_schedule_app/core/utils/utils.dart';

import 'package:appointment_schedule_app/features/add_appointment/controller/post_controller.dart';
import 'package:appointment_schedule_app/features/auth/controller/auth_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAppointmentScreen extends ConsumerStatefulWidget {
  const AddAppointmentScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends ConsumerState<AddAppointmentScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleCtr = TextEditingController();
  final TextEditingController descriptionCtr = TextEditingController();
  final TextEditingController locationCtr = TextEditingController();
  final TextEditingController appointmentDateCtr = TextEditingController();
  final TextEditingController appointmentTimeCtr = TextEditingController();
  final TextEditingController appointmentTimeCtr2 = TextEditingController();
  final TextEditingController appointmentTimeCtr3 = TextEditingController();
  String? appointmentDate;
  String? appointmentTime;
  String? appointmentTime2;
  String? appointmentTime3;

  @override
  void dispose() {
    titleCtr.dispose();
    appointmentTimeCtr2.dispose();
    appointmentTimeCtr3.dispose();
    descriptionCtr.dispose();
    locationCtr.dispose();
    appointmentDateCtr.dispose();
    appointmentTimeCtr.dispose();
    super.dispose();
  }

  void sharePost() {
    if (appointmentDateCtr.text.isNotEmpty &&
        appointmentTimeCtr.text.isNotEmpty &&
        locationCtr.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).sharePost(
          appointmentTime3: appointmentTime3,
          appointmentTime2: appointmentTime2,
          appointmentDate: appointmentDate!,
          profImg: ref.watch(userProvider)!.profilePic,
          context: context,
          title: titleCtr.text.trim(),
          appointmentTime: appointmentTime!,
          location: locationCtr.text.trim(),
          description: descriptionCtr.text.trim());
    } else {
      showSnackBar("at-least".tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(width: 3, color: Pallete.goGreen),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Pallete.goGreen),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Pallete.goGreen),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("planned-date".tr()),
                  const SizedBox(
                    height: 15,
                  ),
                  DateTimePicker(
                    decoration: inputDecoration,
                    type: DateTimePickerType.date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'date'.tr(),
                    controller: appointmentDateCtr,
                    onChanged: (val) {
                      appointmentDate = appointmentDateCtr.text;
                    },
                  ),
                  const SizedBox(height: 15),
                  Text("pick-time".tr()),
                  const SizedBox(height: 15),
                  DateTimePicker(
                    decoration: inputDecoration,
                    type: DateTimePickerType.time,
                    dateLabelText: 'time'.tr(),
                    controller: appointmentTimeCtr,
                    onChanged: (val) {
                      appointmentTime = appointmentTimeCtr.text;
                    },
                  ),
                  const SizedBox(height: 15),
                  Text("pick-another-time".tr()),
                  const SizedBox(height: 15),
                  DateTimePicker(
                    decoration: inputDecoration,
                    type: DateTimePickerType.time,
                    dateLabelText: 'time'.tr(),
                    controller: appointmentTimeCtr2,
                    onChanged: (val) {
                      appointmentTime2 = appointmentTimeCtr2.text;
                    },
                  ),
                  const SizedBox(height: 15),
                  Text("pick-3rd-time".tr()),
                  const SizedBox(height: 15),
                  DateTimePicker(
                    decoration: inputDecoration,
                    type: DateTimePickerType.time,
                    dateLabelText: 'time'.tr(),
                    controller: appointmentTimeCtr3,
                    onChanged: (val) {
                      appointmentTime3 = appointmentTimeCtr3.text;
                    },
                  ),
                  const SizedBox(height: 15),
                  Text("title".tr()),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(textctr: titleCtr),
                  const SizedBox(height: 15),
                  Text("description".tr()),
                  const SizedBox(height: 15),
                  AppTextField(textctr: descriptionCtr),
                  const SizedBox(height: 15),
                  Text("location".tr()),
                  const SizedBox(height: 15),
                  AppTextField(textctr: locationCtr),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.goGreen),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          sharePost();
                        }
                      },
                      child: Text("create-appointment".tr()))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
