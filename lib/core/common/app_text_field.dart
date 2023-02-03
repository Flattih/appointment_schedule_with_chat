import 'package:flutter/material.dart';

import '../theme/palette.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.textctr,
  }) : super(key: key);

  final TextEditingController textctr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 3, color: Pallete.goGreen),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 3, color: Pallete.goGreen),
        ),
      ),
      controller: textctr,
    );
  }
}
