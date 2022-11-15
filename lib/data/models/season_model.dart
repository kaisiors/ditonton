import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  final int id;
  final String name;
  final int episodeCount;
  final int seasonNumber;

  SeasonModel({
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
      id: this.id,
      name: this.name,
      episodeCount: this.episodeCount,
      seasonNumber: this.seasonNumber,
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
