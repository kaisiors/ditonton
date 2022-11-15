import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/episode.dart';
import '../repositories/tv_series_repository.dart';

class GetEpisodeTvSeries {
  final TvSeriesRepository repository;

  GetEpisodeTvSeries(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int seasonNumber) {
    return repository.getEpisodeTvSeries(id, seasonNumber);
  }
}
