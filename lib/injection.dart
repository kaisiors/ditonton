import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => NowPlayingCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailMovieCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationMovieCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMovieCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieCubit(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvSeriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailTvSeriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationTvSeriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvSeriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesCubit(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => EpisodeTvSeriesCubit(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetEpisodeTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
