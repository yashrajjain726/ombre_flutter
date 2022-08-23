import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ombre_flutter/constants/colors.constants.dart';
import 'package:ombre_flutter/dashboard_screen.dart';
import 'package:ombre_flutter/screens/fav_artist_screen.dart';
import 'package:ombre_flutter/screens/home_screen.dart';
import 'package:ombre_flutter/screens/search_screen.dart';
import 'package:ombre_flutter/screens/trending_artist_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: blackColor,
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: whiteColor,
        ),
        iconTheme: IconThemeData(color: whiteColor)
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: DashBoardScreen.screenId,
      routes: {
        DashBoardScreen.screenId: (context) => const DashBoardScreen(),
        HomeScreen.screenId: (context) => const HomeScreen(),
        FavArtistScreen.screenId: (context) => const FavArtistScreen(),
        SearchScreen.screenId: (context) => const SearchScreen(),
        TrendingArtistScreen.screenId: (context) => const TrendingArtistScreen()
      },
    );
  }
}
