import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../global/globals.dart' as g;
import 'dart:convert';

class Horoscope extends StatefulWidget {
  const Horoscope({Key? key}) : super(key: key);

  @override
  _HoroscopeState createState() => _HoroscopeState();
}

class _HoroscopeState extends State<Horoscope> {
  String date = DateFormat('yMMMd').format(DateTime.now());

  void increment() {
    setState(() {
      g.signNumber++;
      apicall();
    });
  }

  void decrement() {
    setState(() {
      g.signNumber--;
      apicall();
    });
  }

  String getSign() {
    if (g.signNumber == 0) {
      g.sign = 'aries';
    } else if (g.signNumber == 1) {
      g.sign = 'taurus';
    } else if (g.signNumber == 2) {
      g.sign = 'gemini';
    } else if (g.signNumber == 3) {
      g.sign = 'cancer';
    } else if (g.signNumber == 4) {
      g.sign = 'leo';
    } else if (g.signNumber == 5) {
      g.sign = 'virgo';
    } else if (g.signNumber == 6) {
      g.sign = 'libra';
    } else if (g.signNumber == 7) {
      g.sign = 'scorpio';
    } else if (g.signNumber == 8) {
      g.sign = 'sagittarius';
    } else if (g.signNumber == 9) {
      g.sign = 'capricorn';
    } else if (g.signNumber == 10) {
      g.sign = 'aquarius';
    } else if (g.signNumber == 11) {
      g.sign = 'pisces';
    }
    return g.sign;
  }

  Future apicall() async {
    http.Response horoResponse = await http.get(Uri.parse(
        'https://raashiphal.herokuapp.com/?type=today&&sunsign=${getSign()}'));
    if (horoResponse.statusCode == 200) {
      setState(() {
        g.horoStr = horoResponse.body;
        g.horoMap = json.decode(g.horoStr);
        // print(g.horoMap);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 30, 34, 1),
        title: Column(
          children: [
            Text(
              'Horoscope',
              style: Theme.of(context).textTheme.headline2,
            ),
            const FittedBox(
              child: Text(
                'Please be patient the server for horoscopes is slow',
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(34, 30, 34, 1),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/${g.sign}.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                const SizedBox(
                  height: 15,
                ),
                g.horoMap['SunSign'] == null
                    ? Text('Loading . . ')
                    : Text(getSign().toUpperCase()),
                const SizedBox(
                  height: 15,
                ),
                g.horoMap['date'] == null
                    ? Text('Loading . .')
                    : Text('Date: $date'),
                const SizedBox(
                  height: 15,
                ),
                g.horoMap['horoscope'] == null
                    ? Text('Loading . .')
                    : Text(
                        g.horoMap['horoscope'].toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: g.signNumber == 0 ? null : decrement,
                      child: const Icon(
                        Icons.arrow_left_sharp,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    Text(' ${g.signNumber + 1} / 12'),
                    FlatButton(
                      onPressed: g.signNumber == 11 ? null : increment,
                      child: const Icon(
                        Icons.arrow_right_sharp,
                        color: Colors.white,
                        size: 50,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
