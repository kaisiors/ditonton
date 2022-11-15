import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    homepage: '',
    originalLanguage: '',
    status: '',
    tagline: '',
    budget: 0,
    imdbId: '1',
    revenue: 0,
    runtime: 0,
    video: false,
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    runtime: 0,
  );

  test('should be a subclass of MovieDetail entity', () async {
    final result = tMovieDetailModel.toEntity();
    expect(result, tMovieDetail);
  });
}
