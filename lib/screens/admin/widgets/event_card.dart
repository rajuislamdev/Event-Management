import 'package:event_management/components/confirmation_dialog.dart';
import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/models/event.dart';
import 'package:event_management/providers/event_provider.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EventCard extends StatefulWidget {
  final EventModel event;
  final bool isAdmin;

  const EventCard({
    super.key,
    required this.event,
    required this.isAdmin,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventDetails(
            context,
            widget.event.eventName,
            '${widget.event.date} ${widget.event.time}',
            'Organizer ${widget.event.organizer}',
            'Location: ${widget.event.location}',
            widget.event.details,
            'Deadline: ${widget.event.deadline}',
            'Registration Fee: RM${widget.event.fee}',
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.event.category,
                style: AppTextStyle(context)
                    .buttonText
                    .copyWith(color: AppColor.purple),
              ),
              Visibility(
                visible: widget.isAdmin,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => context.nav.pushNamed(Routes.addEventPage,
                          arguments: widget.event),
                      child: CircleAvatar(
                        backgroundColor: AppColor.offWhite,
                        radius: 16.r,
                        child: const Center(
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ),
                    Gap(8.w),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Consumer(builder: (context, ref, _) {
                            return ConfirmationDialog(
                              title: 'Are you sure want to delete this event?',
                              confirmButtonText: 'Confirm',
                              isLoading: ref.watch(eventControllerProvider),
                              onPressed: () {
                                ref
                                    .read(eventControllerProvider.notifier)
                                    .deleteEvent(docId: widget.event.id!)
                                    .then((response) {
                                  context.nav.pop();
                                });
                              },
                            );
                          }),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColor.offWhite,
                        radius: 16.r,
                        child: const Center(
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
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
                  .bodyTextSmall
                  .copyWith(color: AppColor.green, fontSize: 10.sp),
            ),
          ],
        ),
      ],
    );
  }
}
