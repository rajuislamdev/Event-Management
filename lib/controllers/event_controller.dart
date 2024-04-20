import 'package:event_management/models/common_response.dart';
import 'package:event_management/models/event.dart';
import 'package:event_management/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventController extends StateNotifier<bool> {
  final Ref ref;
  EventController(this.ref) : super(false);

  Future<CommonResponse> createEvent({required EventModel eventModel}) async {
    try {
      state = true;
      await ref.read(eventServiceProvider).createEvent(eventModel: eventModel);
      state = false;
      return CommonResponse(
        isSuccess: true,
        message: 'Event has been successfully created!',
      );
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(
        isSuccess: false,
        message: error.toString(),
      );
    }
  }

  Future<CommonResponse> updateEvent({
    required EventModel eventModel,
    required String? docId,
  }) async {
    try {
      state = true;
      await ref.read(eventServiceProvider).updateEvent(
            eventModel: eventModel,
            docId: docId,
          );
      state = false;
      return CommonResponse(
        isSuccess: true,
        message: 'Event has been successfully updated!',
      );
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(
        isSuccess: false,
        message: error.toString(),
      );
    }
  }

  Future<CommonResponse> deleteEvent({required String docId}) async {
    try {
      state = true;
      await ref.read(eventServiceProvider).deleteEvent(docId: docId);
      state = false;
      return CommonResponse(
        isSuccess: true,
        message: 'Event has been successfully deleted!',
      );
    } catch (error) {
      debugPrint(error.toString());
      state = false;
      return CommonResponse(
        isSuccess: false,
        message: error.toString(),
      );
    }
  }
}
