import 'package:flutter/material.dart';
import 'package:flutter_canvas/view/splash/splash_screen.dart';
import 'package:flutter_canvas/view/transform/feature/3d_card/data/model/card3d.dart';
import 'package:flutter_canvas/view/transform/feature/3d_card/view/3D_card_details.dart';
import 'package:flutter_canvas/view/transform/feature/3d_card/view/cards_3d_home.dart';
import 'package:flutter_canvas/view/transform/feature/glass_morphism/GlassMorpohismPage.dart';
import 'package:flutter_canvas/view/transform/feature/hero_list/hero_list_page.dart';
import 'package:flutter_canvas/view/transform/feature/hero_list/heroes_list_vertical.dart';
import 'package:flutter_canvas/view/transform/feature/neumorphism/neomorphism_page.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/places_viewpager_page.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/model/movie.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/movie_details.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/movies_grid_page.dart';
import 'package:flutter_canvas/view/transform/feature/viewpager/movies_page.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_canvas/account_screen.dart';
import 'package:flutter_canvas/app_scaffold.dart';
import 'package:flutter_canvas/home_screen.dart';
import 'package:flutter_canvas/search_screen.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'view/transform/feature/credit_card/view/moving_card_page.dart';

enum AppRoutes {
  splash,
  home,
  search,
  account,
  cards,
  cards3dHome,
  cardDetails,
  neomorphism,
  glassmorphism,
  movies,
  movieDetails,
  movieGrid,
  heroList,
  heroListVertical,
  places,
}

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

var _shellNavigatorKey = GlobalKey<NavigatorState>();
var _rootNavigatorKey = GlobalKey<NavigatorState>();
// GoRouter configuration
final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: AppRoutes.splash.name,
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppScaffold(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.home.name,
          path: '/home',
          builder: (context, state) => const HomeScreen(title: "Home"),
        ),
        GoRoute(
          path: '/account',
          pageBuilder: (context, state) {
            return NoTransitionPage(
                key: state.pageKey, child: const AccountScreen());
          },
        ),
        GoRoute(
          path: '/search',
          pageBuilder: (context, state) {
            return NoTransitionPage(
                key: state.pageKey, child: const SearchScreen());
          },
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/cards",
      name: AppRoutes.cards.name,
      builder: (context, state) => const MovingCardPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/neomorphism",
      name: AppRoutes.neomorphism.name,
      builder: (context, state) => const NeoMorphismPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/glassmorphism",
      name: AppRoutes.glassmorphism.name,
      builder: (context, state) => const GlassMorphismPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/cards3d",
      name: AppRoutes.cards3dHome.name,
      builder: (context, state) => const Cards3DHome(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/heroList",
      name: AppRoutes.heroList.name,
      builder: (context, state) => const HeroListPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/movieGrid",
      name: AppRoutes.movieGrid.name,
      builder: (context, state) => const MoviesGridPage(),
    ),
    /*  GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/heroListVertical",
      name: AppRoutes.heroListVertical.name,
      pageBuilder: (context, state) {
        const duration = Duration(milliseconds: 600);
        return CustomTransitionPage(
          child: const HeroesListVertical(),
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),*/
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/movie",
      name: AppRoutes.movies.name,
      builder: (context, state) => const MoviesPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/places",
      name: AppRoutes.places.name,
      builder: (context, state) => const PlacesViewPagerPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/movieDetails",
      name: AppRoutes.movieDetails.name,
      pageBuilder: (context, state) {
        final movie = state.extra as Movie;
        const duration = Duration(milliseconds: 600);
        return CustomTransitionPage(
          child: MovieDetailsPage(movie: movie),
          transitionDuration: duration,
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: "/card_details",
      name: AppRoutes.cardDetails.name,
      pageBuilder: (context, state) {
        var card = state.extra as Card3d;
        const duration = Duration(milliseconds: 750);
        return CustomTransitionPage(
          child: CardDetailsPage(card: card),
          reverseTransitionDuration: duration,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
