import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mycloud/addfile.dart';

import 'loginpage.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with SingleTickerProviderStateMixin{
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
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
              Center(child: Text("My Posts"),),
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
