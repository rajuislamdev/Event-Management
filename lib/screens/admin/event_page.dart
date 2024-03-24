import 'package:event_management/config/app_color.dart';
import 'package:event_management/screens/admin/widgets/event_card.dart';
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
        onPressed: () {},
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      itemCount: _events.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 14.h),
        child: EventCard(
          event: _events[index],
        ),
      ),
    );
  }

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
