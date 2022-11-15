import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/episode.dart';
import '../provider/episode_tv_series.dart';

class EpisodeListPage extends StatefulWidget {
  final int id, seasonNumber;
  const EpisodeListPage(
      {super.key, required this.id, required this.seasonNumber});

  @override
  State<EpisodeListPage> createState() => _EpisodeListPageState();
}

class _EpisodeListPageState extends State<EpisodeListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<EpisodeTvSeriesNotifier>(context, listen: false)
          .fetchEpisodeTvSeries(widget.id, widget.seasonNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EpisodeTvSeriesNotifier>(
        builder: (context, provider, child) {
          if (provider.state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == RequestState.Loaded) {
            final episodes = provider.episodes;
            return SafeArea(
              child: SingleChildScrollView(
                child: DetailContent(
                  episodes,
                ),
              ),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final List<Episode> episodes;

  const DetailContent(this.episodes, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        final episode = episodes[index];

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Card(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16 + 80 + 16,
                    bottom: 8,
                    right: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        episode.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kHeading6,
                      ),
                      SizedBox(height: 16),
                      Text(
                        episode.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: '$BASE_IMAGE_URL${episode.stillPath}',
                    width: 80,
                    height: 100,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80,
                      height: 100,
                      color: kMikadoYellow,
                      child: Icon(
                        Icons.error,
                        color: kRichBlack,
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
