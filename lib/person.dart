import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class PersonRegistrationForm extends StatefulWidget {
  @override
  _PersonRegistrationFormState createState() => _PersonRegistrationFormState();
}

class _PersonRegistrationFormState extends State<PersonRegistrationForm> {

  TextEditingController pSerialNumberController = new TextEditingController();
  TextEditingController pFirstNameController = new TextEditingController();
  TextEditingController pMiddleNameController = new TextEditingController();
  TextEditingController pLastNameController = new TextEditingController();
  TextEditingController pExtController = new TextEditingController();
  TextEditingController pBirthdayController = new TextEditingController();
  TextEditingController pGenderController = new TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  void initState(){
    super.initState();
    getExternalStorageDirectory().then((Directory directory){
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if(fileExists) this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  @override
  void dispose() {
    pSerialNumberController.dispose();
    pFirstNameController.dispose();
    pMiddleNameController.dispose();
    pLastNameController.dispose();
    pExtController.dispose();
    pBirthdayController.dispose();
    pGenderController.dispose();
    super.dispose();
  }

  //Start of Delete File

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('path $path');
    return File('$path/P_${pSerialNumberController.text.toString()}.json');
  }

  Future<int> deleteFile() async {
    try {
      final file = await _localFile;
      await file.delete();
    } catch (e) {
      return 0;
    }
  }

  //End of Delete File

  File createFile(Map<String, dynamic> content, Directory dir, String fileName){
    print("Creating file");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
    return file;
  }

  void writeToFile(String key, dynamic value){
    fileName = "P_${pSerialNumberController.text.toString()}.json";
    jsonFile = new File(dir.path + "/" + fileName);
    Map<String, dynamic> content = {key: value};
    if(fileExists){
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else{
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
  }

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
                        controller: pSerialNumberController,
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
                      child: TextField(
                        controller: pFirstNameController,
                      ),
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
                      child: TextField(
                        controller: pMiddleNameController,
                      ),
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
                      child: TextField(
                        controller: pLastNameController,
                      ),
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
                      child: TextField(
                        controller: pExtController,
                      ),
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
                      child: TextField(
                        controller: pBirthdayController,
                      ),
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
                      child: TextField(
                        controller: pGenderController,
                      ),
                    ),
                  ],
                ),
                filler(40, 0),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      writeToFile("Serial Number", pSerialNumberController.text);
                      writeToFile("First Name", pFirstNameController.text);
                      writeToFile("Middle Name", pMiddleNameController.text);
                      writeToFile("Last Name", pLastNameController.text);
                      writeToFile("Ext Name", pExtController.text);
                      writeToFile("Birthday", pBirthdayController.text);
                      writeToFile("Gender", pGenderController.text);
                      Navigator.pop(context);
                    },
                    textColor: Colors.black,
                    color: Colors.lightBlueAccent,
                    child: Text("Submit"),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    onPressed: (){
                      deleteFile();
                      Navigator.pop(context);
                    },
                    textColor: Colors.black,
                    color: Colors.lightBlueAccent,
                    child: Text("Delete file with same serial number"),
                  ),
                ),
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
