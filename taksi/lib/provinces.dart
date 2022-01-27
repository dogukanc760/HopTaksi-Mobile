import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:taksi/giris_yap.dart';
import 'package:shared_preferences/shared_preferences.dart';


class provinces extends StatefulWidget {
  const provinces({Key key}) : super(key: key);

  @override
  _provincesState createState() => _provincesState();
}

class _provincesState extends State<provinces> {
  int values = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF333333),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Expanded(
            child: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          width: 500,
                          alignment: Alignment.topCenter,
                          child: Text(
                            'İl Seçiniz',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'Angsana New'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              width: 1,
                              color: Color(0xFF333333),
                              style: BorderStyle.solid),
                        ),
                        child: TextField(
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.black54),
                              hintText: "Bulunduğunuz İlin Plakasını Yazın...",
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                          child: MyContainer(1),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                          child: MyContainer(2),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(3)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(4)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(5)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(6)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                          child: MyContainer(7),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(8)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(9)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(10)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(11)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(12)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(13)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(14)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(15)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(16)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(17)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(18)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(19)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(20)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(21)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(22)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(23)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(24)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(25)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(26)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(27)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(28)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(29)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(30)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(31)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(32)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(33)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(34)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(35)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(36)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(37)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(38)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(39)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(40)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(41)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(42)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(43)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(44)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(45)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(46)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(47)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(48)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(49)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(50)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(51)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(52)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(53)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(54)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(55)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(56)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(57)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(58)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(59)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(60)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(61)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(62)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(63)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(64)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(65)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(66)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(67)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(68)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(69)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(70)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(71)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(72)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(73)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(74)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(75)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(76)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(77)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(78)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(79)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 5, 2),
                            child: MyContainer(80)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50.0, 0, 5, 2),
                            child: MyContainer(81)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container MyContainer(int value) {
    void setSession() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setInt('plate', value);

      });
      print(prefs.getInt('plate').toString());

    }
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 11,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        width: 60,
        child: RaisedButton(
          onPressed: () {
            setSession();
            values = value;
           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => giris_yap(),
              ),
            );
          },
          splashColor: Colors.yellowAccent,
          textColor: Colors.black,
          padding: const EdgeInsets.all(1.0),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Colors.yellowAccent, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(18),
          ),
          color: Colors.yellow,
          child: Text(
            '$value',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
