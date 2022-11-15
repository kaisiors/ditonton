import 'package:dartz/dartz.dart';
import '../../common/failure.dart';

import '../entities/tv_series_detail.dart';
import '../repositories/tv_series_repository.dart';

class SaveWatchlistTvSeries {
  final TvSeriesRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
