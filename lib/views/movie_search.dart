import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/movie_controller.dart';
import '../models/movie.dart';
import 'movie_detail.dart';

class MovieSearch extends StatefulWidget {
  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<Movie>> _futureMovies;

  void _searchMovies(String query) {
    setState(() {
      _futureMovies = Provider.of<MovieController>(context, listen: false)
          .searchMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Pesquisar filmes',
          ),
          onSubmitted: _searchMovies,
        ),
      ),
      body: _controller.text.isEmpty
          ? const Center(
              child: Text('Digite sua pesquisa'),
            )
          : FutureBuilder<List<Movie>>(
              future: _futureMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Erro ao pesquisar filmes'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetail(movie: snapshot.data![index]),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
