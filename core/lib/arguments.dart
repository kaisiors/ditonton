import 'package:tv_series/domain/entities/season.dart';

class EpisodeArgument {
  final int id;
  final List<Season> seasons;

  EpisodeArgument({
    required this.id,
    required this.seasons,
  });
}
