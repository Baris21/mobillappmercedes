import 'package:flutter/material.dart';
import 'package:mobilappmercedes/calendar.dart';
import 'package:mobilappmercedes/editProfile.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  void editprofile() {
    /*openDialog();
    debugPrint("tusa basildii");*/
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => editProfile()),
    );
  }

  calendar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Calendar()),
    );
  }

  Future<void> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext contex) {
          return SimpleDialog(
            title: Text("Creat a Event"),
            children: [
              SimpleDialogOption(
                child: Text("deneme1"),
                onPressed: () {
                  debugPrint("deneme 1 basildi");
                },
              ),
              SimpleDialogOption(
                  child: Text("deneme 2"),
                  onPressed: () {
                    debugPrint("deneme2 basildii");
                  }),
            ],
          );
        })) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Go homapage"),
              onPressed: () {},
            ),
            TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.blueGrey,
                  textStyle:
                      const TextStyle(fontSize: 20, color: Colors.black)),
              onPressed: editprofile,
              child: const Text("Profile Edit"),
            ),
            TextButton(onPressed: calendar, child: const Text("Calendar"))
          ],
        ),
      ),
    );
  }
}
