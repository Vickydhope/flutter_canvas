import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/model/movie.dart';

class MovieCard extends StatelessWidget {
  MovieCard({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  final border = BorderRadius.circular(16);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Expanded(child: _buildImage(movie)),
            const SizedBox(
              height: 4,
            ),
            Hero(
              tag: movie.title,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  movie.title,
                  style: TextStyle(fontSize: 22, color: Colors.grey.shade800),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildGenres(movie),
            const SizedBox(height: 8),
            _buildRating(movie),
            const Text("...", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  _buildImage(Movie movie) {
    return Hero(
      tag: movie.image,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ClipRRect(
          borderRadius: border,
          child: Image.asset(
            width: double.infinity,
            alignment: Alignment.topCenter,
            movie.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildGenres(Movie movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: movie.genres
          .map((genre) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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

  Widget _buildRating(Movie movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
}
