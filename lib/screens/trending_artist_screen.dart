import 'package:flutter/material.dart';

class TrendingArtistScreen extends StatelessWidget {
  static const screenId = 'trending_artist_screen';
  const TrendingArtistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Trending'),
      ),
    );
  }
}
