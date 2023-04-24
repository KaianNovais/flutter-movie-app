//classe que representará cada filme
class Movie {
  //variáveis de instância
  final int id;
  final String title;
  final String overview;
  final String posterPath;

  //construtor da classe
  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath});

  //construtor de fábrica. Usado para converter um objeto json em uma instância de movie
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}
