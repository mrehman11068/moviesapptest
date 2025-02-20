import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/movie.dart';
import '../controllers/movie_detail_controller.dart';
import '../utils/common_widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieDetailController detailController =
  Get.put(MovieDetailController());

  @override
  Widget build(BuildContext context) {
    // Retrieve the movie passed via arguments
    final Movie movie = Get.arguments as Movie;
    // Fetch detailed data for the movie
    detailController.fetchMovieDetails(movie.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Obx(() {
        if (detailController.isLoading.value) {
          return LoadingWidget(message: 'Loading Details...');
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                movie.posterPath.isNotEmpty
                    ? Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  fit: BoxFit.cover,
                )
                    : Container(),
                SizedBox(height: 16),
                Text(
                  movie.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Release Date: ${movie.releaseDate}'),
                SizedBox(height: 16),
                Text(movie.overview),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    detailController.watchTrailer(movie.id);
                  },
                  child: Text('Watch Trailer'),
                ),
                // You can also add images (using the Get Images API) and other details here.
              ],
            ),
          );
        }
      }),
    );
  }
}
