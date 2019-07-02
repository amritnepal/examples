// This example makes a [Container] react to being entered by a mouse
// pointer, showing a count of the number of entries and exits.

import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for widgets.Listener',
      theme: ThemeData(
        // If the host is missing some fonts, it can cause the
        // text to not be rendered or worse the app might crash.
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementCounter(PointerEnterEvent details) {
    setState(() {
      _enterCounter++;
    });
  }

  void _decrementCounter(PointerExitEvent details) {
    setState(() {
      _exitCounter++;
    });
  }

  void _updateMove(PointerMoveEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
    print("Move  " + details.buttons.toString());
  }

  void _updateLocation(PointerHoverEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
    print("Hover " + details.buttons.toString());
  }

  void _pointerDown(PointerDownEvent details) {
    print("Down  " + details.buttons.toString());
  }

  void _pointerUp(PointerUpEvent details) {
    print("Up    " + details.buttons.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hover Example'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(500.0, 600.0)),
          child: Listener(
            onPointerDown: _pointerDown,
            onPointerUp: _pointerUp,
            onPointerEnter: _incrementCounter,
            onPointerHover: _updateLocation,
            onPointerMove: _updateMove,
            onPointerExit: _decrementCounter,
            child: Container(
              color: Colors.lightBlueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You have pointed at this box this many times:'),
                  Text(
                    '$_enterCounter Entries\n$_exitCounter Exits',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Text(
                    'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}