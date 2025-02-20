import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../utils/constants.dart';

class MovieDetailController extends GetxController {
  var isLoading = false.obs;
  var movieDetail = {}.obs;
  var trailerUrl = ''.obs;
  final Dio _dio = Dio();

  void fetchMovieDetails(int movieId) async {
    isLoading(true);
    try {
      final response = await _dio.get(
        '$TMDB_BASE_URL/movie/$movieId',
        queryParameters: {
          'api_key': TMDB_API_KEY,
        },
      );
      if (response.statusCode == 200) {
        movieDetail.value = response.data;
      }
    } catch (e) {
      print("Error fetching movie details: $e");
    } finally {
      isLoading(false);
    }
  }

  void watchTrailer(int movieId) async {
    try {
      final response = await _dio.get(
        '$TMDB_BASE_URL/movie/$movieId/videos',
        queryParameters: {
          'api_key': TMDB_API_KEY,
        },
      );
      if (response.statusCode == 200) {
        var videos = response.data['results'] as List;
        if (videos.isNotEmpty) {
          var trailer = videos.first;
          // Assume YouTube; adjust URL formation if needed
          trailerUrl.value =
          'https://www.youtube.com/watch?v=${trailer['key']}';
          // Navigate to the full-screen trailer player
          Get.toNamed('/trailer', arguments: trailerUrl.value);
        } else {
          Get.snackbar('Trailer', 'No trailer available');
        }
      }
    } catch (e) {
      print("Error fetching trailer: $e");
      Get.snackbar('Error', 'Failed to load trailer');
    }
  }
}
