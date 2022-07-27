import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tutorial_flutter/model/Post.dart';
import 'package:tutorial_flutter/models/english_today.dart';
import 'package:tutorial_flutter/network/NetworkRequest.dart';

class AllWordsPage extends StatefulWidget {
  const AllWordsPage({Key? key}) : super(key: key);

  @override
  _AllWordsPageState createState() => _AllWordsPageState();
}

class _AllWordsPageState extends State<AllWordsPage> {
  List<Post> postData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NetworkRequest.fetchPost().then((data) => {
          setState(() {
            print('data $data');
            postData = data;
          })
        });
  }

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: postData.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${postData[index].title}',
                        style: TextStyle(fontSize: 16, color: Colors.amber),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${postData[index].body}',
                        style: TextStyle(fontSize: 16, color: Colors.amber),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
