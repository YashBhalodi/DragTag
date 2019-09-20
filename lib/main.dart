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
//  bool isTicked = false;
  int totalScore = 0;
  int targetNumber = Random().nextInt(9);

/*  Widget tickedTarget(bool isSelected) {
    return isSelected
        ? Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.green[50],
              border: Border.all(color: Colors.green[300], width: 1.0),
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 40.0,
            ),
          )
        : Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.red[50],
              border: Border.all(color: Colors.red[300], width: 1.0),
            ),
            child: Icon(
              Icons.close,
              color: Colors.red,
              size: 40.0,
            ),
          );
  }

  Widget tickButton(bool isSelected) {
    return isSelected
        ? Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.greenAccent[100]),
                color: Colors.green),
            width: 80.0,
            height: 80.0,
            child: Icon(
              Icons.check,
              color: Colors.greenAccent[100],
              size: 40.0,
            ),
          )
        : Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.redAccent[100]),
                color: Colors.redAccent),
            width: 80.0,
            height: 80.0,
            child: Icon(
              Icons.close,
              color: Colors.redAccent[100],
              size: 40.0,
            ),
          );
  }

  Widget tickDrag(bool isSelected) {
    return isSelected
        ? Container(
            width: 50.0,
            height: 50.0,
            child: Icon(
              Icons.check,
              color: Colors.green,
            ),
          )
        : Container(
            width: 50.0,
            height: 50.0,
            child: Icon(
              Icons.close,
              color: Colors.redAccent[100],
            ),
          );
  }*/

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
            });
            return false;
          }
        },
        onAccept: (data) {
          setState(() {
            targetNumber = Random().nextInt(9);
            totalScore++;
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
            child: Container(
              width: 200.0,
              height: 60.0,
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
