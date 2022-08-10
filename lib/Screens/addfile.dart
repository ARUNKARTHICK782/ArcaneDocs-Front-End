import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mycloud/apihandler.dart';
import 'package:mycloud/components.dart';
import 'package:mycloud/Screens/filePreviewPage.dart';

import '../Models/UserModel.dart';


class addfile extends StatefulWidget {
  const addfile({Key? key}) : super(key: key);

  @override
  State<addfile> createState() => _addfileState();
}

class _addfileState extends State<addfile> {
  List<File> files=[];
  bool fileBool = false;
  bool _loading = false;
  TextEditingController titleCtrl = new TextEditingController();
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: files.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction){
                            setState(() {
                              files.removeAt(index);
                            });
                          },
                          child: GestureDetector(
                            child: Card(
                              elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                      image: FileImage(files.elementAt(index))
                                  ),
                                ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>filePreviewPage(files.elementAt(index).path,true)));
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
                          ),
                        );
                      }),
                ),
              )
              : Text("Upload a file"),
          (fileBool)
              ? CupertinoButton(onPressed: () async {

                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Enter a title"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 60,
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: "Title",
                                    border: OutlineInputBorder()
                                  ),
                                  controller: titleCtrl,
                                ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(onPressed: () async {
                              Navigator.pop(context);
                              setState(() {
                                _loading = true;
                              });
                              UserModel user = await getCurrentUser();
                              uploadFiles(files, FirebaseAuth.instance.currentUser,user.id.toString(),titleCtrl.text).then((value) {
                                setState(() {
                                  _loading = false;
                                });
                              });
                            }, child: Text("Upload")),
                          )
                        ],
                      ),
                    );
                  });


          }, child: Text("Upload"))
              : CupertinoButton(
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
