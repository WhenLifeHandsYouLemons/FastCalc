import 'package:flutter/material.dart';

Widget calcButtonText(
    String buttonText, double? size, void Function()? function,
    {Color? buttonColor = Colors.white24, Color? textColor = Colors.white, BuildContext? context}) {
  return Container(
    width: MediaQuery.of(context!).size.width * 0.2,
    height: buttonText == '=' ? 150 : 75,
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          backgroundColor: buttonColor,
          padding: const EdgeInsets.all(0)),
      child: Text(buttonText,
          style: TextStyle(fontSize: size, color: textColor)),
    ),
  );
}
