import 'package:flutter/material.dart';
import 'package:calculadora_flutter/MyButton.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var userInput = '';
  var answer = '';

  // array of button
  final List<String> buttons = [
    'C',
    '<-',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 34, color: Colors.white70),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(
                        fontSize: 80,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // clear button
                  if (index == 0) {
                    return MyButton(
                      buttontapped: (){
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                      },
                      buttonText: buttons[index],
                      fontSize: 28.0,
                      color: Colors.black,
                      textColor: Colors.deepOrangeAccent,
                    );
                  }

                  // Delete button
                  else if (index == 1) {
                    return MyButton(
                      buttontapped: (){
                        setState(() {
                          userInput = userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      fontSize: 28.0,
                      color: Colors.black,
                      textColor: Colors.deepOrangeAccent,
                    );
                  }

                  // double zero button
                  else if (index == 16) {
                    return MyButton(
                      buttontapped: (){
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      fontSize: 28.0,
                      color: Colors.black,
                      textColor: Colors.deepOrangeAccent,
                    );
                  }

                  // % button
                  else if (index == 2) {
                    return MyButton(
                      buttontapped: (){
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      fontSize: 28.0,
                      color: Colors.black,
                      textColor: Colors.deepOrangeAccent,
                    );
                  }

                  // Equals button
                  else if (index == 19) {
                    return MyButton(

                      buttontapped: (){
                        setState(() {
                          equalsPressed();
                        });
                      },
                      buttonText: buttons[index],
                      fontSize: 48.0,
                      color: Colors.orange[700],
                      textColor: Colors.white,
                    );
                  }

                  // Other buttons
                  else {
                    return MyButton(
                      buttontapped: (){
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      fontSize: 28.0,
                      color: isOperator(buttons[index])
                          ? Colors.black
                          : Colors.black,
                      textColor: isOperator(buttons[index])
                          ? Colors.deepOrangeAccent
                          : Colors.white,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void doubleZero() {

  }


  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalsPressed() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }

}
