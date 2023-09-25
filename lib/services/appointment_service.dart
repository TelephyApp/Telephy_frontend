import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/screens/User/booking_screen.dart';
import 'package:telephy/services/timeslot_service.dart';

class AppointmentService {
  final CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');

  Future<void> addAppointment(Timeslot timeslot, String userId) async {
    final data = {
      'user_uid': userId,
      'psy_uid': timeslot.psyId,
      'start_time': timeslot.startTime,
    };

    await appointments.add(data);
    // Delete the timeslot
    final timeslotService = TimeslotService();
    await timeslotService.deleteTimeslot(timeslot.id);
  }

  

  
}
