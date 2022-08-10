import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mycloud/firebaseOptions.dart';
import 'package:mycloud/Screens/homepage.dart';
import 'package:mycloud/loginpage.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: getFirebaseOptions()
  );
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginpage()
    );
  }
}

class temp extends StatefulWidget {
  const temp({Key? key}) : super(key: key);

  @override
  State<temp> createState() => _tempState();
}

class _tempState extends State<temp> {
  tempfunc() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "email@gmail.com", password: "password").then((value) {
      print('Success');
    });
  }

  @override
  void initState() {
    tempfunc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(onPressed: () async{

        }, child: Text("Google Sign in")),
      ),
    );
  }
}

