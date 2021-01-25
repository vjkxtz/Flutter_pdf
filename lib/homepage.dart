import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manuals/assetsname.dart';
import 'package:manuals/pdf_opener.dart';
import 'package:manuals/side_menu.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

enum activetype{
  active,
  inactive
}

class mainpage extends StatefulWidget {
  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  String assetpdfpath = "";

  Future<File> getFileFromAsset(String asset, String filename) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      print(dir.path);
      File file = File("${dir.path}/$filename");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  @override
  void initState() {}
  List<Assetsname> _assetsname = assetsname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidemenu(),
      appBar: AppBar(
        title: Text('Manuals'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: new EdgeInsets.symmetric(vertical: 8.0),
              children: _assetsname.map(_builditems).toList(),
            ),
          ),


        ],
      ),
    );
  }
  Widget _builditems(Assetsname e) {
    double c_width = MediaQuery.of(context).size.width*0.6;
    return SafeArea(
      minimum: EdgeInsets.all(10),
      key: Key(e.linename),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.deepOrange,
        shadowColor: Color(0xFFB06A01),
        child: ExpansionTile(
          title: Text(
            e.linename,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          children: [
            Text(
              e.description,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            DropdownButton(
              icon: Icon(Icons.arrow_downward),
              dropdownColor: Colors.white,
              elevation: 16,
              style: TextStyle(color: Colors.redAccent),
              items: <String> [ for(int i = 0; i < e.line.length; i++) ( e.line[i].toString() )].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: c_width,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 20,
                      color: Colors.blue),
                    ),
                  ),
                );
              }).toList() ,
              onChanged: (String newValve) {
                getFileFromAsset("assets/$newValve.pdf", "$newValve.pdf").then((f) {
                  setState(() {
                    assetpdfpath = f.path;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfViewPage(
                              path: assetpdfpath,
                              name: newValve,
                            )));
                  });
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
