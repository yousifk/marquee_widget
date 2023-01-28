import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marquee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marquee Home Page'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        children: <Widget>[
          GridTile(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Image.network(
                    'https://i.pinimg.com/564x/9d/a6/36/9da636b9e60ea40b18921b0053b7d486.jpg',
                    fit: BoxFit.fitHeight,
                    filterQuality: FilterQuality.high,
                  )),
                  Marquee(
                    child: Text(
                      'Flutter is a free and open source Google mobile UI . ',
                      style: TextStyle(fontSize: 16),
                    ),
                    autoRepeat: false,
                  ),
                ],
              ),
            ),
          ),
          GridTile(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Image.network(
                    'https://cdn-images-1.medium.com/max/1000/1*upTyVPOfBb0c4o1r57C9_w.png',
                    fit: BoxFit.fitHeight,
                    filterQuality: FilterQuality.high,
                  )),
                  Marquee(
                      child: Text(
                    'Flutter is a free and open source Google mobile UI. ',
                    style: TextStyle(fontSize: 16),
                  )),
                ],
              ),
            ),
          ),
          GridTile(
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Marquee(
                          child: Container(
                              width: 1000,
                              child: Image.network(
                                'https://i.pinimg.com/564x/9d/a6/36/9da636b9e60ea40b18921b0053b7d486.jpg',
                                fit: BoxFit.fitWidth,
                                filterQuality: FilterQuality.high,
                              )))),
                  Marquee(
                      child: Text(
                    'Flutter is a free and open source Google mobile UI... ',
                    style: TextStyle(fontSize: 16),
                  )),
                ],
              ),
            ),
          ),
          GridTile(
            child: Card(
              child: Column(
                children: <Widget>[
                  Marquee(
                      textDirection: TextDirection.rtl,
                      marqueeDirection: MarqueeDirection.forward,
                      child: Container(
                        width: 1000,
                        child: Column(
                          children: <Widget>[
                            Container(
                                width: 1000,
                                height: 260,
                                child: Image.network(
                                  'https://cdn-images-1.medium.com/max/1000/1*upTyVPOfBb0c4o1r57C9_w.png',
                                  fit: BoxFit.fitWidth,
                                  filterQuality: FilterQuality.high,
                                )),
                            Text(
                              'Flutter is a free and open source Google mobile UI ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
