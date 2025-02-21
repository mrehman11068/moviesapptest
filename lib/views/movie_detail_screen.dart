import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/movie.dart';
import '../controllers/movie_detail_controller.dart';
import '../utils/common_widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieDetailController detailController = Get.put(MovieDetailController());

  @override
  Widget build(BuildContext context) {
    final Movie movie = Get.arguments as Movie;
    detailController.fetchMovieDetails(movie.id);
    detailController.fetchMovieImages(movie.id);
    detailController.fetchMovieTrailers(movie.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            icon: Icon(Icons.confirmation_num),
            onPressed: () {
              Get.toNamed('/seat_mapping', arguments: movie);
            },
          ),
        ],
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
                Obx(() {
                  if (detailController.isLoadingTrailers.value) {
                    return LoadingWidget(message: 'Loading Trailers...');
                  } else if (detailController.movieTrailers.isEmpty) {
                    return Container();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trailers',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: detailController.movieTrailers.length,
                            itemBuilder: (context, index) {
                              var trailer = detailController.movieTrailers[index];
                              String trailerKey = trailer['key'];
                              String thumbnailUrl = 'https://img.youtube.com/vi/$trailerKey/0.jpg';
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed('/trailer', arguments: trailerKey);
                                },
                                child: Container(
                                  width: 200,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          thumbnailUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        trailer['name'] ?? 'Trailer',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                }),
                SizedBox(height: 16),

                Text(
                  'Screenshots',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Obx(() {
                  if (detailController.isLoadingImages.value) {
                    return LoadingWidget(message: 'Loading Images...');
                  } else if (detailController.movieImages.isEmpty) {
                    return Text('No images available');
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: detailController.movieImages.length,
                      itemBuilder: (context, index) {
                        String imagePath = detailController.movieImages[index];
                        return GestureDetector(
                          onTap: () {
                          },
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500$imagePath',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          );
        }
      }),
    );
  }
}
