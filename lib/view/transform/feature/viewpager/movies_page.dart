import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/res/num_duration_extensions.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/components/background_widget.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/components/moivie_card.widget.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/model/movie.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/movie_details.dart';

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
          BackgroundWidget(controller: _controller, movies: getMovies()),
          Align(
            alignment: Alignment.bottomCenter,
            child: CarouselSlider(
              items: getMovies()
                  .map(
                    (movie) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: 700.ms,
                            reverseTransitionDuration: 300.ms,
                            pageBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                            ) {
                              return FadeTransition(
                                opacity: CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.fastOutSlowIn),
                                child: MovieDetailsPage(
                                  movie: movie,
                                  animation: animation,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: MovieCard(movie: movie),
                    ),
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
}

List<Movie> getMovies() => [
      Movie(
          title: "Spiderman - No way Home",
          image: Assets.imagesSpiderman,
          genres: ["Sci-Fi", "Fantasy", "Comedy"],
          stars: 4,
          rating: 9.0,
          description:
              "Peter Parker's secret identity is revealed to the entire world. Desperate for help, Peter turns to Doctor Strange to make the world forget that he is Spider-Man. The spell goes horribly wrong and shatters the multiverse, bringing in monstrous villains that could destroy the world."),
      Movie(
          title: "Black Widow",
          image: Assets.imagesBlackWidow,
          genres: ["Sci-Fi", "Fantasy", "Comedy"],
          stars: 4,
          rating: 8.3,
          description:
              "In Marvel Studios' action-packed spy thriller 'Black Widow', Natasha Romanoff aka Black Widow confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises."),
      Movie(
          title: "Joker",
          image: Assets.imagesJoker,
          genres: ["Drama", "Thriller"],
          stars: 5,
          rating: 9.5,
          description:
              "Set in 1981, it follows Arthur Fleck, a failed clown and aspiring stand-up comic whose descent into mental illness and nihilism inspires a violent countercultural revolution against the wealthy in a decaying Gotham City. Robert De Niro, Zazie Beetz and Frances Conroy appear in supporting roles"),
      Movie(
          title: "The Batman",
          image: Assets.imagesBatman,
          genres: ["Drama", "Thriller", "Dark"],
          stars: 4,
          rating: 8.0,
          description:
              "The film sees Batman, who has been fighting crime in Gotham City for two years, uncover corruption while pursuing the Riddler (Dano), a serial killer who targets Gotham's corrupt elite. Development began after Ben Affleck was cast as Batman in the DC Extended Universe (DCEU) in 2013."),
      Movie(
          title: "1917 - Time is the enemy",
          image: Assets.imagesStarWars,
          genres: ["Science", "Thriller", "Drama"],
          stars: 3,
          rating: 7.0,
          description:
              "April 1917, the Western Front. Two British soldiers are sent to deliver an urgent message to an isolated regiment. If the message is not received in time the regiment will walk into a trap and be massacred. To get to the regiment they will need to cross through enemy territory. Time is of the essence and the journey will be fraught with danger."),
    ];
