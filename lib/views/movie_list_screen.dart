import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';
import '../models/movie.dart';
import '../utils/common_widgets.dart';

class MovieListScreen extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Get.toNamed('/movie_search');
            },
          )
        ],
      ),
      body: Obx(() {
        if (movieController.isLoading.value) {
          return LoadingWidget(message: 'Loading Movies...');
        } else if (movieController.movies.isEmpty) {
          return Center(child: Text('No movies available'));
        } else {
          return ListView.builder(
            itemCount: movieController.movies.length,
            itemBuilder: (context, index) {
              Movie movie = movieController.movies[index];
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
          );
        }
      }),
    );
  }
}
