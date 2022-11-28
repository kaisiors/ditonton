import 'package:flutter/material.dart';
import 'package:movies/movies.dart';

import '../pages/home_tv_series_page.dart';
import '../pages/watchlist_tv_series_page.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/circle-g.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('TV Series'),
          onTap: () {
            Navigator.pushNamed(context, HomeTvSeriesPage.ROUTE_NAME);
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist Movie'),
          onTap: () {
            Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist TV Series'),
          onTap: () {
            Navigator.pushNamed(context, WatchlistTvSeriesPage.ROUTE_NAME);
          },
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/about');
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
    ),
  );
}
