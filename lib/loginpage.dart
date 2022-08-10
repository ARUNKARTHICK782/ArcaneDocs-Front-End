import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mycloud/apihandler.dart';
import 'package:mycloud/Screens/homepage.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  Future<UserCredential> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(flex:2,child: Container()),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffede9e8),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Email"
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container())
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(flex:2,child: Container()),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffede9e8),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Password"
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container())
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){}, child: Text('Login'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  signInWithGoogle().then((value) async{
                    print(value.user?.email);
                    await postUser(value.user?.uid ?? " ");
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>homepage()), (route) => false);
                  });
                }, child: Image(
                  height: 60,
                  image: AssetImage('assets/images/googleicon.png'),
                )
                )
              ],
            )

          ],
        ),
    );
  }
}
