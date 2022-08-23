import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ombre_flutter/services/firbase_service.dart';
import '../constants/colors.constants.dart';
import '../constants/size.constants.dart';

class SearchScreen extends StatefulWidget {
  static const screenId = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchInputController;
  FirebaseService firebaseService = FirebaseService();
  String searchVal = "";
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

  searchCardWidget(data) {
    return ListTile(
      title: Text(data['song_type'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
                color: primaryColor,
                fontSize: size14,
                fontWeight: FontWeight.normal),
          )),
      subtitle: Text(
        data['event_name'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.josefinSans(
          textStyle: TextStyle(
            color: whiteColor,
            fontSize: size16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: Image.network(
        data['image_url'],
        width: size75,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Column(
                children: [
                  SizedBox(
                    height: size30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: size10),
                          child: TextFormField(
                            controller: _searchInputController,
                            onChanged: (value) {
                              setState(() {
                                searchVal = value;
                              });
                            },
                            keyboardType: TextInputType.text,
                            style:
                                TextStyle(color: whiteColor, fontSize: size13),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: secondaryColor,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: size10,
                                  horizontal: size15,
                                ),
                                hintText:
                                    'Search your favourite artist, events ..',
                                hintStyle: TextStyle(
                                    color: greyColor, fontSize: size13),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(size60),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(size60),
                                )),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: size10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size60),
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
          body: Center(
            child: StreamBuilder(
                stream: firebaseService.eventsListFromDatabase,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went Wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: whiteColor,
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      bool searchContains = data['event_name']
                          .toString()
                          .toLowerCase()
                          .contains(searchVal.toLowerCase());
                      if (searchVal.isEmpty || searchContains) {
                        return searchCardWidget(data);
                      }
                      return Container();
                    },
                  );
                }),
          )),
    );
  }
}
