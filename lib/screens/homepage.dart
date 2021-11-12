import 'package:flutter/material.dart';
import './horoscope.dart';
import 'package:useharian/screens/weather.dart';
import '../models/quotes.dart';
import 'dart:math';
import './news.dart';
import './covid.dart';
import './todo.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  String timeImg = '';

  int randomNumber() {
    Random random = new Random();
    int randomNum = random.nextInt(quotes.length);
    return randomNum;
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      timeImg = 'assets/images/morning.png';
      return 'Morning';
    }
    if (hour < 17) {
      timeImg = 'assets/images/sun.png';
      return 'Afternoon';
    } else {
      timeImg = 'assets/images/cloudy.png';
      return 'Evening';
    }
  }

  void goToWeather(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Weather();
        },
      ),
    );
  }

  void goToNews(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return News();
        },
      ),
    );
  }

  void goToHoroscope(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return Horoscope();
      }),
    );
  }

  void goToCovid(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return Covid();
      }),
    );
  }

  void goTotodo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return Todo();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Use-harian',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        backgroundColor: const Color.fromRGBO(34, 30, 34, 1),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(34, 30, 34, 1),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(236, 167, 44, 1),
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'Good ${greeting()}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        timeImg,
                        width: 60,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${quotes[randomNumber()]}',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => goToNews(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(68, 53, 91, 1),
                    ),
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/global-news.png',
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'News',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: InkWell(
                          onTap: () => goToWeather(context),
                          child: Card(
                            color: const Color.fromRGBO(68, 53, 91, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/weather.png',
                                    width: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'Weather',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: InkWell(
                          onTap: () => goToHoroscope(context),
                          child: Card(
                            color: const Color.fromRGBO(68, 53, 91, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/horoscope.png',
                                    width: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'Horoscope',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.27,
                        child: InkWell(
                          onTap: () => goTotodo(context),
                          child: Card(
                            color: const Color.fromRGBO(68, 53, 91, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/to-do-list.png',
                                    width: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'To Do List',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.27,
                        child: InkWell(
                          onTap: () => goToCovid(context),
                          child: Card(
                            color: const Color.fromRGBO(68, 53, 91, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/bacteria.png',
                                    width: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'Covid Tracker',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
