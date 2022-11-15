import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final String airDate;
  final String overview;
  final String stillPath;
  final double voteAverage;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.overview,
    required this.stillPath,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        airDate,
        stillPath,
        voteAverage,
      ];
}
