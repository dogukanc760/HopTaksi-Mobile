import 'package:flutter/material.dart';

import 'layouts/appbar.dart';


class ProviderMain extends StatefulWidget {
  const ProviderMain({ Key key }) : super(key: key);

  @override
  _ProviderMainState createState() => _ProviderMainState();
}

class _ProviderMainState extends State<ProviderMain> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: AppBarSide()),
      drawer: DrawerSide(),
      body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: SingleChildScrollView(
            child: Stack(children: [Container(child: Content())]),
          )),
    ));
  }
}


class Content extends StatefulWidget {
  const Content({ Key key }) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}