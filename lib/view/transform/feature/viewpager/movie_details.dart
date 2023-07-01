import 'package:flutter/material.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/components/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: movie.image,
            child: Image.asset(
              movie.image,
              height: 300,
              width: double.infinity,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: movie.title,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        movie.title,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  _buildGenres(movie),
                  const SizedBox(
                    height: 4,
                  ),
                  _buildRating(movie),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRating(Movie movie) {
    return Row(
      children: [
        Hero(
            tag: movie.title + movie.rating.toString(),
            child: Material(
                color: Colors.transparent,
                child: Text(movie.rating.toStringAsFixed(1)))),
        const SizedBox(
          width: 5,
        ),
        ...List.generate(
            movie.stars,
            (index) => Hero(
                  tag: movie.title + index.toString() + movie.rating.toString(),
                  child: const Material(
                    child: Icon(
                      Icons.star_rate,
                      size: 18,
                      color: Colors.orange,
                    ),
                  ),
                ))
      ],
    );
  }

  Widget _buildGenres(Movie movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: movie.genres
          .map((genre) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Hero(
                  tag: movie.image + genre,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade600),
                      ),
                      child: Text(genre),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
