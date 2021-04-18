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
    CalculationPage(
        calculate: (value1, value2){
          return value1 + value2;
        },
        backgroundColor: Colors.amber,
    ),
    CalculationPage(
        calculate: (value1, value2){
          return value1 - value2;
        },
        backgroundColor: Colors.lightGreen,
    ),
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
  final double Function(double, double) _calculate;
  final Color _backgroundColor;

  CalculationPage({
    Key key,
    double Function(double, double) calculate,
    Color backgroundColor
  }) : this._calculate = calculate, this._backgroundColor = backgroundColor, super(key: key);

  @override
  _CalculationPageState createState() => _CalculationPageState();
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
      color: widget._backgroundColor,
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
            _resultValue = widget._calculate(value1, value2);
          });
        },
        child: Text('計算', style: TextStyle(color: Colors.blue))
    );
  }

  Widget _buildResultText() {
    return Text('$_resultValue');
  }
}
