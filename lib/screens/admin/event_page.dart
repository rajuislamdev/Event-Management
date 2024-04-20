import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/models/event.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/screens/admin/widgets/event_card.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminEventPage extends StatelessWidget {
  const AdminEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Event'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.purple,
        child: const Icon(
          Icons.add,
          color: AppColor.white,
        ),
        onPressed: () => context.nav.pushNamed(Routes.addEventPage),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FirestoreListView<EventModel>(
      pageSize: 20,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      query: doctorsQuery,
      emptyBuilder: (context) => Center(
        child: Text(
          'Event is not availble!',
          style: AppTextStyle(context).subTitle,
        ),
      ),
      errorBuilder: (context, error, stackTrace) => Text(
        error.toString(),
        style: AppTextStyle(context).subTitle,
      ),
      itemBuilder: (context, doc) {
        EventModel event = doc.data();
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: EventCard(
            event: event,
          ),
        );
      },
    );

    // ListView.builder(
    //   padding: EdgeInsets.symmetric(vertical: 14.h),
    //   itemCount: _events.length,
    //   itemBuilder: (context, index) => Padding(
    //     padding: EdgeInsets.only(bottom: 14.h),
    //     child: EventCard(
    //       event: _events[index],
    //     ),
    //   ),
    // );
  }

  static final doctorsQuery = FirebaseFirestore.instance
      .collection('event')
      .orderBy('date', descending: true)
      .withConverter<EventModel>(
        fromFirestore: (snapshot, _) {
          print(snapshot.id);
          return EventModel.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
        },
        toFirestore: (event, _) => event.toMap(),
      );

  static final List<Map<String, dynamic>> _events = [
    {
      'evenName': 'Seminers',
      'organizer': 'Campus',
      'date': '10-12-2024',
      'time': '12:00 AM',
      'location': 'Bangla Motor qater amabsi',
      'details':
          'The portal should be a central location where students can find information about all types of events',
      'registrationFee': 120,
      'deadline': '01-12-2024',
    },
    {
      'evenName': 'Seminers',
      'organizer': 'Campus',
      'date': '10-12-2024',
      'time': '12:00 AM',
      'location': 'Bangla Motor qater amabsi',
      'details': 'This is a seminers events',
      'registrationFee': 120,
      'deadline': '01-12-2024',
    },
    {
      'evenName': 'Seminers',
      'organizer': 'Campus',
      'date': '10-12-2024',
      'time': '12:00 AM',
      'location': 'Bangla Motor qater amabsi',
      'details':
          'The portal should be a central location where students can find information about all types of eventss',
      'registrationFee': 120,
      'deadline': '01-12-2024',
    },
    {
      'evenName': 'Seminers',
      'organizer': 'Campus',
      'date': '10-12-2024',
      'time': '12:00 AM',
      'location': 'Bangla Motor qater amabsi',
      'details': 'This is a seminers events',
      'registrationFee': 120,
      'deadline': '01-12-2024',
    },
    {
      'evenName': 'Seminers',
      'organizer': 'Campus',
      'date': '10-12-2024',
      'time': '12:00 AM',
      'location': 'Dhaka',
      'details':
          'The portal should be a central location where students can find information about all types of events.The portal should be up-to-date with the latest event information',
      'registrationFee': 120,
      'deadline': '01-12-2024',
    },
  ];
}
