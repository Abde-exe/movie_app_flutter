import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_flutter/domain/entities/Movie.dart';
import 'package:movie_app_flutter/domain/usecases/get_popular_movies.dart';

import 'movie_repository_test.mocks.dart';



void main() {
  late GetPopularMovies usescase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usescase = GetPopularMovies(mockMovieRepository);
  });
  final tMovies = [
    Movie(
        id: 1, title: "title1", overview: "Desc 1", posterPath: "/posterPath"),
    Movie(id: 2, title: "title2", overview: "Desc 2", posterPath: "/posterPath")
  ];
  test("should get popular movies from repository", () async {
    //arrange
    when(mockMovieRepository.getPopularMovies())
        .thenAnswer((_) async => tMovies);
    //act
    final result = await usescase();
    //assert
    expect(result, tMovies);
    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
