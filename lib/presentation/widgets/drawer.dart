import 'package:flutter/material.dart';

import '../pages/about_page.dart';
import '../pages/home_tv_series_page.dart';
import '../pages/watchlist_movies_page.dart';
import '../pages/watchlist_tv_series_page.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/circle-g.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          leading: Icon(Icons.movie),
          title: Text('Movies'),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          leading: Icon(Icons.movie),
          title: Text('TV Series'),
          onTap: () {
            Navigator.pushNamed(context, HomeTvSeriesPage.ROUTE_NAME);
          },
        ),
        ListTile(
          leading: Icon(Icons.save_alt),
          title: Text('Watchlist Movie'),
          onTap: () {
            Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
          },
        ),
        ListTile(
          leading: Icon(Icons.save_alt),
          title: Text('Watchlist TV Series'),
          onTap: () {
            Navigator.pushNamed(context, WatchlistTvSeriesPage.ROUTE_NAME);
          },
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
          },
          leading: Icon(Icons.info_outline),
          title: Text('About'),
        ),
      ],
    ),
  );
}
