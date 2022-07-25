import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageStatus();
}

class _MainPageStatus extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Socket Tool"),
          actions: [
            IconButton(
              onPressed: () {
                socketListView.addView();
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          children: [
            socketListView,
          ],
        ));
  }
}

final socketBeenList = <SocketBeen>[
  SocketBeen("172.0.0.1", 11),
  SocketBeen("172.0.0.1", 12),
  SocketBeen("172.0.0.1", 13)
];

class SocketBeen {
  String ip;
  int port;

  SocketBeen(this.ip, this.port);
}

var socketList = ListView.separated(
    itemBuilder: (_, index) =>
        Text("${socketBeenList[index].ip}:${socketBeenList[index].port}"),
    separatorBuilder: (_, index) =>
    const Divider(
      height: 20,
      color: Colors.lightGreen,
    ),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: socketBeenList.length);

void addSocket() {
  socketBeenList.add(SocketBeen("172.0.0.1", 11));
}

var socketListView = SocketListView();

class SocketListView extends StatefulWidget {
  final _socketListView = _SocketListView();

  @override
  State<StatefulWidget> createState() {
    return _socketListView;
  }

  void addView() {
    _socketListView.addView();
  }
}

class _SocketListView extends State<SocketListView> {
  final socketsList = <SocketBeen>[];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, index) =>
            Text("${socketsList[index].ip}:${socketsList[index].port}"),
        separatorBuilder: (_, index) =>
        const Divider(
          height: 0.2,
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: socketsList.length);
  }

  @override
  void initState() {
    super.initState();
    socketsList.add(SocketBeen("172.0.0.1", 11));
    socketsList.add(SocketBeen("172.0.0.1", 12));
  }

  void addView() {
    setState(() {
      socketsList.add(SocketBeen("172.0.0.1", 14));
    });
  }
}
