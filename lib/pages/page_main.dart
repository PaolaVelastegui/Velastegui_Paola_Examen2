import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Comida Rapida')),
        body: Center(
          child: Text(
            'Pagina principal',
            style: TextStyle(fontSize: 15.0),
          ),
        ));
  }
}
