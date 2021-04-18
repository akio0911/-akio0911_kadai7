import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _selectedPageIndex = 0;

  static List<Widget> _pageList = [
    AdditionPage(),
    SubtractionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Addition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Subtraction',
          ),
        ],
        currentIndex: _selectedPageIndex,
        onTap: (int index) {
          setState(() {
            _selectedPageIndex = index;
          });
        }
      ),
    );
  }
}

class CalculationPage extends StatefulWidget {
  CalculationPage({
    Key key,
  }) : super(key: key);

  @override
  _CalculationPageState createState() => _CalculationPageState();

  double calculate({double value1, double value2}) {
    return 0;
  }

  Color backgroundColor() {
    return Colors.white;
  }
}

class _CalculationPageState extends State<CalculationPage> {
  final _number1Controller = TextEditingController();
  final _number2Controller = TextEditingController();

  double _resultValue = 0;

  @override
  Widget build(BuildContext context) {
    final items = Column(
      children: [
        SizedBox(height: 16),
        _buildNumberTextField(
          controller: _number1Controller,
          labelText: '数値1',
        ),
        SizedBox(height: 16),
        _buildNumberTextField(
          controller: _number2Controller,
          labelText: '数値2',
        ),
        SizedBox(height: 16),
        _buildCalculationButton(),
        SizedBox(height: 16),
        _buildResultText(),
      ],
    );

    return Container(
      child: items,
      padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
      color: widget.backgroundColor(),
    );
  }

  Widget _buildNumberTextField({TextEditingController controller, String labelText}) {
    return Container(
      color: Colors.white,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      )
    );
  }

  Widget _buildCalculationButton() {
    return TextButton(
        onPressed: () {
          final value1 = double.tryParse(_number1Controller.text);
          final value2 = double.tryParse(_number2Controller.text);

          if (value1 == null || value2 == null) {
            return;
          }

          setState(() {
            _resultValue = widget.calculate(value1: value1, value2: value2);
          });
        },
        child: Text('計算', style: TextStyle(color: Colors.blue))
    );
  }

  Widget _buildResultText() {
    return Text('$_resultValue');
  }
}

class AdditionPage extends CalculationPage {
  @override
  double calculate({double value1, double value2}) {
    return value1 + value2;
  }

  @override
  Color backgroundColor() {
    return Colors.amber;
  }
}

class SubtractionPage extends CalculationPage {
  @override
  double calculate({double value1, double value2}) {
    return value1 - value2;
  }

  @override
  Color backgroundColor() {
    return Colors.lightGreen;
  }
}
