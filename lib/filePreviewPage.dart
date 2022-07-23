import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class filePreviewPage extends StatefulWidget {
  final File _imagePath;
  const filePreviewPage(this._imagePath,{Key? key}) : super(key: key);

  @override
  State<filePreviewPage> createState() => _filePreviewPageState();
}

class _filePreviewPageState extends State<filePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(height: MediaQuery.of(context).size.height,width:MediaQuery.of(context).size.width , child: InteractiveViewer(child: Image(image: FileImage(widget._imagePath),))),
    );
  }
}
