import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

class kalkulator extends StatefulWidget {
  const kalkulator({Key? key}) : super(key: key);

  @override
  _kalkulatorState createState() => _kalkulatorState();
}

class _kalkulatorState extends State<kalkulator> {
  double? _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    var calc = SimpleCalculator(
      value: _currentValue!,
      hideExpression: false,
      hideSurroundingBorder: true,
      autofocus: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? 0;
        });
        if (kDebugMode) {
          print('$key\t$value\t$expression');
        }
      },
      onTappedDisplay: (value, details) {
        if (kDebugMode) {
          print('$value\t${details.globalPosition}');
        }
      },
      theme: const CalculatorThemeData(
        borderColor: Colors.green, // Ubah warna border menjadi hijau
        borderWidth: 2,
        displayColor: Colors.green, // Ubah warna display menjadi hijau
        displayStyle: TextStyle(fontSize: 80, color: Colors.yellow),
        expressionColor: Colors.green, // Ubah warna expression menjadi hijau
        expressionStyle: TextStyle(fontSize: 20, color: Colors.white),
        operatorColor: Colors.green, // Ubah warna operator menjadi hijau
        operatorStyle: TextStyle(fontSize: 30, color: Colors.white),
        commandColor: Colors.green, // Ubah warna command menjadi hijau
        commandStyle: TextStyle(fontSize: 30, color: Colors.white),
        numColor: Colors.green, // Ubah warna num menjadi hijau
        numStyle: TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
    return OutlinedButton(
      child: Text(_currentValue.toString()),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: calc,
            );
          },
        );
      },
    );
  }
}
