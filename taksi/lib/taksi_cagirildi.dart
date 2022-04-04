import 'package:flutter/material.dart';
import 'package:taksi/layouts/appbar.dart';
import 'package:taksi/taksiyolda.dart';

class TaksiCagirildi extends StatefulWidget {
 
  String taksiKonum;
  String musteriKonum;

  String baslangic;
  String bitis;

   TaksiCagirildi({this.taksiKonum='', this.musteriKonum='', this.baslangic='', this.bitis=''}) : super();

  @override
  _TaksiCagirildiState createState() => _TaksiCagirildiState();
}

class _TaksiCagirildiState extends State<TaksiCagirildi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: AppBarSide()),
      drawer: DrawerSide(),
      body: SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height - 125,
              width: MediaQuery.of(context).size.width - 50,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(360),
                          border: Border.all(
                              color: Colors.grey.shade200, width: 3)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: Icon(
                            Icons.check,
                            size: 75,
                            color: Colors.greenAccent,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Center(
                        child: Text(
                      'Taksiniz Başarıyla Çağırıldı',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 230,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:Border.all(color: Colors.grey) ,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 0,

                                  offset: const Offset(
                                      1, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(30, 20, 0, 0),
                                      child: Text(
                                        widget.baslangic,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(10, 20, 0, 0),
                                      child: Icon(Icons.adjust,
                                          color: Colors.blueAccent, size: 16),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 20, 0, 0),
                                      child: Text(
                                        widget.taksiKonum,
                                        style: TextStyle(
                                          fontSize: 15,

                                            color: Colors.black),
                                      ),
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(80, 0,155, 0),
                                  child: SizedBox(
                                    height: 100,
                                    child: VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1.8,
                                      indent: 20,
                                      endIndent: 0,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(22, 0, 0, 0),
                                      child: Text(
                                        widget.bitis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Icon(Icons.arrow_drop_down,
                                          color: Colors.black, size: 35),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        widget.musteriKonum,
                                        style: TextStyle(
                                            fontSize: 15,

                                            color: Colors.black),
                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
          bottomNavigationBar:   Padding(
            padding: const EdgeInsets.all(25.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => TaksiYolda()));
              },
              splashColor: Colors.yellowAccent,
              textColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: 25),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.amber,
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(18),
              ),
              color: Colors.amber,
              child: const Text(
                'Tamam',
                style:
                TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
    ));
  }
}
