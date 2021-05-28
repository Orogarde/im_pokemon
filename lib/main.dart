import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "I'm Pokemon",
      theme: ThemeData.dark(),
      home: MyHomePage(title: "I'm Pokemon"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  late String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<AssetImage, String> pokedex = {
    AssetImage('images/gobou.png'): 'gobou',
    AssetImage('images/flobio.png'): 'flobio',
    AssetImage('images/laggron.png'): 'laggron',
    AssetImage('images/mega-laggron.png'): 'mega-laggron',
  };
  List<AssetImage> _images = [
    AssetImage('images/gobou.png'),
    AssetImage('images/flobio.png'),
    AssetImage('images/laggron.png'),
    AssetImage('images/mega-laggron.png'),
  ];
  int _counter = 0;
  String sens = 'asc';
  late AssetImage _currentImage = _images[0];
  late String name = 'gobou';

  void _changeImage() async {
    final previousImage = _currentImage.assetName.toString();
    final one = _images.firstWhere((img) => img.assetName == previousImage);
    if (_counter == _images.length - 1 && sens == 'asc') {
      sens = 'desc';
    }
    if (_counter == 0 && sens == 'desc') {
      sens = 'asc';
    }
    if (sens == 'asc') {
      _counter++;
    }
    if (sens == 'desc') {
      _counter--;
    }
    _currentImage = _images[_counter];
    final nextImage = _images[_counter].assetName.toString();
    final preImage = _images.firstWhere((img) => img.assetName == nextImage);

    Future<void> time(AssetImage arg) {
      return Future.delayed(
        Duration(milliseconds: 400),
        () => {
          setState(
            () {
              if (sens == 'asc') {
                name = 'Evolution';
              }
              if (sens == 'desc') {
                name = 'Désévolution';
              }
              _currentImage = arg;
            },
          ),
        },
      );
    }

    for (var i = 0; i <= 6; i++) {
      if (i % 2 == 0) {
        await time(preImage);
      } else {
        await time(one);
      }
    }
    _currentImage = _images[_counter];
    name = pokedex[_currentImage].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.deepOrangeAccent.shade400,
              Colors.black12,
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.title),
            backgroundColor: Colors.black26,
          ),
          body: ListView(
            children: [
              Container(
                height: 600,
                width: 600,
                child: GestureDetector(
                  onTap: () => _changeImage(),
                  child: Center(child: Image(image: _currentImage)),
                ),
              ),
              Center(
                child: Text(name,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 30,
                    )),
              ),
            ],
          ),
        ));
  }
}
