import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final Stream<QuerySnapshot> eventsListFromDatabase =
  FirebaseFirestore.instance.collection('events').snapshots();
  }
