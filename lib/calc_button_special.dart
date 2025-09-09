import 'package:flutter/material.dart';

Widget calcButtonSpecial(
  Icon buttonText,
  Color buttonColor,
  double? size,
  void Function()? buttonPressed, {
  BuildContext? context,
  double? height = 0,
}) {
  buttonText = Icon(buttonText.icon, size: size, color: buttonText.color);
  return Container(
    width: MediaQuery.of(context!).size.width * 0.2,
    height: height == 0 ? 80 : height,
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        backgroundColor: buttonColor,
        padding: const EdgeInsets.all(0),
      ),
      child: buttonText,
    ),
  );
}
