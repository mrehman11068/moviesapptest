import 'package:get/get.dart';
import '../views/home.dart';
import '../views/movie_detail_screen.dart';
import '../views/trailer_screen.dart';
import '../views/movie_search_screen.dart';
import '../views/seat_mapping_screen.dart';

class AppPages {
  static const INITIAL = '/';

  static final routes = [
    GetPage(name: '/', page: () => HometScreen()),
    GetPage(name: '/movie_detail', page: () => MovieDetailScreen()),
    GetPage(name: '/trailer', page: () => TrailerScreen()),
    GetPage(name: '/movie_search', page: () => MovieSearchScreen()),
    GetPage(name: '/seat_mapping', page: () => SeatMappingScreen()),
  ];
}
