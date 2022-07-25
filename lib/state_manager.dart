import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    // home: TapboxA(),
    // home: ParentWidge(),
  ));
}

//=======================================
//=========manager the state itself
class TapboxA extends StatefulWidget {
  TapboxA({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? "Active" : "InActive",
            style: TextStyle(fontSize: _active ? 32 : 24, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//========================================
//parent manager child`s state
//=============parent====================
class ParentWidge extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidge> {
  bool _state = false;

  void _hadleTapboxChange(bool newValue) {
    setState(() {
      _state = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapBoxB(
        active: _state,
        onChange: _hadleTapboxChange,
      ),
    );
  }
}

//================TapBox===================
class TapBoxB extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChange;

  TapBoxB({Key? key, this.active: false, required this.onChange})
      : super(key: key);

  void _handleTap() {
    onChange(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
        child: Center(
          child: Text(
            active ? "Active" : "Inactive",
            style: const TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
