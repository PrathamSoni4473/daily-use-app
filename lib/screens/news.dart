import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global/globals.dart' as g;
import 'dart:convert';
import '../models/quotes.dart';
import 'dart:math';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

int randomNumber() {
  Random random = new Random();
  int randomNum = random.nextInt(quotes.length);
  return randomNum;
}

class _NewsState extends State<News> {
  Future apicall() async {
    http.Response newsResponse = await http
        .get(Uri.parse('https://inshortsapi.vercel.app/news?category=all'));
    if (newsResponse.statusCode == 200) {
      setState(() {
        g.newsStr = newsResponse.body;
        g.newsMap = json.decode(g.newsStr);
        g.newsList = g.newsMap['data'];

        // print(g.newsList[24]['title']);
      });
    }
  }

  void _reset() {
    g.page = 0;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => News(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    apicall();
  }

  void nextPage() {
    setState(() {
      g.page++;
    });
  }

  void prevPage() {
    setState(() {
      g.page--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 30, 34, 1),
        title: Text(
          'Short News',
          style: Theme.of(context).textTheme.headline2,
        ),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(34, 30, 34, 1),
        ),
        child: g.newsList.length == 0
            ? Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: Color.fromRGBO(236, 167, 44, 1),
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Text(
                    loadingWeather[randomNumber()],
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  )),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Image.network(
                        g.newsList[g.page]['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(g.newsList[g.page]['title']),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        g.newsList[g.page]['content'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: g.page == 0 ? null : prevPage,
                          child: const Icon(
                            Icons.arrow_left_sharp,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        Text(' ${g.page + 1} / ${g.newsList.length}'),
                        FlatButton(
                          onPressed:
                              g.page == g.newsList.length - 1 ? null : nextPage,
                          child: const Icon(
                            Icons.arrow_right_sharp,
                            color: Colors.white,
                            size: 50,
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _reset,
                      child: const Text(
                        'Refresh',
                        style: TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 25,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(236, 167, 44, 1)),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
