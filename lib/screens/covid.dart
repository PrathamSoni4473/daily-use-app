import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global/globals.dart' as g;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Covid extends StatefulWidget {
  const Covid({Key? key}) : super(key: key);

  @override
  State<Covid> createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

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
        g.state = placeMark.administrativeArea;
        // g.state = 'Maharashtra';
        g.city = placeMark.locality;
        g.country = placeMark.country;
        apicall();
      });
      print('${g.city} ${g.state} ${g.country}');
    } catch (err) {}
  }

  Future apicall() async {
    http.Response covidResponse =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/gov/India'));
    if (covidResponse.statusCode == 200) {
      setState(() {
        g.covidStr = covidResponse.body;
        g.covidMap = json.decode(g.covidStr);
        g.covidList = g.covidMap['states'];
        print(g.covidList[0]['state']);
        for (int i = 0; i < g.covidList.length; i++) {
          // print('for called');
          if (g.covidList[i]['state'] == g.state) {
            // print('if called');
            g.a = g.covidList[i]['active'];
            g.r = g.covidList[i]['recovered'];
          }
        }
        // print(g.active);
        g.active = k_m_b_generator(g.a);
        g.recovered = k_m_b_generator(g.r);
      });
    }

    http.Response responseGlobal;
    responseGlobal =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
    if (responseGlobal.statusCode == 200) {
      setState(() {
        g.stringResponseGlobal = responseGlobal.body;
        g.listResponseGlobal = json.decode(responseGlobal.body);

        g.g_globalcases = g.listResponseGlobal['cases'];
        g.g_globalactive = g.listResponseGlobal['active'];
        g.g_globaldeath = g.listResponseGlobal['deaths'];
        g.g_globalrecovered = g.listResponseGlobal['recovered'];

        g.gc = k_m_b_generator(g.g_globalcases);
        g.ga = k_m_b_generator(g.g_globalactive);
        g.gr = k_m_b_generator(g.g_globalrecovered);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    get_location();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 30, 34, 1),
        title: Text(
          'Covid-Stats',
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
            // Image.network('${getImage()}'),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${g.state}, ${g.city}',
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.people_alt_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                g.active == null
                    ? Text('LOADING . .')
                    : Text(
                        'Active Cases: ${g.active}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.medical_services_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                g.recovered == null
                    ? Text('LOADING . .')
                    : Text(
                        'Recovered Patients: ${g.recovered}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
              ),
              child: Center(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.4,
                      child: Image.asset(
                        'assets/images/hallf.png',
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Global data',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Rajdhani',
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          g.ga == null
                              ? Text('LOADING . .')
                              : Text(
                                  'Active Cases: ${g.ga}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Rajdhani',
                                  ),
                                ),
                          g.gr == null
                              ? Text('LOADING . .')
                              : Text(
                                  'Recovered Patients: ${g.gr}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Rajdhani',
                                  ),
                                ),
                          g.gc == null
                              ? Text('LOADING . .')
                              : Text(
                                  'Total Cases: ${g.gc}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Rajdhani',
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
