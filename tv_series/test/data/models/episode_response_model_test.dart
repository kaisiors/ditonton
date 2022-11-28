import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

import '../../json_reader.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    id: 1865375,
    name: "A Shadow of the Past",
    airDate: "2022-09-01",
    overview:
        "Galadriel is disturbed by signs of an ancient evil's return; Arondir makes an unsettling discovery; Elrond is presented with an intriguing new venture; Nori breaks the Harfoot community's most deeply-held rule.",
    stillPath: "/e40fPU0TDJaZ5bUGb2ryr2b9XqT.jpg",
    voteAverage: 6.862,
  );

  const tEpisodeResponseModel =
      EpisodeResponse(episodeList: <EpisodeModel>[tEpisodeModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_episode.json'));
      // act
      final result = EpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tEpisodeResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "episodes": [
          {
            "air_date": "2022-09-01",
            "id": 1865375,
            "name": "A Shadow of the Past",
            "overview":
                "Galadriel is disturbed by signs of an ancient evil's return; Arondir makes an unsettling discovery; Elrond is presented with an intriguing new venture; Nori breaks the Harfoot community's most deeply-held rule.",
            "still_path": "/e40fPU0TDJaZ5bUGb2ryr2b9XqT.jpg",
            "vote_average": 6.862,
          },
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
