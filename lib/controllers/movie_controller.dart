import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/movie.dart';
import '../utils/constants.dart';

class MovieController extends GetxController {
  var isLoading = false.obs;
  var movies = <Movie>[].obs;
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingMovies();
  }

  void fetchUpcomingMovies() async {
    isLoading(true);
    try {
      final response = await _dio.get(
        TMDB_UPCOMING_URL,
        queryParameters: {
          'api_key': TMDB_API_KEY,
        },
      );
      if (response.statusCode == 200) {
        var movieList = response.data['results'] as List;
        movies.value =
            movieList.map((movie) => Movie.fromJson(movie)).toList();
      }
    } catch (e) {
      print("Error fetching movies: $e");
    } finally {
      isLoading(false);
    }
  }
}
