import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/movie.dart';
import '../utils/constants.dart';

class MovieCategoryController extends GetxController {
  final Dio _dio = Dio();

  var upcomingMovies = <Movie>[].obs;
  var popularMovies = <Movie>[].obs;
  var newMovies = <Movie>[].obs;
  var forYouMovies = <Movie>[].obs;
  var sciFiMovies = <Movie>[].obs;

  var isLoadingUpcoming = true.obs;
  var isLoadingPopular = true.obs;
  var isLoadingNew = true.obs;
  var isLoadingForYou = true.obs;
  var isLoadingSciFi = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUpcoming();
    fetchPopular();
    fetchNew();
    fetchForYou();
    fetchSciFi();
  }

  void fetchUpcoming() async {
    try {
      final response = await _dio.get('$TMDB_BASE_URL/movie/upcoming', queryParameters: {
        'api_key': TMDB_API_KEY,
      });
      if (response.statusCode == 200) {
        var list = response.data['results'] as List;
        upcomingMovies.value = list.map((json) => Movie.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching upcoming movies: $e");
    } finally {
      isLoadingUpcoming(false);
    }
  }

  void fetchPopular() async {
    try {
      final response = await _dio.get('$TMDB_BASE_URL/movie/popular', queryParameters: {
        'api_key': TMDB_API_KEY,
      });
      if (response.statusCode == 200) {
        var list = response.data['results'] as List;
        popularMovies.value = list.map((json) => Movie.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching popular movies: $e");
    } finally {
      isLoadingPopular(false);
    }
  }

  void fetchNew() async {
    try {
      final response = await _dio.get('$TMDB_BASE_URL/movie/now_playing', queryParameters: {
        'api_key': TMDB_API_KEY,
      });
      if (response.statusCode == 200) {
        var list = response.data['results'] as List;
        newMovies.value = list.map((json) => Movie.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching new movies: $e");
    } finally {
      isLoadingNew(false);
    }
  }

  void fetchForYou() async {
    // For "For You", using top rated movies as an example.
    try {
      final response = await _dio.get('$TMDB_BASE_URL/movie/top_rated', queryParameters: {
        'api_key': TMDB_API_KEY,
      });
      if (response.statusCode == 200) {
        var list = response.data['results'] as List;
        forYouMovies.value = list.map((json) => Movie.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching top rated movies: $e");
    } finally {
      isLoadingForYou(false);
    }
  }

  void fetchSciFi() async {
    // Using discover endpoint with Sci-Fi genre (genre id 878)
    try {
      final response = await _dio.get('$TMDB_BASE_URL/discover/movie', queryParameters: {
        'api_key': TMDB_API_KEY,
        'with_genres': '878'
      });
      if (response.statusCode == 200) {
        var list = response.data['results'] as List;
        sciFiMovies.value = list.map((json) => Movie.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching Sci-Fi movies: $e");
    } finally {
      isLoadingSciFi(false);
    }
  }
}
