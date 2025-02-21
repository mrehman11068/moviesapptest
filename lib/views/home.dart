import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controllers/movie_controller.dart';
import '../models/movie.dart';
import '../utils/common_widgets.dart';

class HometScreen extends StatelessWidget {

  final MovieController categoryController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Movies', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Get.toNamed('/movie_search');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBanner(),
            buildCategorySection('Upcoming', categoryController.isLoadingUpcoming, categoryController.upcomingMovies),
            buildCategorySection('Popular', categoryController.isLoadingPopular, categoryController.popularMovies),
            buildCategorySection('New', categoryController.isLoadingNew, categoryController.newMovies),
            buildCategorySection('For You', categoryController.isLoadingForYou, categoryController.forYouMovies),
            buildCategorySection('Sci-Fi', categoryController.isLoadingSciFi, categoryController.sciFiMovies),
          ],
        ),
      ),
    );
  }

  Widget buildBanner() {
    return Obx(() {
      if (categoryController.isLoadingUpcoming.value) {
        return LoadingWidget(message: 'Loading Banner...');
      } else if (categoryController.upcomingMovies.isEmpty) {
        return Container(
          height: 200,
          color: Colors.grey,
          child: Center(child: Text('No Banner')),
        );
      } else {
        return CarouselSlider.builder(
          itemCount: categoryController.upcomingMovies.length,
          itemBuilder: (context, index, realIndex) {
            Movie movie = categoryController.upcomingMovies[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed('/movie_detail', arguments: movie);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.backdropPath.isNotEmpty
                        ? 'https://image.tmdb.org/t/p/w780${movie.backdropPath}'
                        : 'https://via.placeholder.com/780x200?text=No+Image',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black26,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      movie.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            viewportFraction: 1.0,
            autoPlayInterval: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  Widget buildCategorySection(String title, RxBool isLoading, RxList<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Obx(() {
          if (isLoading.value) {
            return LoadingWidget(message: 'Loading $title...');
          } else if (movies.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('No movies available', style: TextStyle(color: Colors.white)),
            );
          } else {
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  Movie movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed('/movie_detail', arguments: movie);
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Expanded(
                            child: movie.posterPath.isNotEmpty
                                ? Image.network(
                              'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                              fit: BoxFit.cover,
                            )
                                : Container(color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            movie.title,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }),
      ],
    );
  }

}