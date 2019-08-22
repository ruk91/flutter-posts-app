import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {

//  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//     final openButon = Material(
//           elevation: 5.0,
//           borderRadius: BorderRadius.circular(20.0),
//           color: Color(0xff03a9f4),
//           child: MaterialButton(
//             minWidth: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//             onPressed: () {},
//             child: Text("Open",
//                 textAlign: TextAlign.center,
//                 style: style.copyWith(
//                     color: Colors.white, fontWeight: FontWeight.bold)),
//           ),
//         );

    return MaterialApp(
      title: 'Posts App',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data.title,
                  style: TextStyle(
                    fontFamily: 'Nunito-Regular',
                    fontSize: 20.0,
                    color: Colors.red,
                      
                  ));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(Icons.thumb_up),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}