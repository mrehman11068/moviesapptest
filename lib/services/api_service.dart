import 'package:dio/dio.dart';
import '../utils/constants.dart';

class ApiService {
  final Dio dio = Dio();

  ApiService() {
    dio.options.baseUrl = BASE_URL;
  }

  Future<Response> getUpcomingMovies() async {
    return await dio.get('/movie/upcoming', queryParameters: {
      'api_key': API_KEY,
    });
  }

  Future<Response> getMovieDetails(int movieId) async {
    return await dio.get('/movie/$movieId', queryParameters: {
      'api_key': API_KEY,
    });
  }

  Future<Response> getMovieVideos(int movieId) async {
    return await dio.get('/movie/$movieId/videos', queryParameters: {
      'api_key': API_KEY,
    });
  }

  Future<Response> getMovieImages(int movieId) async {
    return await dio.get('/movie/$movieId/images', queryParameters: {
      'api_key': API_KEY,
    });
  }

  Future<Response> searchMovies(String query) async {
    return await dio.get('/search/movie', queryParameters: {
      'api_key': API_KEY,
      'query': query,
    });
  }

}
