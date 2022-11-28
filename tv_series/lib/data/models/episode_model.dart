import 'package:equatable/equatable.dart';

import '../../domain/entities/episode.dart';

class EpisodeModel extends Equatable {
  final int id;
  final String name;
  final String airDate;
  final String? stillPath;
  final String? overview;
  final double voteAverage;

  const EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.stillPath,
    required this.overview,
    required this.voteAverage,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        overview: json["overview"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "still_path": stillPath,
        "overview": overview,
        "vote_average": voteAverage,
      };

  Episode toEntity() {
    return Episode(
      id: id,
      name: name,
      airDate: airDate,
      stillPath: stillPath ?? '',
      overview: overview ?? '',
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        airDate,
        stillPath,
        overview,
        voteAverage,
      ];
}
