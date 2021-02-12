import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'models.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;


class HHRegistrationForm extends StatefulWidget {
  @override
  _HHRegistrationFormState createState() => new _HHRegistrationFormState();
}

class _HHRegistrationFormState extends State<HHRegistrationForm> {

  TextEditingController hSerialNumberController = new TextEditingController();
  TextEditingController hRegionController = new TextEditingController();
  TextEditingController hProvinceController = new TextEditingController();
  TextEditingController hCityController = new TextEditingController();
  TextEditingController hBarangayController = new TextEditingController();

  File jsonFile;
  Directory dir;
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  String fileName = "";

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
    hSerialNumberController.dispose();
    hRegionController.dispose();
    hProvinceController.dispose();
    hCityController.dispose();
    hBarangayController.dispose();
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
    return File('$path/HH_${hSerialNumberController.text.toString()}.json');
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
    fileName = "HH_${hSerialNumberController.text.toString()}.json";
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


  String fileContents = "No Data";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Household Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Household Serial Number",
                    style: styleText,
                  ),
                  filler(0, 5),
                  Expanded(
                    child: TextField(
                      controller: hSerialNumberController,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Region",
                    style: styleText,
                  ),
                  filler(0, 5),
                  Expanded(
                    child: TextField(
                      controller: hRegionController,
                    ),
                  ),
                ],
              ),
              filler(10, 0),
              Row(
                children: <Widget>[
                  Text(
                    "Province",
                    style: styleText,
                  ),
                  filler(0, 5),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: hProvinceController,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "City/Municipality",
                    style: styleText,
                  ),
                  filler(0, 5),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: hCityController,
                    ),
                  ),
                ],
              ),
              filler(10, 0),
              Row(
                children: <Widget>[
                  Text(
                    "Barangay",
                    style: styleText,
                  ),
                  filler(0, 5),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: hBarangayController,
                    ),
                  ),
                ],
              ),
              filler(30, 0),
              Center(
                child: RaisedButton(
                  onPressed: () =>
                  {
                    writeToFile("Household Serial Number", hSerialNumberController.text),
                    writeToFile("Region", hRegionController.text),
                    writeToFile("Province", hProvinceController.text),
                    writeToFile("City/Municipality", hCityController.text),
                    writeToFile("Barangay", hBarangayController.text),
                    Navigator.pop(context),
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
    );
  }
}

Future<String> _loadAHouseholdAsset() async {
  return await rootBundle.loadString('models.dart');
}

Future loadHousehold() async {
  String jsonString = await _loadAHouseholdAsset();
  final jsonResponse = json.decode(jsonString);
  Household household = new Household.fromJSON(jsonResponse);
  return household;
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
