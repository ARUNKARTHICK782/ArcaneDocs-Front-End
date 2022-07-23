import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mycloud/apihandler.dart';
import 'package:mycloud/components/deleteAlertDialog.dart';
import 'package:mycloud/filePreviewPage.dart';


class addfile extends StatefulWidget {
  const addfile({Key? key}) : super(key: key);

  @override
  State<addfile> createState() => _addfileState();
}

class _addfileState extends State<addfile> {
  List<File> files=[];
  bool fileBool = false;
  bool _loading = false;

  filePickerFunc() async{
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (result != null) {
      setState(() {
        fileBool = true;
      });
      return result.paths.map((path) => File(path!)).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: (fileBool)?[
          IconButton(onPressed: () async{
              var selectedFiles = await filePickerFunc();
              for(var i in selectedFiles){
                files.add(i);
              }
              setState(() {

              });
          }, icon: Icon(Icons.add))
        ]:<Widget>[],
      ),
      body: (_loading)?Center(
        child: CircularProgressIndicator(),
      ):Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: double.infinity,),

          (fileBool)
              ? Expanded(
                child: GridView.builder(
                    itemCount: files.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Image(
                            image: FileImage(files.elementAt(index))
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>filePreviewPage(files.elementAt(index))));
                        },
                        onLongPress: (){
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              content: Text("Do you want to remove this file ?"),
                              actions: [
                                TextButton(onPressed: (){
                                  setState(() {
                                    files.removeAt(index);
                                  });
                                  Navigator.pop(context);
                                }, child: Text("Yes")),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("No"))
                              ],
                            );
                          });
                        },
                      );
                    }),
              )
              : Text("Upload a file"),
          (fileBool)
              ? CupertinoButton(onPressed: () {
                  setState(() {
                    _loading = true;
                  });
                  uploadFiles(files, FirebaseAuth.instance.currentUser).then((value) {
                    setState(() {
                      _loading = false;
                    });
                  });
          }, child: Text("Upload"))
              : ElevatedButton(
                  onPressed: () async {
                    files.clear();
                    files = (await filePickerFunc());
                  },
                  child: Text("Choose file"))
        ],
      ),
    );
  }
}
