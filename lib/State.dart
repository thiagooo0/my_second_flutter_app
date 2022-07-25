import 'dart:io';

import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key, this.initValue = 0}) : super(key: key);

  final int initValue;

  @override
  State<StatefulWidget> createState() {
    return _CounterWidgetState();
  }
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    debugPrint("initState");
    _counter = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("$_counter"),
          onPressed: () => setState(() => {++_counter}),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("deactivate");
  }

  @override
  void reassemble() {
    super.reassemble();
    debugPrint("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("dispose");
  }
}

class StateLifecycleTest extends StatelessWidget {
  const StateLifecycleTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterWidget(),
      // home:Text("//")
    );
  }
}

void main() {
  runApp(StateLifecycleTest());
}

Future<void> connect() async {
  try {
    var socket = await Socket.connect("127.0.0.1", 1034);
    socket.listen((data) {

    }, onDone: () {}, onError: () {}, cancelOnError: false);
  } catch (err) {}
  int lineCount;
}
