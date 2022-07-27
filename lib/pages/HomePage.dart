import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_flutter/models/english_today.dart';
import 'package:tutorial_flutter/pages/AllWordsPage.dart';
import 'package:tutorial_flutter/pages/YourControlPage.dart';
import 'package:tutorial_flutter/values/ShareKey.dart';
import 'package:tutorial_flutter/widgets/AppButton.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curIndex = 0;
  PageController pageController = PageController();
  List<EnglishToday> words = [];

  List<int> fixedListRandom({int len = 1, int max1 = 120, int min = 1}) {
    if (len > max1 || len < min) return [];
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max1);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.COUNTER) ?? 5;

    List<String> newList = [];
    List<int> random = fixedListRandom(len: len, max1: nouns.length);
    random.forEach((index) {
      newList.add(nouns[index]);
    });
    setState(() {
      words = newList.map((e) => EnglishToday(noun: e)).toList();
    });
    print('newList ${words[0]}');
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEnglishToday();
  }

  void main(List<String> arguments) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url =
        Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          elevation: 0,
          title: Text('English Today'),
          leading: InkWell(
              child: Icon(Icons.access_time_sharp),
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              }),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[300],
            onPressed: () {},
            child: Icon(Icons.ac_unit_sharp)),
        drawer: Drawer(
            child: Container(
          color: Colors.amberAccent,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text('sadasd', style: TextStyle(fontSize: 20)),
              ),
              AppButton(
                label: 'Favorites',
                onPress: () {
                  print('Favorites');
                },
              ),
              AppButton(
                label: 'Your control',
                onPress: () {
                  scaffoldKey.currentState?.closeDrawer();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YourControlPage()));
                },
              )
            ],
          ),
        )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                      'Its amazing how complete is the delusion that beaty is goodness'),
                ),
                Container(
                  height: size.height * 2 / 4,
                  child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          curIndex = index;
                        });
                      },
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        String? firstLetter =
                            words[index].noun?.substring(0, 1);
                        String? leftLetter = words[index]
                            .noun
                            ?.substring(1, words[index].noun?.length);

                        return Container(
                          margin: EdgeInsets.only(right: 16),
                          decoration: const BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Icon(Icons.access_alarm_sharp, size: 40),
                                ),
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 89,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(3, 6))
                                        ],
                                      ),
                                      text: firstLetter,
                                      children: [
                                    TextSpan(
                                      text: leftLetter,
                                      style: TextStyle(
                                        fontSize: 56,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(3, 6))
                                        ],
                                      ),
                                    )
                                  ])),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '"Think of all the beaty still left ............................................................"',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                      height: 12,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return buildIndicator(index == curIndex, size);
                          })),
                ),
                Text(
                    'Its amazing how complete is the delusion that beaty is goodness'),
                buildShowMore()
              ],
            ),
          ),
        ));
  }

  Widget buildIndicator(bool isActive, Size size) {
    print('size ${size}');
    return Container(
        height: 12,
        margin: EdgeInsets.only(right: 16),
        width: isActive ? size.width * 1 / 5 : 24,
        decoration: BoxDecoration(
            color: isActive ? Colors.lightBlue[100] : Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
            ]));
  }

  Widget buildShowMore() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.centerLeft,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        overlayColor: MaterialStateProperty.all(Colors.amber),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AllWordsPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
            ],
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text('show more'),
        ),
      ),
    );
  }
}
