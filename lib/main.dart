import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

const request = "https://api.hgbrasil.com/finance";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.black,
    primaryColor: Colors.white),

  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text(
                "Carregando...",
                style: TextStyle(color: Colors.black, fontSize: 25),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "INFELIZMEEENTE... TEVE ERRO!",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.monetization_on,
                          size: 150, color: Colors.black),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Real",
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            prefixText: "R\$"),
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Dolár",
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            prefixText: "US\$"),
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Euro",
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            prefixText: "€"),
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
