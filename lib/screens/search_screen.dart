import 'package:flutter/material.dart';

import '../constants/colors.constants.dart';

class SearchScreen extends StatefulWidget {
  static const screenId = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchInputController;
  @override
  void initState() {
    super.initState();
    _searchInputController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: whiteColor, fontSize: 13),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: secondaryColor,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              hintText:
                                  'Search your favourite artist, events ..',
                              hintStyle:
                                  TextStyle(color: greyColor, fontSize: 13),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: const BorderSide())),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: secondaryColor,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        body: const Center(
          child: Text('Search'),
        ),
      ),
    );
  }
}
