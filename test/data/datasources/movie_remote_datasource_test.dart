import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_app_flutter/core.errors/server_exception.dart';
import 'package:movie_app_flutter/data/datasources/movie_remote_datasource.dart';
import 'package:movie_app_flutter/data/datasources/movie_remote_datasource_impl.dart';

import 'movie_remote_datasource_test.mocks.dart';

void main() {
  late MovieRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  const API_KEY = "94eae1e490b26d3baede18c61092909c";
  const query = 'Sample';
  const tUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=94eae1e490b26d3baede18c61092909c";
  const pUrl = "https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY";
  const sUrl =
      "https://api.themoviedb.org/3/search/movie?query=$query&api_key=$API_KEY";
  const String sampleApiResponse = '''
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "id": 1,
      "title": "Sample Movie",
      "original_language": "en",
      "original_title": "Sample Movie",
      "overview": "Overview here",
      "poster_path": "/path2.jpg",
      "media_type": "movie",
      "genre_ids": [1, 2, 3],
      "popularity": 100.0,
      "release_date": "2020-01-01",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 100
    }
  ],
  "total_pages": 1,
  "total_results": 1
}
''';

  test('should perform a GET request on a url to get trending movies',
      () async {
    //arrange
    when(mockHttpClient.get(Uri.parse(tUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));
    //act
    await dataSource.getTrendingMovies();
    //assert
    verify(mockHttpClient.get(Uri.parse(tUrl)));
  });
  test('should throw a ServerException when the response is 404', () async {
    //arrange
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Our api response', 404));
    //act
    final call = dataSource.getTrendingMovies;
    //assert
    expect(() => call(), throwsA(isA<ServerException>()));
  });

  test('should perform a GET request on a url to get popular movies', () async {
    //arrange
    when(mockHttpClient.get(Uri.parse(pUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));
    //act
    await dataSource.getPopularMovies();
    //assert
    verify(mockHttpClient.get(Uri.parse(pUrl)));
  });

  test('should perform GET request on url to search with query', () async {
    //arrange
    when(mockHttpClient.get(Uri.parse(sUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));
    //act
    await dataSource.searchMovies(query);
    //assert
    verify(mockHttpClient.get(Uri.parse((sUrl))));
  });
}
