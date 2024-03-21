import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget calcButtonSymbol(Icon buttonText, void Function()? buttonPressed,
    {bool? important, BuildContext? context}) {
  buttonText = Icon(buttonText.icon, size: 40, color: Colors.white);

  return Container(
    width: MediaQuery.of(context!).size.width * 0.2,
    height: buttonText.icon == CupertinoIcons.equal ? 160 : 75,
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          backgroundColor: important == true ? Colors.blue : Colors.white10,
          padding: const EdgeInsets.all(0)),
      child: buttonText,
    ),
  );
}
