import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/questions.dart';
import 'questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Questions quizBrain = Questions();

void main() => runApp(Quizz());

class Quizz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];
  int score = 0;
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    int noOfQues = quizBrain.getQuesLength();
    bool setVisible = true;

    setState(() {
      if (quizBrain.isFinished()) {
        print(score);
        print("Done");
        scorekeeper.clear();
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Quiz Completed",
          desc: "You Scored $score/$noOfQues Good job",
          buttons: [
            DialogButton(
              child: Text(
                "Play Again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                score = 0;
                quizBrain.reset();
                Navigator.pop(context);
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
            ),
            DialogButton(
              child: Text(
                "Quit",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => exit(0),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ]),
            )
          ],
        ).show();
      } else {
        if (userPickedAnswer == correctAnswer) {
          scorekeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          score++;
        } else {
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: FlatButton(
              textColor: Colors.white,
              child: Text(
                "True",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              color: Colors.green,
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: FlatButton(
              textColor: Colors.white,
              child: Text(
                "False",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              color: Colors.red,
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ),
      ],
    );
  }
}
