import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComingSoon1 extends StatelessWidget {
  const ComingSoon1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          image: const DecorationImage(
            image: AssetImage("assets/comingsoon.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.teal,
          title: Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 1.0)),
              Container(
                  /*   padding: const EdgeInsets.all(20.0),*/
                  alignment: Alignment.center,
                  child: const Text('      Coming Soon       ')),
              const Padding(padding: EdgeInsets.only(right: 15.0)),
              IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.home,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/user_home', (Route<dynamic> route) => false);
                },
              ),
            ],
          )),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          image: const DecorationImage(
            image: AssetImage("assets/comingsoon.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}
