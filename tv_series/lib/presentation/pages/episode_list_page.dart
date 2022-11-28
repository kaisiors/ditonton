import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

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
    context
        .read<EpisodeTvSeriesCubit>()
        .getEpisode(widget.id, widget.seasonNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EpisodeTvSeriesCubit, EpisodeTvSeriesState>(
        builder: (context, state) {
          if (state is EpisodeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EpisodeHasData) {
            final episodes = state.result;
            return SafeArea(
              child: SingleChildScrollView(
                child: DetailContent(
                  episodes,
                ),
              ),
            );
          } else if (state is EpisodeError) {
            return Center(
              child: Text(
                key: const Key('error_message'),
                state.message,
              ),
            );
          } else {
            return const Center(
              child: Text('No Data'),
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
                      const SizedBox(height: 16),
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
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: '$BASE_IMAGE_URL${episode.stillPath}',
                    width: 80,
                    height: 100,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80,
                      height: 100,
                      color: kMikadoYellow,
                      child: const Icon(
                        Icons.error,
                        color: kRichBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
