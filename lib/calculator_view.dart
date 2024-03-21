import 'package:fast_calc/calc_button_symbol.dart';
import 'package:flutter/cupertino.dart';

import 'calc_button_text.dart';
import 'calc_button_special.dart';
import 'colours.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  String clearButton = "AC";
  String angleMode = "DEG";

  changeAngleMode() {
    setState(() {
      if (angleMode == "DEG") {
        angleMode = "RAD";
      } else {
        angleMode = "DEG";
      }
    });
  }

  buttonPressed(String buttonText) {
    // used to check if the result contains a decimal
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        // Change clear symbol back to AC
        clearButton = "AC";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);

        if (equation == "") {
          equation = "0";
          clearButton = "AC";
        } else {
          // Change the clear symbol to C if the backspace it being used
          clearButton = "C";
        }
      } else if (buttonText == "±") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        // Convert all the readable symbols into symbols for the parser
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '/100');

        try {
          // If the user puts more than one % sign in a row, throw an error
          if (equation.contains(RegExp(r'%%'))) {
            throw Exception("Multiple % signs are not allowed.");
          }

          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          // Remove decimal part if the result is a round number
          result = doesContainDecimal(result);
        } catch (e) {
          // Show an error message
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }

        // Change the clear symbol if it's a number being entered
        if (buttonText != "÷" &&
            buttonText != "×" &&
            buttonText != "-" &&
            buttonText != "+") {
          clearButton = "C";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double innerPaddingAmount = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black54,
          // leading: const Icon(Icons.settings, color: Colors.blue),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: calcButtonText(angleMode, 18, () => changeAngleMode(),
                  buttonColor : CustomColors.black, textColor: Colors.grey[700], context : context),
              // child: Text('DEG', style: TextStyle(color: Colors.white38)),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(1),
                                child: Text(result,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 80))),
                            SizedBox(width: innerPaddingAmount),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(equation,
                                    style: const TextStyle(
                                      fontSize: 40,
                                      color: Colors.white38,
                                    )),
                              ),
                              calcButtonSpecial(
                                  const Icon(Icons.backspace_outlined,
                                      color: Colors.blue, size: 30),
                                  CustomColors.black,
                                  40,
                                  () => buttonPressed('⌫'),
                                  context: context),
                              SizedBox(width: innerPaddingAmount),
                            ])
                      ]),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(width: innerPaddingAmount),
                Column(children: [
                  Row(children: [
                    calcButtonText(clearButton, 30, () => buttonPressed('AC'),
                        buttonColor: Colors.blue, context: context),
                    SizedBox(width: innerPaddingAmount),
                    calcButtonSymbol(const Icon(CupertinoIcons.percent),
                        () => buttonPressed('%'),
                        context: context),
                    SizedBox(width: innerPaddingAmount),
                    calcButtonSymbol(const Icon(CupertinoIcons.divide),
                        () => buttonPressed('÷'),
                        context: context),
                  ]),
                ]),
                SizedBox(width: innerPaddingAmount),
                calcButtonSymbol(const Icon(CupertinoIcons.multiply),
                    () => buttonPressed('×'),
                    context: context),
                SizedBox(width: innerPaddingAmount),
              ]),
              const SizedBox(height: 10),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(width: innerPaddingAmount),
                Column(children: [
                  Row(children: [
                    calcButtonText('7', 30, () => buttonPressed('7'),
                        context: context),
                    SizedBox(width: innerPaddingAmount),
                    calcButtonText('8', 30, () => buttonPressed('8'),
                        context: context),
                    SizedBox(width: innerPaddingAmount),
                    calcButtonText('9', 30, () => buttonPressed('9'),
                        context: context),
                  ]),
                ]),
                SizedBox(width: innerPaddingAmount),
                calcButtonSymbol(
                    const Icon(CupertinoIcons.minus), () => buttonPressed('-'),
                    context: context),
                SizedBox(width: innerPaddingAmount),
              ]),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: innerPaddingAmount),
                  Column(
                    children: [
                      Row(
                        children: [
                          calcButtonText('4', 30, () => buttonPressed('4'),
                              context: context),
                          SizedBox(width: innerPaddingAmount),
                          calcButtonText('5', 30, () => buttonPressed('5'),
                              context: context),
                          SizedBox(width: innerPaddingAmount),
                          calcButtonText('6', 30, () => buttonPressed('6'),
                              context: context),
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: innerPaddingAmount),
                  calcButtonSymbol(
                      const Icon(CupertinoIcons.add), () => buttonPressed('+'),
                      context: context),
                  SizedBox(width: innerPaddingAmount),
                ],
              ),
              const SizedBox(height: 10),
              // calculator number buttons

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: innerPaddingAmount),
                  Column(
                    children: [
                      Row(
                        children: [
                          calcButtonText('1', 30, () => buttonPressed('1'),
                              context: context),
                          SizedBox(width: innerPaddingAmount),
                          calcButtonText('2', 30, () => buttonPressed('2'),
                              context: context),
                          SizedBox(width: innerPaddingAmount),
                          calcButtonText('3', 30, () => buttonPressed('3'),
                              context: context),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          calcButtonSymbol(const Icon(CupertinoIcons.plusminus),
                              () => buttonPressed('±'),
                              context: context),
                          SizedBox(width: innerPaddingAmount),
                          calcButtonText('0', 30, () => buttonPressed('0'),
                              context: context),
                          SizedBox(width: innerPaddingAmount),
                          calcButtonText('.', 30, () => buttonPressed('.'),
                              context: context),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: innerPaddingAmount),
                  calcButtonSymbol(const Icon(CupertinoIcons.equal),
                      () => buttonPressed('='),
                      important: true, context: context),
                  SizedBox(width: innerPaddingAmount),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ));
  }
}
