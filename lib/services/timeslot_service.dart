import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:telephy/model/time_slot.dart';
import 'package:telephy/screens/User/booking_screen.dart';

class TimeslotService {
  final CollectionReference timeslots =
      FirebaseFirestore.instance.collection('timeslots');

  void addDataToFirestore(String psyId, Timestamp startTime) async {
    // Define the data you want to add
    final data = {
      'psy_id': psyId,
      'start_time': startTime,
      // Add more fields as needed
    };
    // Add the data to Firestore (Firebase will generate a unique document ID)
    await timeslots.add(data);
  }

  Future<List<Timeslot>> getAllTimeSlots() async {
    final querySnapshot = await timeslots.get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Timeslot(
        id: doc.id,
        psyId: data['psy_id'],
        startTime: (data['start_time'] as Timestamp),
      );
    }).toList();
  }

  Future<List<Timeslot>> getAllTimeSlotsByPsyId(String psyId) async {
    final querySnapshot = await timeslots
        .where('psy_id', isEqualTo: psyId)
        .get(); // Query Firestore to filter by 'psy_id'

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Timeslot(
        id: doc.id,
        psyId: data['psy_id'],
        startTime: (data['start_time'] as Timestamp),
      );
    }).toList();
  }

  Future<void> deleteTimeslot(String timeslotId) async {
    await timeslots.doc(timeslotId).delete();
  }

  Future<String?> getDocIdByTimestampAndPsyId(
      String psyId, Timestamp startTime) async {
    final querySnapshot = await timeslots
        .where('psy_id', isEqualTo: psyId)
        .where('start_time', isEqualTo: startTime)
        .get(); // Query Firestore to filter by 'psy_id' and 'start_time'

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      return doc.id; // Return the document ID
    } else {
      return null; // No matching document found
    }
  }

  Future<void> deleteTimeslotsWithPassedTime() async {
    final now = Timestamp.now(); // Get the current timestamp
    final querySnapshot = await timeslots
        .where('start_time', isLessThan: now)
        .get(); // Query Firestore to get timeslots with startTime less than the current time

    final batch = FirebaseFirestore.instance.batch();

    querySnapshot.docs.forEach((doc) {
      batch
          .delete(doc.reference); // Add each timeslot to the batch for deletion
    });

    await batch.commit(); // Commit the batch to delete the timeslots
  }
}
