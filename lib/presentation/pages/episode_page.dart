import 'package:ditonton/common/arguments.dart';
import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/season.dart';
import 'episode_list_page.dart';

class EpisodePage extends StatefulWidget {
  static const ROUTE_NAME = '/episode-tvseries';

  final EpisodeArgument argument;
  const EpisodePage({super.key, required this.argument});

  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.argument.seasons.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMikadoYellow,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: kRichBlack,
          ),
        ),
        title: Text(
          'Episode Guide',
          style: kHeading6.copyWith(color: kRichBlack),
        ),
      ),
      body: DefaultTabController(
        key: Key('tab'),
        length: widget.argument.seasons.length,
        child: Scaffold(
          backgroundColor: kRichBlack,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: kRichBlack,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: kMikadoYellow,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: Colors.white,
                labelColor: kMikadoYellow,
                isScrollable: true,
                tabs: widget.argument.seasons.map((Season season) {
                  return Container(
                    padding: const EdgeInsets.only(
                      bottom: 15.0,
                      top: 10.0,
                    ),
                    child: Text(
                      season.seasonNumber.toString(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: widget.argument.seasons.map((Season season) {
              return EpisodeListPage(
                id: widget.argument.id,
                seasonNumber: season.seasonNumber,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
