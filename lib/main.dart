import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:my_second_flutter_app/MainPage.dart'; // Add this line.

void main() {
  runApp(const Namer());
}

class GetStateObjectRoute extends StatefulWidget {
  GetStateObjectRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GetStateObjectRouteState();
  }
}

class _GetStateObjectRouteState extends State<GetStateObjectRoute> {
  static final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: const Text("子树中获取state对象"),
        ),
        drawerEnableOpenDragGesture: false,
        drawer: Builder(
          builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  ScaffoldState _state =
                      context.findAncestorStateOfType<ScaffoldState>()!;
                  debugPrint("关闭菜单");
                  _state.closeDrawer();
                },
                child: const Text("关闭抽屉"));
          },
        ),
        body: Center(
          child: Column(
            children: [
              Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () {
                      ScaffoldState _state =
                          context.findAncestorStateOfType<ScaffoldState>()!;
                      debugPrint("打开菜单1");
                      _state.openDrawer();
                    },
                    child: Text("打开抽屉菜单1"));
              }),
              Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () {
                      debugPrint("打开菜单2");
                      _globalKey.currentState?.openDrawer();
                    },
                    child: Text("打开抽屉菜单2"));
              }),
            ],
          ),
        ),
      );
}

class Namer extends StatelessWidget {
  const Namer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome to Flutter",
      debugShowCheckedModeBanner: false,
      // home: const MainPage(),
      home: GetStateObjectRoute(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      )),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>{};

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final tiles = _saved.map((pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(tiles: tiles, context: context).toList()
          : <Widget>[];
      return Scaffold(
          appBar: AppBar(
            title: const Text("Save Suggestions"),
          ),
          body: ListView(
            children: divided,
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Name Generator"),
        actions: [
          IconButton(onPressed: _pushSaved, icon: const Icon(Icons.list)),
          IconButton(onPressed: null, icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            if (_suggestions.length <= index) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            final alreadySaved = _saved.contains(_suggestions[index]);
            return ListTile(
              title: Text(
                _suggestions[index].asPascalCase,
                style: _biggerFont,
              ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
                semanticLabel: alreadySaved ? "Remove from saved" : "Save",
              ),
              onTap: () {
                setState(() {
                  if (alreadySaved) {
                    _saved.remove(_suggestions[index]);
                  } else {
                    _saved.add(_suggestions[index]);
                  }
                });
              },
            );
          }),
    );
  }
}
