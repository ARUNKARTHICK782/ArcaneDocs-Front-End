import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mycloud/Models/PostModel.dart';
import 'package:mycloud/Models/UserModel.dart';
import 'package:mycloud/Screens/PostScreen.dart';
import 'package:mycloud/Screens/addfile.dart';

import '../apihandler.dart';
import '../loginpage.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  UserModel _currentUser = UserModel.empty();
  List<PostModel> myPosts = [];
  temp() async{
    await getCurrentUser().then((v){
      setState(() {
        _currentUser = v;
      });
    });
    await getMyPost().then((v){
      debugPrint(v.toString());
      setState((){
        myPosts = v;
      });

    });
  }
  @override
  void initState() {
    super.initState();
    temp();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Container(
              child: Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(CupertinoIcons.profile_circled,size: 50,),
                ),
              ),
            )),
            ElevatedButton(onPressed: () async{
              await GoogleSignIn().signOut().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>loginpage()),(route) => false));
            }, child: Text("Logout"))
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            labelColor: Colors.black,
            controller: _tabController,
            tabs: [
              Tab(
                child: Text("My Posts"),
              ),
              Tab(
                child: Text("Shared with me"),
              )
            ],
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(itemBuilder: (BuildContext context,int index){
                    return GestureDetector(
                      child: Card(
                        elevation: 3,
                        child: Container(
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(myPosts.elementAt(index).title.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen(post: myPosts.elementAt(index))));
                      },
                    );
                  }, separatorBuilder: (BuildContext context,int index){
                    return SizedBox(
                      height: 10,
                    );
                  }, itemCount: myPosts.length),
                ),
              Center(child: Text("Shared with me"),)
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>addfile()));
        },
      ),
    );
  }
}
