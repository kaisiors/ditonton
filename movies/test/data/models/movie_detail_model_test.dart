import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';

void main() {
  const tMovieDetailModel = MovieDetailResponse(
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

  const tMovieDetail = MovieDetail(
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
