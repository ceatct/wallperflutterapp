import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}
// BIgELwSqU5jxEZHcYE7OnOR2rQp3B_7M-wMrZOOiMbU
class _MyAppState extends State<MyApp>{

  late List data;

  @override
  void initState(){
    super.initState();
    fetchimages();
  }

  Future<String> fetchimages() async{
    var fetchdata = await http.get(Uri.parse('https://api.unsplash.com/search/photos?per_page=30&client_id=BIgELwSqU5jxEZHcYE7OnOR2rQp3B_7M-wMrZOOiMbU&query=nature'));

    var jsondata = json.decode(fetchdata.body);

    setState((){
      data = jsondata['results'];
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Wallpaper App",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Wallpaper App"),
        ),
        body: Builder(builder: (context) =>
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Stack(children: <Widget>[
                     Padding(
                padding: const EdgeInsets.only(top:40.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                ),
                child: Image.network(
                data[index]['urls']['small'],
                  fit: BoxFit.cover,
                  height: 500.0,
                ),
                  ),
                  ),
                ],
                );
              },
              itemCount: 10,
              autoplay: true,
              viewportFraction: 0.8,
              scale: 0.9,
            )
        )
      ),
    );
  }
}