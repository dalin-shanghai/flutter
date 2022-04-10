import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _gestureDetected = "";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            _buildGestureDetector(),
            Divider(
              color: Colors.black,
              height: 44.0,
            ),
            _buildDraggable(),
            Divider(
              height: 40.0,
            ),
            _buildDragTarget(),
            Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector _buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        print('onTap');
        _displayGestureDetected('onTap');
      },
      onDoubleTap: () {
        print('onDoubleTap');
        _displayGestureDetected('onDoubleTap');
      },
      onLongPress: () {
        print('onLongPress');
        _displayGestureDetected('onLongPress');
      },
      onPanUpdate: (DragUpdateDetails details) {
        print('onPanUpdate: $details');
        _displayGestureDetected('onPanUpdate:\n$details');
      },
      /*onVerticalDragUpdate: (DragUpdateDetails details) {
        print('onVerticalDragUpdate: $details');
        _displayGestureDetected('onVertivalDragUpdate: \n$details');
      },*/
      onHorizontalDragUpdate: (DragUpdateDetails detail) {
        print('onHorizontalDragUpdate: $detail');
        _displayGestureDetected('onHorizontalDragUpdate: \n$detail');
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        print('onHorizontalGragEnd: $details');
        if ((details.primaryVelocity ?? 0) < 0) {
          print('Dragging Right to Left: ${details.primaryVelocity}');
        } else if ((details.primaryVelocity ?? 0) > 0) {
          print('Dragging Left to Right: ${details.velocity}');
        }
      },
      child: Container(
        color: Colors.lightGreen.shade100,
        width: double.infinity,
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.access_alarm,
              size: 98.0,
            ),
            Text('$_gestureDetected')
          ],
        ),
      ),
    );
  }

  Draggable<int> _buildDraggable() {
    return Draggable(
      child: Column(
          children: <Widget>[
            Icon(
              Icons.palette,
              color: Colors.deepOrange,
              size: 48.0,
            ),
            Text(
              'Drag Me below to change color',
            ),
          ],
        ),
      childWhenDragging: Icon(
          Icons.palette,
          color: Colors.grey,
          size: 48.0,
        ),
      feedback: Icon(
          Icons.brush,
          color: Colors.deepOrange,
          size: 80.0,
        ),
      data: Colors.deepOrange.value,
    );
  }

  DragTarget<int> _buildDragTarget() {
    Color _printedColor = Colors.lightBlue;
    return DragTarget<int>(
      onAccept: (colorValue) {
        _printedColor = Color(colorValue);
      },
      builder: (BuildContext context, List<dynamic> acceptedData, List<dynamic> rejectedData) {
        return acceptedData.isEmpty ? Text(
            'Drag To and see color change',
            style: TextStyle(color: _printedColor)
        ): Text(
          'Painting Color: $acceptedData',
          style: TextStyle(
            color: Color(acceptedData[0]),
            fontWeight: FontWeight.bold
          ),
        );
      },
    );
  }

  void _displayGestureDetected(String gesture) {
    setState(() {
      _gestureDetected = gesture;
    });
  }
}

