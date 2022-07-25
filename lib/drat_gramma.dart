import 'dart:convert';
import 'dart:math';

var name1 = "john";
Object name2 = "john";
String name3 = "john"; //three differen way to define the variables

int? nullInt; //nullable value

late int lateInt; //means this variables will init later or lazily initializing.
late int lateInt2 = _readIntLate();

int _readIntLate() {
  return 1;
}

final nameF = "leo";
const nameC =
    "leo"; //final and const are almost the same. but const was compile-time constants,it`s more strict.

var x1 = 1;
var x2 = 0xDECA934;
var x3 = 0.3; //there`s only int and double in dart.

var s1 = "this a string";
var s2 = '''
  this is a 
  multi-line string
''';
var s3 = r"this is a raw string, not event \n gets special treatment";

var list1 = [1, 2, 3];
var list2 = [1, ...list1]; //use spread operator to insert value
List<int>? list3;
var list4 = [1, ...?list3];
bool insert = true;
var list5 = [1, if (insert) 6]; //if operator to decide insert or not
var list6 = [1, for (var i in list5) ++i]; // for operator

var set1 = {"chorme", "safari"};
var set2 = <String>{};

void setFunc() {
  set1.add("..");
  set2.addAll(set1);
}

var map1 = {"first": "kim", "second": "son"};
var map2 = Map<num, String>();

void mapFunc() {
  map2[2] = "hallo";
}

var rune = "\u2664\u{1f606}";

bool isNoble(int atomicNumber) {
  return true;
}

bool isNoble2(int a) => false;

//Named parameters are optional unless they’re explicitly marked as required.
void enableFlags({bool? bold, bool? hidden}) {}

void enableFlags2(bool? bold, bool? hidden) {}

void enableFlags3({bool? bold, bool? hidden, required bool needBool}) {}

void enableFlags4(bool, int) {}

void enableFlags5(bool f1, {bool f2 = true, bool? f3}) {}

//positional parameters, it`t optional but if you use it ,use it in positional.it don`t need to have a name.
void enableFlags6(bool f1, [bool f3 = true, int f4 = 1, bool]) {}

void funTest() {
  enableFlags();
  enableFlags2(true, true);
  enableFlags3(needBool: true);
  enableFlags4(true, 1);
  enableFlags5(true, f3: true);
  enableFlags6(true, true);
  enableFlags6(true, true, 1);
  enableFlags6(true, true, 1, false);
}

var funcAsVariable = () => {};
var funcAsVariable2 = funTest();
var funcAsVariable3 = (String, int) => {};

//Function key word ， return variable in front, and argument in the ().
// like: void Function(int)
int Function(int) returnsAFunction() => (int x) => x + 1;

void funcTest2() {
  int i = returnsAFunction()(1);
}

void methodNeedFunc(int Function(String) func) {
  int result = func("dfa");
}

//some normal scope
bool level1 = true;

void funLevel1() {
  bool level2 = true;
  assert(level1);
  void funLevel2() {
    bool level3 = true;
    void funLevel3() {
      bool level4 = true;
      void funLevel4() {
        assert(level1);
        assert(level2);
        assert(level3);
        assert(level4);
      }
    }
  }
}

void funLevel5() {
  assert(level1);
  // assert(level2);
  // assert(level3);
  // assert(level4);
}

//beautiful cascade notation, .. or ?..
void cascade() {
  var list = {1, 2, 3, 4}
    ..add(1)
    ..forEach((element) {
      element + 1;
    })
    ..clear();

  List<int>? list2;
  list2
    ?..add(1)
    ..add(2)
    ..forEach((element) {
      element + 1;
    })
    ..clear();
}

//a little different catch
void trycatch() {
  try {
    print("wrong ");
  } on OutOfMemoryError catch (e) {
    print("error $e");
  } on IndexError {
    print("error nothingtosay");
  } catch (e) {
    print("error $e");
    rethrow; //rethrow the error
  }
}

class Person {
  Person(int, String);

  Person.fromJson(String);

  //initializer list , do something before constructor body run
  Person.fromXml(String xml, int size) : assert(size > 10) {}

  late int i;
  late var j;

  Person.fromJson2(Map<String, int> json)
      : i = json.length,
        j = json["ee"] {}

  num? k;

  Person.fromNum(this.k) {}
}

class Farmer extends Person {
  //same as Farmer(final int x, final String y):super(x, y)
  Farmer(super.int, super.String);
}

class Worker extends Person {
  //specify the super constructor
  Worker() : super.fromJson("null") {}

  Worker.fromDiffJson(String json) : super(40, json) {}
}

void constructorTest() {
  var p1 = Person(10, "Mark");
  var p2 = Person.fromJson("{name:Mark,age:10}");

  var f = Farmer(30, "frank");

  var w1 = Worker();
  var w2 = Worker.fromDiffJson("name : watson");
}

class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}

void loggerUser() {
  var logger = Logger("n");
  var logger2 = Logger.fromJson({"json": Object()});
}

//define operater method
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector a) {
    var i = 0;
    return Vector(a.x + x, a.y + y);
  }

  Vector operator *(int n) => Vector(x * n, n ~/ y);
}

class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  double get right => left + width;

  set right(double v) => v - left;
}

void extensionMethods() {
  "42".padLeft(3);
}

enum Vehicle implements Comparable<Vehicle> {
  car(),
  bus();

  @override
  int compareTo(Vehicle other) {
    return 1;
  }
}

//give String class a extend method
extension ParseNumber on String {
  int toInt() {
    return int.parse(this);
  }

  void toSpecialString(){
    print("999");
  }
}
void extensionTest(){
  "999".toSpecialString();
  "999".toInt();
}

