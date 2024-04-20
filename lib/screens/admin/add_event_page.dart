// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:event_management/components/custom_button.dart';
import 'package:event_management/components/custom_text_form_field.dart';
import 'package:event_management/config/app_text_style.dart';
import 'package:event_management/models/event.dart';
import 'package:event_management/providers/event_provider.dart';
import 'package:event_management/utils/context_less_navigation.dart';
import 'package:event_management/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

class AddEventScreen extends StatefulWidget {
  final EventModel? event;
  const AddEventScreen({
    super.key,
    this.event,
  });
  static final TextEditingController _eventNameController =
      TextEditingController();
  static final TextEditingController _organizerNameController =
      TextEditingController();
  static final TextEditingController _dateController = TextEditingController();
  static final TextEditingController _timeController = TextEditingController();
  static final TextEditingController _locationController =
      TextEditingController();
  static final TextEditingController _detailsController =
      TextEditingController();
  static final TextEditingController _feeController = TextEditingController();
  static final TextEditingController _deadLineController =
      TextEditingController();
  static final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  @override
  void initState() {
    if (widget.event != null) {
      AddEventScreen._eventNameController.text = widget.event!.eventName;
      AddEventScreen._organizerNameController.text = widget.event!.organizer;
      AddEventScreen._dateController.text = widget.event!.date;
      AddEventScreen._timeController.text = widget.event!.time;
      AddEventScreen._locationController.text = widget.event!.location;
      AddEventScreen._detailsController.text = widget.event!.details;
      AddEventScreen._deadLineController.text = widget.event!.deadline;
      AddEventScreen._feeController.text = widget.event!.fee.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      bottomNavigationBar: _buidBottomNavigationBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: SingleChildScrollView(
        child: FormBuilder(
          key: AddEventScreen._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: AppTextStyle(context)
                    .bodyText
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Gap(8.h),
              FormBuilderDropdown(
                focusColor: Colors.transparent,
                name: 'categories',
                initialValue: widget.event?.category ?? '',
                decoration: GlobalFunction.buildInputDecoration(
                    ContextLess.context, 'Select category', null),
                onChanged: (value) {},
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Category is required!')
                ]),
                items: categoryList
                    .map((dropdownValue) => DropdownMenuItem(
                          value: dropdownValue,
                          child: Text(dropdownValue.toString()),
                        ))
                    .toList(),
              ),
              Gap(12.h),
              CustomTextFormField(
                name: 'Event Name',
                textInputType: TextInputType.text,
                controller: AddEventScreen._eventNameController,
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                        errorText: 'Event name is required!'),
                  ],
                ),
                hintText: "Enter your event name here ",
              ),
              Gap(12.h),
              CustomTextFormField(
                name: 'Organizer',
                textInputType: TextInputType.text,
                controller: AddEventScreen._organizerNameController,
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                        errorText: 'Organizer name is required!'),
                  ],
                ),
                hintText: "Enter organizer",
              ),
              Gap(12.h),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        GlobalFunction.selectDate(context).then((date) {
                          AddEventScreen._dateController.text =
                              GlobalFunction.formateDate(date);
                        });
                      },
                      child: CustomTextFormField(
                        readOnly: true,
                        name: 'Date',
                        widget: const Icon(Icons.arrow_drop_down),
                        textInputType: TextInputType.text,
                        controller: AddEventScreen._dateController,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                                errorText: 'Date is required!'),
                          ],
                        ),
                        hintText: "Pick Date",
                      ),
                    ),
                  ),
                  Gap(12.w),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        GlobalFunction.selectTime(context).then((time) {
                          AddEventScreen._timeController.text =
                              GlobalFunction.formatTimeOfDay(time) ?? '';
                        });
                      },
                      child: CustomTextFormField(
                        readOnly: true,
                        name: 'Time',
                        widget: const Icon(Icons.arrow_drop_down),
                        textInputType: TextInputType.text,
                        controller: AddEventScreen._timeController,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                                errorText: 'Time is required!'),
                          ],
                        ),
                        hintText: "Pick Time",
                      ),
                    ),
                  ),
                ],
              ),
              Gap(12.h),
              CustomTextFormField(
                name: 'Location',
                textInputType: TextInputType.text,
                controller: AddEventScreen._locationController,
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                        errorText: 'Event location is required!'),
                  ],
                ),
                hintText: "Enter event location",
              ),
              Gap(12.h),
              CustomTextFormField(
                name: 'Write Details',
                minLines: 4,
                textInputType: TextInputType.multiline,
                controller: AddEventScreen._detailsController,
                textInputAction: TextInputAction.newline,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                        errorText: 'Event details is required!'),
                  ],
                ),
                hintText: "Start writing...",
              ),
              Gap(12.h),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        GlobalFunction.selectDate(context).then((deadlinDate) {
                          AddEventScreen._deadLineController.text =
                              GlobalFunction.formateDate(deadlinDate);
                        });
                      },
                      child: CustomTextFormField(
                        readOnly: true,
                        name: 'Deadline',
                        widget: const Icon(Icons.arrow_drop_down),
                        textInputType: TextInputType.text,
                        controller: AddEventScreen._deadLineController,
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(
                                errorText: 'Deadline is required!'),
                          ],
                        ),
                        hintText: "Pick deadline",
                      ),
                    ),
                  ),
                  Gap(12.w),
                  Flexible(
                    flex: 1,
                    child: CustomTextFormField(
                      name: 'Fee',
                      textInputType: TextInputType.number,
                      controller: AddEventScreen._feeController,
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText: 'Time is required!'),
                        ],
                      ),
                      hintText: "Add Fee",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buidBottomNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 10.h),
      child: Consumer(builder: (context, ref, _) {
        return ref.watch(eventControllerProvider)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomButton(
                buttonText: widget.event != null ? 'Update' : 'Save',
                onPressed: () {
                  if (AddEventScreen._formKey.currentState!.validate()) {
                    final EventModel eventModel = EventModel(
                      category: AddEventScreen._formKey.currentState!
                          .fields['categories']!.value as String,
                      eventName: AddEventScreen._eventNameController.text,
                      organizer: AddEventScreen._organizerNameController.text,
                      date: AddEventScreen._dateController.text.trim(),
                      time: AddEventScreen._timeController.text.trim(),
                      location: AddEventScreen._locationController.text,
                      details: AddEventScreen._detailsController.text,
                      deadline: AddEventScreen._deadLineController.text.trim(),
                      fee: int.parse(
                        AddEventScreen._feeController.text.trim(),
                      ),
                    );
                    if (widget.event != null) {
                      ref
                          .read(eventControllerProvider.notifier)
                          .updateEvent(
                            eventModel: eventModel,
                            docId: widget.event?.id,
                          )
                          .then((response) {
                        GlobalFunction.showCustomSnackbar(
                          message: response.message,
                          isSuccess: response.isSuccess,
                        );
                        if (response.isSuccess) {
                          clear();
                          context.nav.pop();
                        }
                      });
                    } else {
                      ref
                          .read(eventControllerProvider.notifier)
                          .createEvent(eventModel: eventModel)
                          .then((response) {
                        GlobalFunction.showCustomSnackbar(
                          message: response.message,
                          isSuccess: response.isSuccess,
                        );
                        if (response.isSuccess) {
                          clear();
                          context.nav.pop();
                        }
                      });
                    }
                  }
                },
              );
      }),
    );
  }

  void clear() {
    AddEventScreen._eventNameController.clear();
    AddEventScreen._organizerNameController.clear();
    AddEventScreen._dateController.clear();
    AddEventScreen._timeController.clear();
    AddEventScreen._locationController.clear();
    AddEventScreen._detailsController.clear();
    AddEventScreen._deadLineController.clear();
    AddEventScreen._feeController.clear();
  }
}

final List<String> categoryList = [
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
