// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventDetails(
            context,
            event['evenName'],
            '${event['date']} ${event['time']}',
            'Organizer ${event['organizer']}',
            'Location: ${event['location']}',
            event['details'],
            'Deadline: ${event['deadline']}',
            'Registration Fee: \$${event['registrationFee']}',
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails(
    BuildContext context,
    String eventName,
    String dateTime,
    String organizer,
    String location,
    String details,
    String deadline,
    String registrationFee,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              eventName,
              style: AppTextStyle(context)
                  .bodyText
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  dateTime,
                  style: AppTextStyle(context)
                      .bodyTextSmall
                      .copyWith(color: AppColor.blue),
                ),
              ],
            ),
          ],
        ),
        const Gap(5),
        Text(
          organizer,
          style: AppTextStyle(context).bodyTextSmall,
        ),
        const Gap(5),
        Text(
          location,
          style: AppTextStyle(context).bodyTextSmall,
        ),
        const Gap(5),
        Text(
          details,
          style: AppTextStyle(context)
              .bodyTextSmall
              .copyWith(fontWeight: FontWeight.w400),
        ),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              deadline,
              style: AppTextStyle(context)
                  .bodyTextSmall
                  .copyWith(color: AppColor.red),
            ),
            Text(
              registrationFee,
              style: AppTextStyle(context)
                  .bodyText
                  .copyWith(color: AppColor.green),
            ),
          ],
        ),
      ],
    );
  }
}
