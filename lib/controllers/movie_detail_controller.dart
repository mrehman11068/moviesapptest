import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../utils/constants.dart';

class MovieDetailController extends GetxController {
  var isLoading = false.obs;
  var movieDetail = {}.obs;
  var trailerUrl = ''.obs;
  var movieImages = <String>[].obs;
  var isLoadingImages = true.obs;

  var isLoadingTrailers = true.obs;
  var movieTrailers = <Map<String, dynamic>>[].obs;

  final Dio _dio = Dio();

  void fetchMovieDetails(int movieId) async {
    isLoading(true);
    try {
      final response = await _dio.get(
        '$BASE_URL/movie/$movieId',
        queryParameters: {
          'api_key': API_KEY,
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
        '$BASE_URL/movie/$movieId/videos',
        queryParameters: {
          'api_key': API_KEY,
        },
      );
      if (response.statusCode == 200) {
        var videos = response.data['results'] as List;
        if (videos.isNotEmpty) {
          var trailer = videos.first;
          trailerUrl.value =
          'https://www.youtube.com/watch?v=${trailer['key']}';
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

  void fetchMovieImages(int movieId) async {
    isLoadingImages(true);
    try {
      final response = await _dio.get(
        '$BASE_URL/movie/$movieId/images',
        queryParameters: {'api_key': API_KEY},
      );
      if (response.statusCode == 200) {
        var list = response.data['backdrops'] as List;
        movieImages.value =
            list.map((img) => img['file_path'] as String).toList();
      }
    } catch (e) {
      print("Error fetching movie images: $e");
    } finally {
      isLoadingImages(false);
    }
  }

  void fetchMovieTrailers(int movieId) async {
    isLoadingTrailers(true);
    try {
      final response = await _dio.get(
        '$BASE_URL/movie/$movieId/videos',
        queryParameters: {'api_key': API_KEY},
      );
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        movieTrailers.value = results.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      print("Error fetching movie trailers: $e");
    } finally {
      isLoadingTrailers(false);
    }
  }
}
