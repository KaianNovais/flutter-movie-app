import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

//criamos um controlador que herda de ChangeNotifier, que é uma implementação de Observer
//cujo objetivo é notificar os widgets que estão escutando o controller.

class MovieController extends ChangeNotifier {
  final String apiKey = 'aad64359084ed7430bbf41835a58fe05';
  final String baseUrl = 'https://api.themoviedb.org/3';

  //método para buscar todos os fimes
  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body)['results'];
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  //método que retorna os dados de um filme específico
  Future<Movie> fetchMovie(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/movie/$id?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }

  //método para pesquisar um filme específico
  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body)['results'];
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
