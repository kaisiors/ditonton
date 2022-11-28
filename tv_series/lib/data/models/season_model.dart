import 'package:equatable/equatable.dart';

import '../../domain/entities/season.dart';

class SeasonModel extends Equatable {
  final int id;
  final String name;
  final int episodeCount;
  final int seasonNumber;

  const SeasonModel({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.seasonNumber,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        episodeCount: json["episode_count"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "episode_count": episodeCount,
        "season_number": seasonNumber,
      };

  Season toEntity() {
    return Season(
      id: id,
      name: name,
      episodeCount: episodeCount,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        episodeCount,
        seasonNumber,
      ];
}
