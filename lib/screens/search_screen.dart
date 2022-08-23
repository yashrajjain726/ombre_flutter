import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ombre_flutter/services/firbase_service.dart';

import '../constants/colors.constants.dart';
import '../models/event_model.dart';

class SearchScreen extends StatefulWidget {
  static const screenId = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchInputController;
  FirebaseService firebaseService = FirebaseService();
  List<EventModel> eventList = [];
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
                                    borderSide: const BorderSide()),
                                enabledBorder: OutlineInputBorder(
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
                  return ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            height: 100,
                            child: Row(
                              children: [
                                ((data['image_url'] != null) &&
                                        (data['image_url'] != ''))
                                    ? Image.network(
                                        data['image_url'],
                                        width: 100,
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ((data['event_name'] != null) &&
                                              (data['event_name'] != ''))
                                          ? Text(
                                              data['event_name'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 20),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ((data['event_performer_name'] != null) &&
                                              (data['event_performer_name'] !=
                                                  ''))
                                          ? Text(
                                              data['event_performer_name'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                        .toList()
                        .cast(),
                  );
                }),
          )),
    );
  }
}
