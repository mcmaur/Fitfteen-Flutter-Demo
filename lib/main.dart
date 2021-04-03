import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fifteen Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal[100],
            onPrimary: Colors.red,
            onSurface: Colors.grey,
            textStyle: TextStyle(
                color: Colors.black, fontSize: 35, fontStyle: FontStyle.italic),
            padding: EdgeInsets.all(5),
          ),
        ),
      ),
      home: MyHomePage(title: 'Fifteen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<int>> _matrix;
  String doneText;

  _MyHomePageState() {
    doneText = "";

    _matrix = <List<int>>[];
    int value = 1;
    for (var i = 0; i < 4; i++) {
      List<int> list = <int>[];
      for (var j = 0; j < 4; j++) {
        list.add(value);
        value++;
      }
      _matrix.add(list);
    }
  }

  void _shuffle() {
    List allNumbers = List<int>.generate(16, (int index) => index + 1);
    allNumbers.shuffle();

    int index = 0;
    for (var x = 0; x < 4; x++) {
      for (var y = 0; y < 4; y++) {
        _matrix[x][y] = allNumbers[index];
        index++;
      }
    }

    setState(() {
      _matrix = _matrix;
      doneText = "";
    });
  }

  String _toButtonString(int x, int y) {
    int val = _matrix[x][y];
    if (val == 16) return '';
    return val.toString();
  }

  void _move(int x, int y) {
    bool moved = false;

    //cella superiore
    if (!moved && x > 0 && _matrix[x - 1][y] == 16) {
      _matrix[x - 1][y] = _matrix[x][y];
      _matrix[x][y] = 16;
      moved = true;
    }

    //cella a destra
    if (!moved && y < 3 && _matrix[x][y + 1] == 16) {
      _matrix[x][y + 1] = _matrix[x][y];
      _matrix[x][y] = 16;
      moved = true;
    }

    //cella inferiore
    if (!moved && x < 3 && _matrix[x + 1][y] == 16) {
      _matrix[x + 1][y] = _matrix[x][y];
      _matrix[x][y] = 16;
      moved = true;
    }

    //cella a sinistra
    if (!moved && y > 0 && _matrix[x][y - 1] == 16) {
      _matrix[x][y - 1] = _matrix[x][y];
      _matrix[x][y] = 16;
      moved = true;
    }

    setState(() {
      _matrix = _matrix;
    });

    int value = 1;
    bool completed = true;
    for (var x = 0; x < 4; x++) {
      for (var y = 0; y < 4; y++) {
        if (_matrix[x][y] != value) completed = false;
        value++;
      }
    }
    if (completed) doneText = "You finished!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () => _move(0, 0),
                        child: Text(_toButtonString(0, 0))),
                    ElevatedButton(
                        onPressed: () => _move(1, 0),
                        child: Text(_toButtonString(1, 0))),
                    ElevatedButton(
                        onPressed: () => _move(2, 0),
                        child: Text(_toButtonString(2, 0))),
                    ElevatedButton(
                        onPressed: () => _move(3, 0),
                        child: Text(_toButtonString(3, 0))),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () => _move(0, 1),
                        child: Text(_toButtonString(0, 1))),
                    ElevatedButton(
                        onPressed: () => _move(1, 1),
                        child: Text(_toButtonString(1, 1))),
                    ElevatedButton(
                        onPressed: () => _move(2, 1),
                        child: Text(_toButtonString(2, 1))),
                    ElevatedButton(
                        onPressed: () => _move(3, 1),
                        child: Text(_toButtonString(3, 1))),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () => _move(0, 2),
                        child: Text(_toButtonString(0, 2))),
                    ElevatedButton(
                        onPressed: () => _move(1, 2),
                        child: Text(_toButtonString(1, 2))),
                    ElevatedButton(
                        onPressed: () => _move(2, 2),
                        child: Text(_toButtonString(2, 2))),
                    ElevatedButton(
                        onPressed: () => _move(3, 2),
                        child: Text(_toButtonString(3, 2))),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () => _move(0, 3),
                        child: Text(_toButtonString(0, 3))),
                    ElevatedButton(
                        onPressed: () => _move(1, 3),
                        child: Text(_toButtonString(1, 3))),
                    ElevatedButton(
                        onPressed: () => _move(2, 3),
                        child: Text(_toButtonString(2, 3))),
                    ElevatedButton(
                        onPressed: () => _move(3, 3),
                        child: Text(_toButtonString(3, 3))),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(doneText),
                    ElevatedButton(onPressed: _shuffle, child: Text('Shuffle')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
