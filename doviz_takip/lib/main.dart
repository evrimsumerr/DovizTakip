import 'package:async/async.dart';
import 'package:doviztakip/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:doviztakip/widgets/currencyValues.dart';
import 'package:doviztakip/utilities.dart';


const request = "https://finans.truncgil.com/today.json";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(subtitle1: TextStyle(color: BodyTextColor)),
        scaffoldBackgroundColor: BackgroundColor,
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BackgroundColor,
        appBar: AppBar(
            title: Text("Döviz Takip",
                style: GoogleFonts.thasadith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25.0)),
            leading: IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.info),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Nasıl Çalışır?",
                        style: GoogleFonts.thasadith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      content: Text(
                        "Her 15 dakikada bir veriler otomatik olarak güncellenmektedir.",
                        style: GoogleFonts.thasadith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          textColor: Colors.green,
                          child: Text('TAMAM'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  }),
            ),
            centerTitle: true,
            backgroundColor: Colors.green),
        body: FutureBuilder(
          future: fetchAPI(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  color: BackgroundColor,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 30,
                              color: ShadowColor),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.monetization_on,
                            size: 50,
                            color: Colors.green,
                          ),
                          VerticalDivider(
                            color: Colors.black26,
                          ),
                          currencyValues(
                            value: "${snapshot.data.dolarAlis} ₺",
                            title: "Dolar Alış Fiyatı",
                          ),
                          VerticalDivider(
                            color: Colors.black26,
                          ),
                          currencyValues(
                            value: "${snapshot.data.dolarSatis} ₺",
                            title: "Dolar Satış Fiyatı",
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 30,
                              color: ShadowColor),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.euro_symbol,
                            size: 50,
                            color: Colors.blue,
                          ),
                          VerticalDivider(
                            color: Colors.black26,
                          ),
                          currencyValues(
                            value: "${snapshot.data.euroAlis} ₺",
                            title: "Euro Alış Fiyatı",
                          ),
                          VerticalDivider(
                            color: Colors.black26,
                          ),
                          currencyValues(
                            value: "${snapshot.data.euroSatis} ₺",
                            title: "Euro Satış Fiyatı",
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 30,
                              color: ShadowColor),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            "assets/199542.png",
                            width: 50,
                            height: 50,
                          ),
                          VerticalDivider(
                            color: Colors.black26,
                          ),
                          currencyValues(
                            value: "${snapshot.data.altinAlis} ₺",
                            title: "Gram Altın Alış",
                          ),
                          VerticalDivider(
                            color: Colors.black26,
                          ),
                          currencyValues(
                            value: "${snapshot.data.altinSatis} ₺",
                            title: "Gram Altın Satış",
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "Son Güncellenme Tarihi : ${snapshot.data.date}",
                          style: GoogleFonts.thasadith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }

  Future<currency> fetchAPI() async {
    final response = await http.get("https://finans.truncgil.com/today.json");
    final parsedData = json.decode(response.body).cast<String, dynamic>();
    //print(parsedData);
    return currency.createJson(parsedData);
  }
}
