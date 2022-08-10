import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycloud/Models/PostModel.dart';
import 'package:mycloud/Screens/filePreviewPage.dart';
import 'package:mycloud/components.dart';

class PostScreen extends StatefulWidget {
  final PostModel post;

  const PostScreen({Key? key,required this.post}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.folder_shared_sharp,color: Colors.black,))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:20,top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.post.title.toString(),style: TextStyle(fontSize: 25),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.post.imgs.length,
                  itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Card(
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.post.imgs.elementAt(index).img_url.toString(),
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>filePreviewPage(widget.post.imgs.elementAt(index).img_url.toString(),false)));
                    },
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

