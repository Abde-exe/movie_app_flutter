import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_flutter/domain/entities/Movie.dart';
import 'package:movie_app_flutter/domain/usecases/get_trending_movies.dart';

import 'movie_repository_test.mocks.dart';


void main() {
  //variables
  late MockMovieRepository mockMovieRepository;
  late GetTrendingMovies usecase;
  //setup
  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTrendingMovies(mockMovieRepository);
  });

  final tMovies = [
    Movie(
        id: 1, title: "title1", overview: "Desc 1", posterPath: "/posterPath"),
    Movie(id: 2, title: "title2", overview: "Desc 2", posterPath: "/posterPath")
  ];
  //test
  test("should get trending movies from repository", () async {
    //arrange
    when(mockMovieRepository.getTrendingMovies())
        .thenAnswer((_) async => tMovies);
    //act
    final result = await usecase();
    //assert
    expect(result, tMovies);
    verify(mockMovieRepository.getTrendingMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
