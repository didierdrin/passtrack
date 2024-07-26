import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:passtrack/colors.dart';
import 'package:provider/provider.dart';
import 'package:passtrack/components/post_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                child: Text(
                  "Timeline",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
            ),
            
             Consumer<PostProvider>(
              builder: (context, postProvider, child) {
                if (postProvider.posts.isEmpty) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: postProvider.posts.length,
                  itemBuilder: (context, index) {
                    return _feedCard(postProvider.posts[index]);
                  },
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}

Widget _feedCard(Post post) {
  return Card(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      height: 370,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(
              Icons.landscape,
              color: mcgpalette0[50],
            ),
            title: Text(post.title),
            subtitle: Text(post.subtitle),
          ),
          Expanded(
            child: FadeInImage(
              placeholder: const AssetImage("assets/images/imgSample.png"),
              image: NetworkImage(post.imgUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(post.description, maxLines: 3, overflow: TextOverflow.ellipsis,),
          ),
        ],
      ),
    ),
  );
}