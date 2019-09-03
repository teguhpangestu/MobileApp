import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var body;

  // This widget is the root of your application.
  MyApp({Key key, this.body}) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quotes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    
      home: Scaffold(
        appBar: AppBar(
        title: Text("Flutter quotes demo"),
        ),
drawer: Drawer(
  child:ListView(
    children: <Widget>[
      ListTile(title:Text("Menu 1"),
      trailing: Icon(Icons.arrow_forward),
      ),
      ListTile(title:Text("Menu 2"),
      trailing: Icon(Icons.arrow_forward),
      )
    ],
    )
),

        body: Center(child: FutureBuilder<Quote>(future: getQuote(), //
        
        builder: (contact, snapshot){
          if (snapshot.hasData){
            return Center(
              child: Column(
                children: <Widget>[
                  Text(snapshot.data.body),
                  SizedBox(height: 10.0,
                  ), 
                  Text(" - ${snapshot.data.title}"),
                ],
              ),

            );
          } else if (snapshot.hasError){
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
        ),
        ),
      ),
      
    );
  }

  
  
}

Future<Quote> getQuote() async {
  String url = 'https://jsonplaceholder.typicode.com/posts/1';
  final response = await http.get(url, headers:{"Accept":"application/json"});

  if (response.statusCode == 200){
    return Quote.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }

}
  
class Quote {
  final String title;
  final String body;

  Quote({this.title, this.body});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
        title: json['title'],
        body: json['body']);
  }
}


