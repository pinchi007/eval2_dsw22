import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteDoctor(String uid) async {
  await db.collection("people").doc(uid).delete();
}
