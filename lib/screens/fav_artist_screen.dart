import 'package:flutter/material.dart';

class FavArtistScreen extends StatelessWidget {
  static const screenId = 'fav_artist_screen';
  const FavArtistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Favourite'),
      ),
    );
  }
}
