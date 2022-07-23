
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