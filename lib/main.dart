import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/movie_controller.dart';
import 'views/movie_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieController(),
      child: MaterialApp(
        title: 'Aplicativo de Filmes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MovieList(),
      ),
    );
  }
}
