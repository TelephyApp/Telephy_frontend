import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:telephy/model/appointment.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/screens/User/booking_screen.dart';
import 'package:telephy/services/chat_service.dart';
import 'package:telephy/services/timeslot_service.dart';
import 'package:telephy/services/user_service.dart';

class AppointmentService {
  final CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');

  Future<void> addAppointment(Timeslot timeslot, String? userId) async {
    final data = {
      'user_uid': userId,
      'psy_uid': timeslot.psyId,
      'start_time': timeslot.startTime,
    };
    if (await appointments
        .where('start_time', isEqualTo: timeslot.psyId)
        .get()
        .then((value) {
      return value.size == 0;
    })) {
      await appointments.add(data);
      final chatService = ChatService();
      await chatService.createChatRoom(timeslot.psyId, userId!);
      // Delete the timeslot
      final timeslotService = TimeslotService();
      await timeslotService.deleteTimeslot(timeslot.id);
    }
  }

  Future<List<Appointment>> getAppointmentsByPsyUid(String psyId) async {
    final querySnapshot = await appointments
        .where('psy_uid', isEqualTo: psyId)
        .get(); // Query Firestore to filter by 'psy_id'

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Appointment(
        userUid: data['user_uid'],
        psyUid: data['psy_uid'],
        startTime: data['start_time'] as Timestamp,
      );
    }).toList();
  }

  Future getLastestAppointments(String psyId, String userId) async {
    final querySnapshot = await appointments
        .where('psy_uid', isEqualTo: psyId)
        .where('user_uid', isEqualTo: userId)
        .orderBy('start_time', descending: false)
        .get(); // Query Firestore to filter by 'psy_id'

    if (querySnapshot.docs.isEmpty) {
      return null;
    }
    final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
    return Appointment(
      userUid: data['user_uid'],
      psyUid: data['psy_uid'],
      startTime: data['start_time'] as Timestamp,
    );
  }

  Future<void> deleteAppointmentsWithPassedTime() async {
    final now = Timestamp.now()
        .toDate()
        .subtract(Duration(hours: 1)); // Get the current timestamp
    final nowTimeStamp = Timestamp.fromDate(now);
    final querySnapshot = await appointments
        .where('start_time', isLessThan: nowTimeStamp)
        .get(); // Query Firestore to get appointments with startTime less than the current time

    final batch = FirebaseFirestore.instance.batch();

    querySnapshot.docs.forEach((doc) {
      batch.delete(
          doc.reference); // Add each appointment to the batch for deletion
    });

    await batch.commit(); // Commit the batch to delete the appointments
  }
}
