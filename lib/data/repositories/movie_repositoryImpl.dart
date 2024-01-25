import 'package:movie_app_flutter/data/models/movie_model.dart';
import 'package:movie_app_flutter/domain/entities/Movie.dart';
import 'package:movie_app_flutter/domain/repositories/movie_repository.dart';

import '../datasources/movie_remote_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getPopularMovies() async {
    final List<MovieModel> movieModels =
        await remoteDataSource.getPopularMovies();
    return movieModels.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getTrendingMovies() async {
    final List<MovieModel> movieModels =
        await remoteDataSource.getTrendingMovies();
    return movieModels.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final List<MovieModel> movieModels =
        await remoteDataSource.searchMovies(query);
    return movieModels.map((e) => e.toEntity()).toList();
  }
}
