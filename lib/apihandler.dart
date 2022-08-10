import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycloud/Models/ImageModel.dart';
import 'package:mycloud/Models/PostModel.dart';
import 'package:mycloud/Models/UserModel.dart';
import 'package:mycloud/apiLink.dart';
import 'package:http/http.dart' as http;


//Uploading Files
Future<List<Object>> uploadFiles(List<File?> _images,User? user,String user_id,String title) async {
  var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image,user!)));
  print(imageUrls);
  String? userUid = FirebaseAuth.instance.currentUser?.uid.toString();
  for(var i in imageUrls){
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users").child(userUid.toString()).child("imgurls").push();
    ref.set(i);
  }
  var body = {
    "post": {
      "title": title,
      "images": imageUrls,
    }
  };
  debugPrint(body.toString());
  var res = await http.post(Uri.parse("${APILINK}users/$user_id/posts"),
    headers: {
      "content-type":"application/json"
    },
    body: jsonEncode(body)
  );
  debugPrint(res.body);
  return imageUrls;
}

Future<String> uploadFile(File? _image,User user) async {
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
  var url = await ref.getDownloadURL();
  return url;
}

// Future<File?> testCompressAndGetFile(File file, String targetPath) async {
//   File? result = await FlutterImageCompress.compressAndGetFile(
//     file.path, targetPath+".jpg",
//     quality: 50,
//     format: CompressFormat.jpeg
//   );
//   return result;
// }

//Creating User
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

//Get Current User
getAllUsers() async{
  List<UserModel> usersList=[];
  var res = await http.get(Uri.parse(APILINK+"users"));
  var users = jsonDecode(res.body);
  for(var i in users){
    UserModel user = UserModel(i["id"].toString(), i["session_id"], i["profile_url"] ?? " ", i["created_at"], i["updated_at"]);
    usersList.add(user);
  }
  return usersList;
}

getCurrentUser() async{
  List<UserModel> res = await getAllUsers();
  for(var i in res){
    if(i.session_id ==FirebaseAuth.instance.currentUser?.uid){
      return i;
    }
  }
}

//Get Current User's Post

getMyPost() async{
  UserModel user = await getCurrentUser();
  var res = await http.get(Uri.parse('${APILINK}/users/${user.id}/posts'));
  var posts = jsonDecode(res.body);
  List<PostModel> postsList= [];
  for(var i in posts){
    List<ImageModel> imgurls=[];
    for(var img in i["images"]){
      ImageModel image = ImageModel(img["id"].toString(), img["image_url"], img["post_id"].toString(), img["created_at"], img["updated_at"]);
      imgurls.add(image);
    }
    PostModel post = PostModel(i["id"].toString(), i["title"], i["user_id"].toString(), i["created_at"], i["updated_at"], imgurls);
    postsList.add(post);
  }
  return postsList;
}