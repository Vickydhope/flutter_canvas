import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/components/background_widget.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/components/moivie_card.widget.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/components/movie.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(controller: _controller, movies: _getMovies()),
          Align(
            alignment: Alignment.bottomCenter,
            child: CarouselSlider(
              items: _getMovies()
                  .map(
                    (movie) => GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.movieDetails.name,
                            extra: movie,
                          );
                        },
                        child: MovieCard(movie: movie)),
                  )
                  .toList(),
              options: CarouselOptions(
                pageSnapping: true,
                enableInfiniteScroll: false,
                viewportFraction: 0.65,
                height: MediaQuery.of(context).size.height * 0.65,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) => _controller.animateToPage(
                    index,
                    duration: const Duration(seconds: 1),
                    curve: Curves.ease),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Movie> _getMovies() => [
        Movie(
          title: "Spiderman - No way Home",
          image: Assets.imagesSpiderman,
          genres: ["Sci-Fi", "Fantasy", "Comedy"],
          stars: 4,
          rating: 9.0,
        ),
        Movie(
          title: "Black Widow",
          image: Assets.imagesBlackWidow,
          genres: ["Sci-Fi", "Fantasy", "Comedy"],
          stars: 4,
          rating: 8.3,
        ),
        Movie(
          title: "Joker",
          image: Assets.imagesJoker,
          genres: ["Drama", "Thriller"],
          stars: 5,
          rating: 9.5,
        ),
        Movie(
          title: "The Batman",
          image: Assets.imagesBatman,
          genres: ["Drama", "Thriller", "Dark"],
          stars: 4,
          rating: 8.0,
        ),
        Movie(
          title: "1917 - Time is the enemy",
          image: Assets.imagesStarWars,
          genres: ["Science", "Thriller", "Drama"],
          stars: 3,
          rating: 7.0,
        ),
      ];
}
