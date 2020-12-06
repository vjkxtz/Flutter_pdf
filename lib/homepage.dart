import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manuals/assetsname.dart';
import 'package:manuals/pdf_opener.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

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
    String k = e.line;
    print(k.split(" "));
    return SafeArea(
      minimum: EdgeInsets.all(10),
      key: Key(e.linename),
      child: Card(
        color: Color(0xFFEBC600),
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
              elevation: 16,
              style: TextStyle(color: Colors.redAccent),
              items: <String>[e.line]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              onChanged: (String newValve) {
                getFileFromAsset("assets/$newValve", "$newValve").then((f) {
                  setState(() {
                    assetpdfpath = f.path;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfViewPage(
                                  path: assetpdfpath,
                                )));
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
