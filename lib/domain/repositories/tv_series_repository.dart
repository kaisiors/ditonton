import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/episode.dart';

import '../../common/failure.dart';
import '../entities/tv_series.dart';
import '../entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tvSeries);
  Future<Either<Failure, List<Episode>>> getEpisodeTvSeries(
      int id, int seasonNumber);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}
