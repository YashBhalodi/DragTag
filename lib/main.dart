import 'package:flutter/material.dart';

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
  bool isTicked = false;

  Widget tickedTarget(bool isSelected) {
    return isSelected
        ? Container(
            width: 80.0,
            height: 80.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.green[50],
              border: Border.all(color: Colors.green[300], width: 1.0),
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80.0,
            ),
          )
        : Container(
            width: 80.0,
            height: 80.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.red[50],
              border: Border.all(color: Colors.red[300], width: 1.0),
            ),
            child: Icon(
              Icons.close,
              color: Colors.red,
              size: 80.0,
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
              size: 50.0,
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
              size: 50.0,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag N Tag"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: DragTarget(
              onWillAccept: (data) {
                return true;
              },
              onAccept: (data) {
                setState(() {
                  isTicked = !isTicked;
                });
              },
              builder: (context, List<int> candidateData, rejectedData) {
                print(candidateData);
                return Center(
                  child: tickedTarget(isTicked),
                );
              },
            ),
          ),
          Container(
            height: 80.0,
            width: 80.0,
            child: Draggable(
              data: 1,
              child: tickButton(!isTicked),
              feedback: tickDrag(!isTicked),
              childWhenDragging: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
