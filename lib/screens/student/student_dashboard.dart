import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/config/app_color.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/misc/misc_controller.dart';
import 'package:event_management/models/event.dart';
import 'package:event_management/routes.dart';
import 'package:event_management/screens/admin/widgets/event_card.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({
    super.key,
  });

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer(builder: (context, ref, _) {
      String searchTerm = searchController.text;

      return FirestoreListView<EventModel>(
        pageSize: 20,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        query: _buildQuery(
            selectedCategory: ref.read(selectedCategory),
            searchTerm: searchTerm),
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
              isAdmin: false,
            ),
          );
        },
      );
    });
  }

  // static final doctorsQuery = FirebaseFirestore.instance
  _buildQuery({
    required String selectedCategory,
    required String searchTerm,
  }) {
    Query query = FirebaseFirestore.instance
        .collection('event')
        .orderBy('eventName')
        .orderBy('date', descending: true);
    if (selectedCategory != 'All') {
      query = query.where('category', isEqualTo: selectedCategory);
    }
    if (searchTerm.isNotEmpty) {
      // query = query.where('eventName', arrayContains: searchTerm.toLowerCase());
      query = query.startAt([searchTerm]).endAt(['$searchTerm\uf8ff']);
    }
    return query.withConverter<EventModel>(
        fromFirestore: (snapshot, _) {
          return EventModel.fromMap(snapshot.data()!).copyWith(id: snapshot.id);
        },
        toFirestore: (event, _) => event.toMap());
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
                        selected:
                            ref.watch(selectedCategory) == categories[index],
                        selectedTileColor: AppColor.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        tileColor: AppColor.offWhite,
                        title: Text(
                          categories[index],
                          style: AppTextStyle(context).bodyTextSmall.copyWith(
                              color: ref.watch(selectedCategory) ==
                                      categories[index]
                                  ? AppColor.white
                                  : null),
                        ),
                        onTap: () {
                          ref.read(selectedCategory.notifier).state =
                              categories[index];
                          setState(() {});
                          // Close drawer when an item is tapped
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                ContextLess.context.nav.popAndPushNamed(Routes.studentProfile);
                // Close drawer when Profile is tapped
              },
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
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget customAppBar() {
    return AppBar(
      title: const Text('Events'),
      centerTitle: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.purple,
              AppColor.blue,
            ],
          ),
        ),
      ),
      actions: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.w),
              width: 240,
              child: TextFormField(
                scrollPadding: EdgeInsets.zero,
                controller: searchController,
                textAlign: TextAlign.start,
                style: AppTextStyle(context)
                    .bodyTextSmall
                    .copyWith(color: AppColor.white),
                onChanged: (v) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  hintText: 'Search',
                  hintStyle: AppTextStyle(context)
                      .bodyTextSmall
                      .copyWith(color: AppColor.offWhite.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColor.offWhite.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(
                      12.sp,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColor.offWhite.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(
                      12.sp,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 26.w,
              top: 10.h,
              child: const Icon(
                Icons.search,
                color: AppColor.purple,
              ),
            ),
          ],
        )
      ],
    );
  }
}

// custom appbar

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
