import 'package:tv_series/tv_series.dart';

final testTvSeries = TvSeries(
  backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
  genreIds: const [10765, 18, 10759],
  id: 94997,
  originalName: 'House of the Dragon',
  overview:
      'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
  popularity: 7437.735,
  posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
  firstAirDate: '2022-08-21',
  name: 'House of the Dragon',
  voteAverage: 8.6,
  voteCount: 1702,
);

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: "/1rO4xoCo4Z5WubK0OwdVll3DPYo.jpg",
  genres: [Genre(id: 10765, name: "Sci-Fi & Fantasy")],
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
    Season(episodeCount: 18, id: 114041, name: "Season 1", seasonNumber: 1)
  ],
);

const testEpisode = Episode(
  id: 1865375,
  name: "A Shadow of the Past",
  airDate: "2022-09-01",
  overview:
      "Galadriel is disturbed by signs of an ancient evil's return; Arondir makes an unsettling discovery; Elrond is presented with an intriguing new venture; Nori breaks the Harfoot community's most deeply-held rule.",
  stillPath: "/e40fPU0TDJaZ5bUGb2ryr2b9XqT.jpg",
  voteAverage: 6.862,
);

final testEpisodeList = [testEpisode];

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};
