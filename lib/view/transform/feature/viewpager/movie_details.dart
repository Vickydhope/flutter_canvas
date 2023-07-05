import 'package:flutter/material.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/model/movie.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({Key? key, required this.movie, this.animation})
      : super(key: key);

  final Movie movie;
  final Animation<double>? animation;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage>
    with SingleTickerProviderStateMixin {
  final duration = const Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: widget.movie.image,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              child: Image.asset(
                widget.movie.image,
                height: 300,
                width: double.infinity,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.movie.title,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.movie.title,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  _buildGenres(widget.movie),
                  const SizedBox(
                    height: 4,
                  ),
                  _buildRating(widget.movie),
                  const SizedBox(
                    height: 8,
                  ),
                  AnimatedBuilder(
                    animation: widget.animation!,
                    builder: (BuildContext context, Widget? child) =>
                        Transform.translate(
                      offset: Offset(
                        0,
                        -(((widget.animation?.value ?? 1) - 1) *
                            (MediaQuery.of(context).size.height / 2)),
                      ),
                      child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: widget.animation!,
                            curve: const Interval(0, 0.8,
                                curve: Curves.easeInSine),
                          ),
                          child: child),
                    ),
                    child: ScaleTransition(
                        scale: CurvedAnimation(
                            parent: widget.animation!,
                            reverseCurve: const Interval(0, 0.8,
                                curve: Curves.fastOutSlowIn),
                            curve:
                                const Interval(0, 0.8, curve: Curves.easeOut)),
                        child: _buildDescription(widget.movie)),
                  )
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
                    color: Colors.transparent,
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

  Text _buildDescription(Movie movie) {
    return Text(
      movie.description,
      style: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 20,
        letterSpacing: 0.5,
        wordSpacing: 1.5,
      ),
    );
  }
}
