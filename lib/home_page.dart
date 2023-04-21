import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network_app/movie_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MovieItem> movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("Fancy Movies"),
        ),
        body: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, pos) {
              return Text(
                "Movie Place",
                style: TextStyle(color: Colors.white),
              );
            }));
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    final dio = Dio();
    String url = "http://www.omdbapi.com/?apikey=1bd9bfbf&s=Batman&page=2";
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      // List<String, int> sample = ["33", 5];
      var encoded = jsonEncode(response.data);
      Map<String, dynamic> result = jsonDecode(
        encoded,
      );

      var searchResult = result["Search"];
      for (var movie in searchResult) {
        MovieItem movieItem = MovieItem(
            imdbIDm: movie["imdbID"],
            poster: movie["Poster"],
            title: movie["Title"],
            type: movie["Type"],
            year: movie["Year"]);
        movies.add(movieItem);
      }
      setState(() {});
    }
  }
}
