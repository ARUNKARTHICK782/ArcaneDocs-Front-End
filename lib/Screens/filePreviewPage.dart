import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class filePreviewPage extends StatefulWidget {
  final String _imagePath;
  final bool forPosting;
  const filePreviewPage(this._imagePath,this.forPosting,{Key? key}) : super(key: key);

  @override
  State<filePreviewPage> createState() => _filePreviewPageState();
}

class _filePreviewPageState extends State<filePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: InteractiveViewer(
          child: (widget.forPosting) ? Image(
            image: FileImage(File(widget._imagePath)),
          ) : Image(image: NetworkImage(widget._imagePath))
          ,),),
    );
  }
}
