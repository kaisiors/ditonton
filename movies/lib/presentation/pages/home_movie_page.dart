import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../bloc/now_playing/now_playing_cubit.dart';
import '../bloc/popular/popular_cubit.dart';
import '../bloc/top_rated/top_rated_cubit.dart';
import '../widgets/drawer.dart';
import 'movie_detail_page.dart';
import 'popular_movies_page.dart';
import 'search_page.dart';
import 'top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<NowPlayingCubit>().getData();
    context.read<PopularCubit>().getData();
    context.read<TopRatedCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                key: const Key('now_playing'),
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingCubit, NowPlayingState>(
                builder: (context, state) {
                  if (state is NowPlayingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingHasData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is NowPlayingError) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        key: const Key('error_message'),
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text('No Data'),
                      ),
                    );
                  }
                },
              ),
              _buildSubHeading(
                key: 'popular',
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularCubit, PopularState>(
                builder: (context, state) {
                  if (state is PopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularHasData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is PopularError) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        key: const Key('error_message'),
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text('No Data'),
                      ),
                    );
                  }
                },
              ),
              _buildSubHeading(
                key: 'top_rated',
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedCubit, TopRatedState>(
                builder: (context, state) {
                  if (state is TopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedHasData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is TopRatedError) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        key: const Key('error_message'),
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text('No Data'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading(
      {required String key, required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key: Key(key),
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
