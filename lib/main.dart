import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorMain(),
    );
  }
}

class CalculatorMain extends StatefulWidget {
  @override
  _CalculatorMainState createState() => _CalculatorMainState();
}

class _CalculatorMainState extends State<CalculatorMain> {
  String equation = '0';
  String result = '0';
  String expression = "";
  double equFontSize = 36.0;
  double resFontSize = 48.0;

  buttonOnPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        equFontSize = 36.0;
        resFontSize = 48.0;
      } else if (buttonText == '<') {
        equFontSize = 48.0;
        resFontSize = 36.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        equFontSize = 36.0;
        resFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll("x", '*');
        expression = expression.replaceAll("÷", '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equFontSize = 48.0;
        resFontSize = 36.0;
        if (equation == '0' && buttonText == '0') {
          equation = '0';
        } else {
          if (equation == '0') {
            equation = '';
            equation = equation + buttonText;
          } else {
            equation = equation + buttonText;
          }
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          padding: EdgeInsets.all(16.0),
        ),
        onPressed: () => buttonOnPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equFontSize)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resFontSize)),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(children: [
                  TableRow(children: [
                    buildButton('C', 1, Colors.red),
                    buildButton('x', 1, Colors.blue[200]),
                    buildButton('÷', 1, Colors.blue[200]),
                  ]),
                  TableRow(children: [
                    buildButton('7', 1, Colors.blue),
                    buildButton('8', 1, Colors.blue),
                    buildButton('9', 1, Colors.blue),
                  ]),
                  TableRow(children: [
                    buildButton('4', 1, Colors.blue),
                    buildButton('5', 1, Colors.blue),
                    buildButton('6', 1, Colors.blue),
                  ]),
                  TableRow(children: [
                    buildButton('1', 1, Colors.blue),
                    buildButton('2', 1, Colors.blue),
                    buildButton('3', 1, Colors.blue),
                  ]),
                  TableRow(children: [
                    buildButton('.', 1, Colors.blue),
                    buildButton('0', 1, Colors.blue),
                    buildButton('00', 1, Colors.blue),
                  ]),
                ]),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton('<', 1, Colors.blue[200]),
                      ]),
                      TableRow(children: [
                        buildButton('-', 1, Colors.blue[200]),
                      ]),
                      TableRow(children: [
                        buildButton('+', 1, Colors.blue[200]),
                      ]),
                      TableRow(children: [
                        buildButton('=', 2, Colors.red),
                      ]),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
