import 'package:flutter/material.dart';

import 'movie.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.controller,
    required this.movies,
  }) : super(key: key);

  final List<Movie> movies;
  final PageController controller;

  @override
  Widget build(BuildContext context) => PageView.builder(
    physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _buildBackground(movie);
        },
        reverse: true,
        controller: controller,
        itemCount: movies.length,
      );

  Widget _buildBackground(Movie movie) => Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              movie.image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.15, 0.75],
              colors: [
                Colors.white.withOpacity(0.001),
                Colors.white,
              ],
            )),
          ),
        ],
      );
}
