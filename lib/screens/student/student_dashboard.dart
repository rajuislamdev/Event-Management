import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/misc/misc_controller.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        centerTitle: true,
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColor.white,
      surfaceTintColor: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90.h,
            padding: EdgeInsets.only(top: 20.h),
            color: AppColor.purple,
            child: Center(
              child: Text(
                'Event Management',
                style: AppTextStyle(ContextLess.context)
                    .title
                    .copyWith(color: AppColor.white),
              ),
            ),
          ),
          Flexible(
            flex: 9,
            child: Consumer(builder: (context, ref, _) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Scrollbar(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: categories.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: ListTile(
                              selected: ref.watch(selectedCategory) ==
                                  categories[index],
                              selectedTileColor: AppColor.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              tileColor: AppColor.offWhite,
                              title: Text(
                                categories[index],
                                style: AppTextStyle(context)
                                    .bodyTextSmall
                                    .copyWith(
                                        color: ref.watch(selectedCategory) ==
                                                categories[index]
                                            ? AppColor.white
                                            : null),
                              ),
                              onTap: () {
                                ref.read(selectedCategory.notifier).state =
                                    categories[index];
                              },
                            ),
                          )),
                ),
              );
            }),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: AppColor.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 22.sp,
                    ),
                    Gap(12.w),
                    Text(
                      'Profile',
                      style: AppTextStyle(ContextLess.context).bodyText,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

final List<String> categories = [
  'All',
  'Business',
  'Social',
  'Educational',
  'Cultural',
  'Sports',
  'Fundraising',
  'Exhibition',
  'Concert',
  'Festival',
  'Religious',
  'International Student Society',
  'Tech'
];
