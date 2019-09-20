import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag N Tag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int totalScore = 0;
  int targetNumber = Random().nextInt(9)+1;
  Color cardColor = Colors.blue[100];

  Widget numberDrag(int i, double height, double width) {
    return SizedBox(
      width: width,
      height: height,
      child: Draggable(
        child: Card(
          elevation: 10.0,
          child: Container(
            color: Colors.blue[200],
            width: width,
            height: height,
            child: Center(
              child: Text(
                i.toString(),
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ),
        feedback: Card(
          elevation: 10.0,
          child: Container(
            color: Colors.blue[200],
            width: width,
            height: height,
            child: Center(
              child: Text(
                i.toString(),
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ),
        data: i,
        childWhenDragging: Container(),
      ),
    );
  }

  Widget numberTarget(int i, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: DragTarget(
        onWillAccept: (data) {
          if (data == i) {
            return true;
          } else {
            setState(() {
              totalScore--;
              cardColor = Colors.red[200];
            });
            return false;
          }
        },
        onAccept: (data) {
          setState(() {
            targetNumber = Random().nextInt(9)+1;
            totalScore++;
            cardColor = Colors.green[200];
          });
        },
        builder: (context, List<int> candidateData, rejectedData) {
          return Center(
            child: Container(
              color: Colors.green[200],
              width: width,
              height: height,
              child: Center(
                child: Text(
                  i.toString(),
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag N Tag"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                numberTarget(targetNumber, 80.0, 80.0),
              ],
            ),
          ),
          Card(
            elevation: 10.0,
            child: AnimatedContainer(duration: Duration(milliseconds: 500),curve: SawTooth(2),
              width: 200.0,
              height: 60.0,
              color: cardColor,
              child: Center(
                child: Text(
                  "Total Score: $totalScore.",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      numberDrag(1, 80.0, 80.0),
                      numberDrag(2, 80.0, 80.0),
                      numberDrag(3, 80.0, 80.0),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      numberDrag(4, 80.0, 80.0),
                      numberDrag(5, 80.0, 80.0),
                      numberDrag(6, 80.0, 80.0),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      numberDrag(7, 80.0, 80.0),
                      numberDrag(8, 80.0, 80.0),
                      numberDrag(9, 80.0, 80.0),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
