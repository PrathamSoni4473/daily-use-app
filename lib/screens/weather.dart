import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../global/globals.dart' as g;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/quotes.dart';
import 'dart:math';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

int randomNumber() {
  Random random = new Random();
  int randomNum = random.nextInt(quotes.length);
  return randomNum;
}

class _WeatherState extends State<Weather> {
  void get_location() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    g.lat = double.parse("${position.latitude}");
    g.long = double.parse("${position.longitude}");

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placeMark = placemarks[0];
      // apicall();
      setState(() {
        g.city = placeMark.locality;
        apicall();
      });
      print('${g.city}');
    } catch (err) {}
  }

  Future apicall() async {
    http.Response responseWeather = await http.get(Uri.parse(
      'https://weatherapi-com.p.rapidapi.com/forecast.json?q=${g.city}&days=3&rapidapi-key=08fc6b8d24msh0ba2b030e801904p1f5d5fjsn2a16e871987b',
    ));
    if (responseWeather.statusCode == 200) {
      setState(() {
        g.stringResponse = responseWeather.body;
        g.mapResponse = json.decode(g.stringResponse);

        g.listResponse = g.mapResponse['forecast']['forecastday'];
        g.imageUrl1 = g.listResponse[0]['day']['condition']['icon'];
        g.imageUrl2 = g.listResponse[1]['day']['condition']['icon'];
        g.imageUrl3 = g.listResponse[2]['day']['condition']['icon'];
        g.status1 = g.listResponse[0]['day']['condition']['text'];
        g.status2 = g.listResponse[1]['day']['condition']['text'];
        g.status3 = g.listResponse[2]['day']['condition']['text'];

        // g.status4 = g.listResponse[3]['day']['condition']['text'];
        // print(g.mapResponse['current']['condition']['text']);
        print('status 1: ${g.status1}');
        print('status 2: ${g.status2}');
        print('status 3: ${g.status3}');
      });
    }
    // ==============================================
  }

  String getStatement() {
    String temp = g.status1.toString();
    if (temp.contains('Sunny') || temp.contains('sunny')) {
      g.weatherStatement =
          'Whoaa .. make sure to get your Sun Glasses out with you. 🕶️ ';
    } else if (temp.contains('Rain') || temp.contains('rain')) {
      g.weatherStatement = 'Make sure to get your umbrella today ☂️';
    }
    return g.weatherStatement;
  }

  final now = DateTime.now();

  String getTomorrow() {
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    String day2 = DateFormat('E').format(tomorrow);
    return day2;
  }

  String getDAT() {
    final tomorrow = DateTime(now.year, now.month, now.day + 2);
    String day3 = DateFormat('E').format(tomorrow);
    return day3;
  }

  String day1 = DateFormat('E').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    get_location();
    getStatement();
    // apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 30, 34, 1),
        title: Text(
          'Weather',
          style: Theme.of(context).textTheme.headline2,
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
        child: Column(
          children: [
            g.weatherStatement == null
                ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(238, 86, 34, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      loadingWeather[randomNumber()],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(238, 86, 34, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: getStatement() == ''
                        ? const Text('Beep Boop LOADING . . ')
                        : Text(
                            getStatement(),
                          ),
                  ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(49, 38, 62, 1),
              ),
              padding: const EdgeInsets.all(15),
              child: g.status1 == null
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            loadingWeather[randomNumber()],
                            style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.3,
                          padding: const EdgeInsets.all(10),
                          color: const Color.fromRGBO(68, 53, 91, 1),
                          child: Column(
                            children: [
                              Image.network(
                                'https:${g.imageUrl1}',
                                width: 100,
                              ),
                              Text(
                                day1,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(g.status1),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.3,
                          padding: const EdgeInsets.all(10),
                          color: const Color.fromRGBO(68, 53, 91, 1),
                          child: Column(
                            children: [
                              Image.network(
                                'https:${g.imageUrl2}',
                                width: 100,
                              ),
                              Text(
                                getTomorrow(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(g.status2),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.3,
                          padding: const EdgeInsets.all(10),
                          color: const Color.fromRGBO(68, 53, 91, 1),
                          child: Column(
                            children: [
                              Image.network(
                                'https:${g.imageUrl3}',
                                width: 100,
                              ),
                              Text(
                                getDAT(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                g.status3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.white,
            ),
            Text(
              weatherjoke[randomNumber()],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 25,
            ),
            Image.asset(
              'assets/images/cool.png',
              width: 100,
            )
          ],
        ),
      ),
    );
  }
}
