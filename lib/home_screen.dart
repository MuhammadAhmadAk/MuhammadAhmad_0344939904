import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myprgt/PostModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> postList = [];
  Future<List<PostModel>> fetchdata() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map i in data) {
        PostModel post = PostModel(
          id: i["id"],
          title: i["title"],
          body: i["body"],
        );
        postList.add(post);
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: fetchdata(),
                builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // id from api
                          Text(
                            "( " + snapshot.data![index].id.toString() + " )",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Aboreto",
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: h * 0.03,
                          ),

                          //title from Api
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  border: Border.all(
                                      color: Colors.black87, width: 1)),
                              child: Center(
                                child: Text(
                                  snapshot.data![index].title.toString(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Aboreto",
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                          ),

                          //body data from Api
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.2),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Text(
                                  snapshot.data![index].body.toString(),
                                  style: const TextStyle(
                                      fontFamily: "Domine",
                                      color: Colors.black,
                                      wordSpacing: 5,

                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.03,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
