import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          elevation: 0,
          title: Text('English Today'),
          leading: InkWell(child: Icon(Icons.access_time_sharp), onTap: () {}),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[300],
            onPressed: () {},
            child: Icon(Icons.ac_unit_sharp)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                    'Its amazing how complete is the delusion that beaty is goodness'),
                Expanded(
                  child: PageView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        );
                      }),
                ),
                Container(
                    height: 120,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return buildIndicator(index == 0, Size.infinite);
                        })),
                Text(
                    'Its amazing how complete is the delusion that beaty is goodness'),
              ],
            ),
          ),
        ));
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
        height: 12,
        width: isActive ? size.width * 1 / 5 : 24,
        decoration: BoxDecoration(
            color: isActive ? Colors.lightBlue[100] : Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
            ]));
  }
}
