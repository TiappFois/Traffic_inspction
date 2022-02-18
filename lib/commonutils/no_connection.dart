import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            color: Colors.orange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    image: DecorationImage(
                      image: AssetImage("assets/nointernet.webp"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: null,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                ),
                Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
//                if(ChalakdalUtilities.user==null)
//                  {
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//                  }
//                else
//                  {
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome(ChalakdalUtilities.user.roleid.toString(),ChalakdalUtilities.user.loginid)));
//
//                  }
                      },
                      //      color: Colors.teal,
                      child: const Text(
                        'Please Try Again',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            )));
  }
}
