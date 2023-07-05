import 'package:flutter/material.dart';
import 'package:flutter_canvas/res/num_duration_extensions.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/components/moivie_card.widget.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/movies_page.dart';

import 'movie_details.dart';

class MoviesGridPage extends StatelessWidget {
  const MoviesGridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        itemCount: getMovies().length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 400),
        itemBuilder: (context, index) {
          final movie = getMovies()[index];
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: 750.ms,
                    reverseTransitionDuration: 750.ms,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                          opacity: animation,
                          child: MovieDetailsPage(
                            movie: movie,
                            animation: animation,
                          ));
                    },
                  ),
                );
                /* context.pushNamed(
                            AppRoutes.movieDetails.name,
                            extra: movie,
                          );*/
              },
              child: MovieCard(movie: movie));
        },
      ),
    );
  }
}
