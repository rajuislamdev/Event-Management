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
        actions: [
          IconButton(
            onPressed: () {
              context.nav.pushNamed(Routes.adminProfile);
            },
            icon: Icon(
              Icons.person,
              size: 28.sp,
            ),
          ),
        ],
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
            isAdmin: true,
          ),
        );
      },
    );
  }

  static final doctorsQuery = FirebaseFirestore.instance
      .collection('event')
      .orderBy('date', descending: true)
      .withConverter<EventModel>(
        fromFirestore: (snapshot, _) {
          return EventModel.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
        },
        toFirestore: (event, _) => event.toMap(),
      );
}
