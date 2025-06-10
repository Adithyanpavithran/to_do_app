import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addtodo({required text, required BuildContext context}) async {
  try {
    await FirebaseFirestore.instance.collection("Todolist").add({
      "Todo": text,
      "Time": Timestamp.now(),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task Added"),
        backgroundColor: const Color.fromARGB(255, 156, 155, 155),
        behavior: SnackBarBehavior.floating,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  } catch (e) {}
}

Stream<List<Map<String, dynamic>>> fetchtodo() {
  return FirebaseFirestore.instance
      .collection("Todolist")
      .orderBy("Time", descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList(),
      );
}

Future<void> deletetodo(String id) async {
  await FirebaseFirestore.instance.collection("Todolist").doc(id).delete();
}

Future<void> updatetodo(String id, String text) async {
  await FirebaseFirestore.instance.collection("Todolist").doc(id).update({
    "Todo": text,
  });
}
