import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/models/event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventService {
  final Ref ref;
  EventService(this.ref);
  final CollectionReference eventCollectionRef =
      FirebaseFirestore.instance.collection('event');

  Future<bool> createEvent({required EventModel eventModel}) async {
    await eventCollectionRef.add(eventModel.toMap());
    return true;
  }
}

final eventServiceProvider = Provider((ref) => EventService(ref));
