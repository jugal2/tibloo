import 'package:flutter/material.dart';

class BuildBody extends StatefulWidget {
  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  String textFromSecondScreen = '';
  TextEditingController txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              textFromSecondScreen,
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: <Widget>[
                Text(" Type something: "),
                new Flexible(
                  child: new TextField(
                    controller: txtController,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: Text("Send to second screen"),
              onPressed: () {
                goToSecondScreen(context);
              },
            )
          ],
        ));
  }

  void goToSecondScreen(BuildContext context) async {
    String dataFromSecondPage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(txtController.text),
        ));
    setState(() {
      textFromSecondScreen = dataFromSecondPage;
    });
  }
}

class SecondScreen extends StatefulWidget {
  final String mydata;
  SecondScreen(this.mydata);
  @override
  _SecondScreenState createState() => _SecondScreenState(mydata);
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController secondTxtController = TextEditingController();
  String mydata;
  _SecondScreenState(this.mydata);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second screen')),
      body: Container(
          child: Column(
        children: <Widget>[
          Text(
            mydata,
            style: TextStyle(fontSize: 30),
          ),
          Row(
            children: <Widget>[
              Text(" Type something: "),
              new Flexible(
                child: new TextField(
                  controller: secondTxtController,
                ),
              ),
            ],
          ),
          ElevatedButton(
            child: Text("Send to first screen"),
            onPressed: () {
              Navigator.pop(context, secondTxtController.text);
            },
          ),
        ],
      )),
    );
  }
}
