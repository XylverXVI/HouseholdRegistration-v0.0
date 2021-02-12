import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hhregistration/person.dart';
import 'household.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: myHome(),
    );
  }
}

class myHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HHRegistrationForm()),
                  );
                },
                child: Text("Household Register"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PersonRegistrationForm()),
                  );
                },
                child: Text("Person Register"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueAccent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 225,
              child: DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/psa_icon.png",
                      scale: 3.9,
                    ),
                    Text(
                      "PSA",
                      style: styleText,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Philippine Statistics Authority",
                      //style: TextStyle(color: Colors.black.withOpacity(20)),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return HHRegistrationForm();
                      },
                    ),);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.list),
                    title: Text("Household Registration"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return PersonRegistrationForm();
                      },
                    ),);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.calendar_today),
                    title: Text("Person Registration"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ),
              ],
            ), //height
          ],
        ),
      ),
    );
  }

  TextStyle styleText = GoogleFonts.openSans(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}