import 'package:flutter/material.dart';
import 'package:tutorial_flutter/pages/HomePage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Wellcome',
                        style: TextStyle(fontSize: 42, color: Colors.white))),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('English', style: TextStyle(fontSize: 42))),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 70),
                child: RawMaterialButton(
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false);
                    },
                    shape: CircleBorder(),
                    fillColor: Colors.lightBlue,
                    child: Icon(
                      Icons.subdirectory_arrow_right_rounded,
                      size: 50,
                    )),
              ))
            ],
          )),
        ));
  }
}
