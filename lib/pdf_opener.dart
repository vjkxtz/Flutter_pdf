import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewPage extends StatefulWidget {
  final String path;
  final String name;

  const PdfViewPage({Key key, this.path, this.name}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  Future getpagenumber() async {
    int _pages = 1;
     _pages = await _pdfViewController.getCurrentPage();
    _currentPage = _pages + 1;
    return _pages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '$_currentPage/$_totalPages',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.last_page),
            onPressed: () {
              setState(() {
                _currentPage = _totalPages;
                _pdfViewController.setPage(_currentPage);
              });
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {
                getpagenumber();
              });
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  label: Text("Go to 1"),
                  onPressed: () {
                    setState(() {
                      _currentPage = 0;
                      _pdfViewController.setPage(_currentPage);
                    });
                  },
                )
              : Offstage(),
          _currentPage + 1 < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("Go to ${_currentPage + 1}"),
                  onPressed: () {
                    setState(() {
                      _currentPage += 1;
                      _pdfViewController.setPage(_currentPage);
                    });
                  },
                )
              : Offstage(),
          // Slider(
          //   value: _currentPage + .0,
          //   onChanged: (double value) {
          //     setState(() {
          //       _currentPage = value.toInt();
          //     });
          //   },
          //   max: _totalPages + .0,
          //   min: 0,
          // ),
        ],
      ),
    );
  }
}
