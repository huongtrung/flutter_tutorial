import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class YourControlPage extends StatefulWidget {
  const YourControlPage({Key? key}) : super(key: key);

  @override
  State<YourControlPage> createState() => _YourControlPageState();
}

class _YourControlPageState extends State<YourControlPage> {
  double sliderValue = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          elevation: 0,
          title: Text('English Today'),
        ),
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('How much number word at once',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              Text('${sliderValue.toInt()}',
                  style: TextStyle(
                      fontSize: 150,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Slider(
                  value: sliderValue,
                  min: 5,
                  max: 100,
                  divisions: 95,
                  activeColor: Colors.amberAccent,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                    print(value);
                  }),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                alignment: Alignment.centerLeft,
                child: Text('Slide to set',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ));
  }
}
