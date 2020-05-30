import 'package:doctorji/firebase_ml_vision_eg/camera_preview_scanner.dart';
import 'package:doctorji/firebase_ml_vision_eg/material_barcode_scanner.dart';
import 'package:doctorji/firebase_ml_vision_eg/picture_scanner.dart';
import 'package:flutter/material.dart';

class ExampleList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleListState();
}

class _ExampleListState extends State<ExampleList> {
  static final List<Widget> _exampleWidgetNames = <Widget>[
    PictureScanner(),
    CameraPreviewScanner(),
    MaterialBarcodeScanner()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example List'),
      ),
      body: ListView.builder(
        itemCount: _exampleWidgetNames.length,
        itemBuilder: (BuildContext context, int index) {
          

          return Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              title: Text("widgetName $index"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>_exampleWidgetNames[index]))
            ),
          );
        },
      ),
    );
  }
}
