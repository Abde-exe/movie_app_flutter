import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:movie_app_flutter/data/datasources/movie_remote_datasource.dart';
import 'package:movie_app_flutter/data/models/movie_model.dart';
import 'package:movie_app_flutter/data/repositories/movie_repositoryImpl.dart';
import 'package:movie_app_flutter/domain/entities/Movie.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])

void main(){


  late MockMovieRemoteDataSource mockMovieRemoteDataSource;
  late MovieRepositoryImpl repository;

  setUp((){
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(mockMovieRemoteDataSource);
  });

  final tMovieModelList = [
    MovieModel(
        id: 1, title: "title1", overview: "Desc 1", posterPath: "/posterPath"),
    MovieModel(id: 2, title: "title2", overview: "Desc 2", posterPath: "/posterPath")
  ];

  final tMoviesList = [
    Movie(id: 1, title: "title1", overview: "Desc 1", posterPath: "/posterPath"),
    Movie(id: 2, title: "title2", overview: "Desc 2", posterPath: "/posterPath")
  ];

  test("should get popular movies from remote datasource", () async {
    //arrange
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenAnswer((_)async => tMovieModelList);
    //act
    final result = await repository.getPopularMovies();
    //assert
    expect(result, equals(tMoviesList));
    verify(repository.getPopularMovies());
  });

  test("should get trending movies from remote datasource", () async {
    //arrange
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenAnswer((_)async => tMovieModelList);
    //act
    final result = await repository.getTrendingMovies();
    //assert
    expect(result, equals(tMoviesList));
    verify(repository.getTrendingMovies());
  });

  test("should search movies from remote datasource", () async {
    //arrange
    when(mockMovieRemoteDataSource.searchMovies("query"))
        .thenAnswer((_)async => tMovieModelList);
    //act
    final result = await repository.searchMovies("query");
    //assert
    expect(result, equals(tMoviesList));
    verify(repository.searchMovies("query"));
  });

/*  test('should return ServerFailure wehn the call to remote datasource is unsuccessful', () async {
    when (mockMovieRemoteDataSource.getTrendingMovies())
        .thenThrow(ServerException() async => tMovieModelList);

    final result = await repository.getTrendingMovies();

    expect(result, equals(Left(ServerFailure)));
  });*/
}


