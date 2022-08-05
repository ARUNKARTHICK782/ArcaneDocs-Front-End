import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mycloud/apiLink.dart';
import 'package:http/http.dart' as http;

Future<List<Object>> uploadFiles(List<File?> _images,User? user) async {
  var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image,user!)));
  print(imageUrls);
  String? userUid = FirebaseAuth.instance.currentUser?.uid.toString();
  DatabaseReference ref = await FirebaseDatabase.instance.ref("Users").child(userUid.toString()).child("imgurls").push();
  for(var i in imageUrls){
    ref.set(i);
  }
  return imageUrls;
}

Future<Map> uploadFile(File? _image,User user) async {
  var uniqueImageID = DateTime.now().millisecondsSinceEpoch;
  String? fileName = _image?.path.split('/').last;
  Reference ref = await FirebaseStorage.instance
      .ref()
      .child(user.uid)
      .child('posts/${uniqueImageID.toString()}')
  ;
  File? img ;
  if(_image != null){
    img = _image;
  }
  await ref.putFile(img!);
  // await uploadTask.whenComplete(() => null);
  var m = {
    uniqueImageID : await ref.getDownloadURL()
  };
  return m;
}

// Future<File?> testCompressAndGetFile(File file, String targetPath) async {
//   File? result = await FlutterImageCompress.compressAndGetFile(
//     file.path, targetPath+".jpg",
//     quality: 50,
//     format: CompressFormat.jpeg
//   );
//   return result;
// }


postUser(String session_id) async{

    var body={
      "session_id":session_id,
    };
    print("In post"+body.toString());
    await http.post(Uri.parse(APILINK+"users"),
      headers: {
        "content-type" : "application/json",
      },
      body: json.encode(body),
    ).then((value) {
      debugPrint(value.body.toString());
    });
}