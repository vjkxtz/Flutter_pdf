import 'package:manuals/pdf_opener.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';


class Getasset {
  Getasset(this.asset);
  final String asset;
  File pdf;

   Future getFileFromAsset() async {

    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$asset");

       pdf = await file.writeAsBytes(bytes);
       return pdf;

    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

}
