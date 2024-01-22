import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app_flutter/data/datasources/movie_remote_datasource.dart';
import 'package:movie_app_flutter/data/models/movie_model.dart';

import '../../core.errors/server_exception.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  static const BASE_URL = "https://api.themoviedb.org/3";
  static const API_KEY = "94eae1e490b26d3baede18c61092909c";

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    //on récupère la reponse de l'api en utilisant un parser d'Uri pour l'endpoint popular movies
    final response =
        await client.get(Uri.parse("$BASE_URL/movie/popular?api_key=$API_KEY"));
    // si la reponse est valide
    if (response.statusCode == 200) {
      //on decode le body de la reponse de string vers json
      final responseBody = json.decode(response.body);
      //on transforme le tableau results en List
      final List<MovieModel> movies = (responseBody["results"] as List)
          // en mappant chaque valeur pour la transformer en moviemodel avec fromJson
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await client
        .get(Uri.parse("$BASE_URL/trending/movie/day?api_key=$API_KEY"));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody["results"] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    //get response (parse uri)
    final response = await client
        .get(Uri.parse("$BASE_URL/search/movie?query=$query&api_key=$API_KEY"));
    //test response
    if (response.statusCode == 200) {
      // get responsebody (json decode)
      final responseBody = json.decode(response.body);
      //transform to a model list
      final List<MovieModel> movies = (responseBody["results"] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }
}
