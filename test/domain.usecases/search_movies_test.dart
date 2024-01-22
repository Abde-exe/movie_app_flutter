import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_flutter/domain/entities/Movie.dart';
import 'package:movie_app_flutter/domain/usecases/search_movies.dart';

import 'movie_repository_test.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late SearchMovies usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  final tQuery = 'Inception';

  final tMovies = [
    Movie(
        id: 1, title: "title1", overview: "Desc 1", posterPath: "/posterPath"),
    Movie(id: 2, title: "title2", overview: "Desc 2", posterPath: "/posterPath")
  ];

  test("should query movies from repository", () async {
    //arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => tMovies);
    //act
    final result = await usecase(tQuery);
    //assert
    expect(result, tMovies);
    verify(mockMovieRepository.searchMovies(tQuery));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
