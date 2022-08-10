
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AlertDialog getDeleteAlertDialog(){
  return AlertDialog(
    content: Text("Do you want to remove this file ?"),
    actions: [
      TextButton(onPressed: (){}, child: Text("Yes")),
      TextButton(onPressed: (){}, child: Text("No"))
    ],
  );
}

getAppBar(BuildContext context){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(CupertinoIcons.back,color: Colors.black,),
      onPressed: (){
        Navigator.pop(context);
      },
    ),
  );
}