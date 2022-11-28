import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource);
  });

  const tTvSeriesModel = TvSeriesModel(
      backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      firstAirDate: "2022-08-21",
      genreIds: [10765, 18, 10759],
      id: 94997,
      name: "House of the Dragon",
      originalName: "House of the Dragon",
      overview:
          "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
      popularity: 7222.052,
      posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
      voteAverage: 8.6,
      voteCount: 1564);

  const tTvSeriesTable = TvSeriesTable(
    id: 94997,
    name: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
  );

  final tTvSeries = TvSeries(
      backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
      firstAirDate: "2022-08-21",
      genreIds: const [10765, 18, 10759],
      id: 94997,
      name: "House of the Dragon",
      originalName: "House of the Dragon",
      overview:
          "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
      popularity: 7222.052,
      posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
      voteAverage: 8.6,
      voteCount: 1564);

  final tTvSeriesLocal = TvSeries(
    id: 94997,
    name: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
    backdropPath: null,
    firstAirDate: null,
    genreIds: null,
    originalName: null,
    popularity: null,
    voteAverage: null,
    voteCount: null,
  );

  const tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    genres: <Genre>[],
    id: 94997,
    originalName: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
    firstAirDate: "2022-08-21",
    name: "House of the Dragon",
    voteAverage: 8.6,
    voteCount: 1564,
    seasons: <Season>[],
  );

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesTableList = <TvSeriesTable>[tTvSeriesTable];
  final tTvSeriesList = <TvSeries>[tTvSeries];
  final tTvSeriesLocalList = <TvSeries>[tTvSeriesLocal];

  group('Now playing TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return common failure when the certificate not valid',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(const TlsException('Certificate not valid'));
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(
          result, equals(const Left(CommonFailure('Certificate not valid'))));
    });
  });

  group('Popular TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return common failure when the certificate not valid',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(const TlsException('Certificate not valid'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      expect(
          result, equals(const Left(CommonFailure('Certificate not valid'))));
    });
  });

  group('Top Rated TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return common failure when the certificate not valid',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const TlsException('Certificate not valid'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      expect(
          result, equals(const Left(CommonFailure('Certificate not valid'))));
    });
  });

  group('Get TV Series Detail', () {
    const tId = 1;
    const tTvSeriesResponse = TvSeriesDetailResponse(
      adult: false,
      backdropPath: "/1rO4xoCo4Z5WubK0OwdVll3DPYo.jpg",
      genres: [GenreModel(id: 10765, name: "Sci-Fi & Fantasy")],
      id: 84773,
      originalName: "The Lord of the Rings: The Rings of Power",
      overview:
          "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
      posterPath: "/mYLOqiStMxDK3fYZFirgrMt8z5d.jpg",
      firstAirDate: "2022-09-01",
      name: "The Lord of the Rings: The Rings of Power",
      voteAverage: 7.691,
      voteCount: 1012,
      seasons: [
        SeasonModel(
            episodeCount: 18, id: 114041, name: "Season 1", seasonNumber: 1)
      ],
      homepage: 'https://google.com',
      originalLanguage: 'en',
      popularity: 1,
      status: 'Status',
      tagline: 'Tagline',
    );

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tTvSeriesResponse);
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(const Right(testTvSeriesDetail)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return common failure when the certificate not valid',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(const TlsException('Certificate not valid'));
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(
          result, equals(const Left(CommonFailure('Certificate not valid'))));
    });
  });

  group('Recommendations TV Series', () {
    final tTvSeriesList = <TvSeriesModel>[];
    const tId = 1;

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => tTvSeriesList);
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return common failure when the certificate not valid',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(const TlsException('Certificate not valid'));
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(
          result, equals(const Left(CommonFailure('Certificate not valid'))));
    });
  });

  group('Watchlist TV Series', () {
    test(
        'should return local data when the call to local data source is successful',
        () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => tTvSeriesTableList);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      verify(mockLocalDataSource.getWatchlistTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesLocalList);
    });

    test('should return true when added to watchlist', () async {
      // arrange
      when(mockLocalDataSource.getTvSeriesById(1))
          .thenAnswer((_) async => tTvSeriesTable);
      // act
      final result = await repository.isAddedToWatchlist(1);
      // assert
      verify(mockLocalDataSource.getTvSeriesById(1));
      expect(result, true);
    });

    test('should return empty when the call to local data source is empty',
        () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => <TvSeriesTable>[]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      verify(mockLocalDataSource.getWatchlistTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, <TvSeries>[]);
    });

    test('should return Added to Watchlist when add to watchlist is successful',
        () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(tTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(tTvSeriesDetail);
      // assert
      verify(mockLocalDataSource.insertWatchlist(tTvSeriesTable));
      final resultList = result.getOrElse(() => '');
      expect(resultList, 'Added to Watchlist');
    });

    test(
        'should return Removed from Watchlist when remove from watchlist is successful',
        () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(tTvSeriesTable))
          .thenAnswer((_) async => 'Removed from Watchlist');
      // act
      final result = await repository.saveWatchlist(tTvSeriesDetail);
      // assert
      verify(mockLocalDataSource.insertWatchlist(tTvSeriesTable));
      final resultList = result.getOrElse(() => '');
      expect(resultList, 'Removed from Watchlist');
    });
  });

  group('Search TV Series', () {
    final tTvSeriesModelList = <TvSeriesModel>[];
    final tTvSeriesList = <TvSeriesModel>[];
    const tQuery = 'a';

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      verify(mockRemoteDataSource.searchTvSeries(tQuery));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      verify(mockRemoteDataSource.searchTvSeries(tQuery));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      verify(mockRemoteDataSource.searchTvSeries(tQuery));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return common failure when the certificate not valid',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(const TlsException('Certificate not valid'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      verify(mockRemoteDataSource.searchTvSeries(tQuery));
      expect(
          result, equals(const Left(CommonFailure('Certificate not valid'))));
    });
  });

  group('Episode TV Series', () {
    final tEpisodeList = <EpisodeModel>[];
    const tId = 1;
    const tSeasonNumber = 1;

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getEpisodeTvSeries(tId, tSeasonNumber))
          .thenAnswer((_) async => tEpisodeList);
      // act
      final result = await repository.getEpisodeTvSeries(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getEpisodeTvSeries(tId, tSeasonNumber));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tEpisodeList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getEpisodeTvSeries(tId, tSeasonNumber))
          .thenThrow(ServerException());
      // act
      final result = await repository.getEpisodeTvSeries(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getEpisodeTvSeries(tId, tSeasonNumber));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getEpisodeTvSeries(tId, tSeasonNumber))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getEpisodeTvSeries(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getEpisodeTvSeries(tId, tSeasonNumber));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return common failure when the certificate not valid',
        () async {
      // arrange
      when(mockRemoteDataSource.getEpisodeTvSeries(tId, tSeasonNumber))
          .thenThrow(const TlsException('Certificate not valid'));
      // act
      final result = await repository.getEpisodeTvSeries(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getEpisodeTvSeries(tId, tSeasonNumber));
      expect(
          result, equals(const Left(CommonFailure('Certificate not valid'))));
    });
  });
}
