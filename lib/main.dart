import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess my number',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Guess my number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = "";
  final TextEditingController _controller = TextEditingController();
  int _randomNum;
  bool _guessingState = false;

  void generateRandomNumber() {
    Random randomObj = Random();
    _randomNum = randomObj.nextInt(100) + 1;
  }

  Future<void> _showMyDialog(int guessedNum) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You guessed right'),
          content: SingleChildScrollView(
            child: Text(
              'It was $guessedNum'
            )
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'I\'m thinking of a number between 1 and 100',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'It\'s your turn to guess my number!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )),
            if (_message != null)
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  )),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2.0,
                      blurRadius: 2.0,
                      offset: Offset(0, 2))
                ],
              ),
              child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Try a number!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(3.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _controller,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(3.0),
                      child: TextButton(
                        child: Text(
                          'Guess'
                        ),
                        onPressed: () {
                          setState(() {
                            try {
                              if (_guessingState == false) {
                                generateRandomNumber();
                                _guessingState = true;
                              }
                              int guessedNum = int.parse(_controller.text);
                              _message = 'You tried $guessedNum\n';

                              if (guessedNum > _randomNum) {
                                _message += 'Try lower';
                              } else if (guessedNum < _randomNum) {
                                _message += 'Try higher';
                              } else {
                                _message += 'You were right';
                                _showMyDialog(guessedNum);
                              }

                            } catch (E) {

                            }
                          });
                        },
                      ),
                    )
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
