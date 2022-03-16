import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _title = "Flutter demo";
  var nameList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(_title),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              try {
                final String result = await MethodChannel('demo.flutter')
                    .invokeMethod('getAppInfo');
                var array = json.decode(result);

                setState(() {
                  for (var item in array) {
                    nameList.add(item.toString());
                  }
                });
              } on PlatformException {
                //todo
              }
            },
          ),
          body: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: nameList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: Center(child: Text('Entry ${nameList[index]}')),
                );
              }),
        ),
      ),
    );
  }
}
