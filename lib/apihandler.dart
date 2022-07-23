import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> uploadFiles(List<File> _images,User? user) async {
  var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image,user!)));
  print(imageUrls);
  return imageUrls;
}

Future<String> uploadFile(File _image,User user) async {
  String fileName = _image.path.split('/').last;
  Reference ref = await FirebaseStorage.instance
      .ref()
      .child(user.uid)
      .child('posts/${fileName}')
  ;
  TaskSnapshot uploadTask = await ref.putFile(_image);
  // await uploadTask.whenComplete(() => null);
  return await ref.getDownloadURL();
}