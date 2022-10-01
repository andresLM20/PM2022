import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  var contador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Stateless vs Stateful',
        style: TextStyle(color: Colors.indigo[50]),
      )),
      body: Center(
        child: Text(
          'Contador: $contador',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          contador++;
          print(contador);
          setState(() {});
        },
        child: Icon(
          Icons.ads_click,
          color: Colors.black87,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
