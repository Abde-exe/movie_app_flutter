import 'package:movie_app_flutter/domain/repositories/movie_repository.dart';

import '../entities/Movie.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<List<Movie>> call(String query) async {
    return repository.searchMovies(query);
  }
}
