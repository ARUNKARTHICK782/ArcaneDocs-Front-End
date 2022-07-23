import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List<String>> uploadFiles(List<File> _images,User? user) async {
  var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image,user!)));
  print(imageUrls);
  String? userUid = FirebaseAuth.instance.currentUser?.uid.toString();
  DatabaseReference ref = await FirebaseDatabase.instance.ref("Users").child(userUid.toString()).child("imgurls");
  for(var i in imageUrls){
    DatabaseReference tref = await ref.push();
    tref.set(i);
  }
  return imageUrls;
}

Future<String> uploadFile(File _image,User user) async {
  var uniqueImageID = DateTime.now().millisecondsSinceEpoch;
  String fileName = _image.path.split('/').last;
  Reference ref = await FirebaseStorage.instance
      .ref()
      .child(user.uid)
      .child('posts/${uniqueImageID.toString()}')
  ;
  TaskSnapshot uploadTask = await ref.putFile(_image);
  // await uploadTask.whenComplete(() => null);
  return await ref.getDownloadURL();
}