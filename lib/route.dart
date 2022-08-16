import 'package:flutter/material.dart';

/***
 * route means a page, like activity on android.
 *
 * MaterialPageRoute , extend from PageRoute. PageRoute is an abstract class, means
 * a vritual page with full-size window space.
 * MaterialPageRoute can provide platform related page change animation.
 */
main() {
  runApp(MaterialApp(
    // home: HomeRoute(),
    home: RouterTestRoute(),
    routes: {
      "newPage"
    },
  ));
}

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewRoute();
          }));
        },
        child: Container(
          child: Center(
            child: Text(
              "Jump",
              style: TextStyle(fontSize: 33, fontStyle: FontStyle.italic),
            ),
          ),
        ));
  }
}
// child: Center(
// child: Text("Jump", style: TextStyle(fontSize: 33)),
// ),
// width: 200,
// height: 200,

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

//// ------------ unnamed route pass value-----------
class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Open Tip Page"),
        onPressed: () async {
          //open TipRoute and wait for result
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return TipRoute(
              text: "tip xxxx",
            );
          }));
          print("route return value $result");
        },
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tip"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              Text(text),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, "I am return value:job done");
                  },
                  child: Text("Back"))
            ],
          ),
        ),
      ),
    );
  }
}

////========== Named Route =========
