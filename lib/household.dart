import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class HHRegistrationForm extends StatefulWidget {
  @override
  _HHRegistrationFormState createState() => _HHRegistrationFormState();
}

class _HHRegistrationFormState extends State<HHRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Household Registration"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Household Serial Number",
                    style: styleText,
                  ),
                  filler(0, 10),
                  Expanded(
                    child: TextField(),
                  ),
                ],
              ),
              filler(10,0),
              Row(
                children: <Widget>[
                  Text(
                    "Region",
                    style: styleText,
                  ),filler(0, 10),
                  Expanded(
                    child: TextField(),
                  ),
                  Text(
                    "Province",
                    style: styleText,
                  ),
                  Expanded(
                    child: TextField(),
                  ),
                ],
              ),
              filler(10,0),
              Row(
                children: <Widget>[
                  Text(
                    "City/Municipality",
                    style: styleText,
                  ),
                  Expanded(
                    child: TextField(),
                  ),
                  Text(
                    "Barangay",
                    style: styleText,
                  ),
                  Expanded(
                    child: TextField(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle styleText = GoogleFonts.openSans(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 15,
);

filler(double h, double w) {
  return SizedBox(
    height: h,
    width: w,
  );
}
