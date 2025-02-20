import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/movie.dart';
import '../utils/constants.dart';
import '../utils/common_widgets.dart';

class MovieSearchScreen extends StatefulWidget {
  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final Dio _dio = Dio();
  List<Movie> searchResults = [];
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  void searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _dio.get(
        '$TMDB_BASE_URL/search/movie',
        queryParameters: {
          'api_key': TMDB_API_KEY,
          'query': query,
        },
      );
      if (response.statusCode == 200) {
        var results = response.data['results'] as List;
        setState(() {
          searchResults =
              results.map((movie) => Movie.fromJson(movie)).toList();
        });
      }
    } catch (e) {
      print("Error searching movies: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search Movies...',
            border: InputBorder.none,
          ),
          onChanged: searchMovies,
        ),
      ),
      body: isLoading
          ? LoadingWidget(message: 'Searching...')
          : ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          Movie movie = searchResults[index];
          return ListTile(
            leading: movie.posterPath.isNotEmpty
                ? Image.network(
              'https://image.tmdb.org/t/p/w92${movie.posterPath}',
              fit: BoxFit.cover,
            )
                : null,
            title: Text(movie.title),
            subtitle: Text(movie.releaseDate),
            onTap: () {
              Get.toNamed('/movie_detail', arguments: movie);
            },
          );
        },
      ),
    );
  }
}
