import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int id;
  final String name;
  final int episodeCount;
  final int seasonNumber;

  Season({
    required this.id,
    required this.name,
    required this.episodeCount,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        episodeCount,
        seasonNumber,
      ];
}
