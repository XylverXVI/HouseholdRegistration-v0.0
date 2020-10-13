import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'file_utils.dart';

class PersonRegistrationForm extends StatefulWidget {
  @override
  _PersonRegistrationFormState createState() => _PersonRegistrationFormState();
}

class _PersonRegistrationFormState extends State<PersonRegistrationForm> {
  String fileContents = "No Data";
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Person Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: 500,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Person Serial Number",
                      style: styleText,
                    ),
                    filler(0, 5),
                    Expanded(
                      child: TextField(
                        controller: myController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "First Name",
                      style: styleText,
                    ),
                    filler(0, 5),
                    Expanded(
                      child: TextField(),
                    ),
                  ],
                ),
                filler(10, 0),
                Row(
                  children: <Widget>[
                    Text(
                      "Middle Name",
                      style: styleText,
                    ),
                    filler(0, 5),
                    Expanded(
                      flex: 2,
                      child: TextField(),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Last Name",
                      style: styleText,
                    ),
                    filler(0, 5),
                    Expanded(
                      flex: 2,
                      child: TextField(),
                    ),
                  ],
                ),
                filler(10, 0),
                Row(
                  children: <Widget>[
                    Text(
                      "Ext. Name(ex: Jr., Sr.)",
                      style: styleText,
                    ),
                    filler(0, 5),
                    Expanded(
                      flex: 2,
                      child: TextField(),
                    ),
                  ],
                ),
                filler(10, 0),
                Row(
                  children: <Widget>[
                    Text(
                      "Birthday",
                      style: styleText,
                    ),
                    filler(0, 5),
                    Expanded(
                      flex: 2,
                      child: TextField(),
                    ),
                  ],
                ),
                filler(10, 0),
                Row(
                  children: <Widget>[
                    Text(
                      "Gender",
                      style: styleText,
                    ),
                    filler(0, 5),
                    Expanded(
                      flex: 2,
                      child: TextField(),
                    ),
                  ],
                ),
                filler(40, 0),
                Center(
                  child: RaisedButton(
                    onPressed: (){
                      FileUtils.saveToFile(myController.text);
                    },
                    textColor: Colors.black,
                    color: Colors.lightBlueAccent,
                    child: Text("Submit"),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    onPressed: (){
                      FileUtils.readFromFile().then((contents){
                        setState(() {
                          fileContents = contents;
                        });
                      });
                    },
                    textColor: Colors.black,
                    color: Colors.lightBlueAccent,
                    child: Text("Read from file"),
                  ),
                ),
                Center(child: Text(fileContents))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle styleText = GoogleFonts.openSans(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

filler(double h, double w) {
  return SizedBox(
    height: h,
    width: w,
  );
}
