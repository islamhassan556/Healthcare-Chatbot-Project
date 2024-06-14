import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final Timestamp createdAt;
  final String id;

  Message({
    required this.message,
    required this.createdAt,
    required this.id,
  });

  factory Message.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Message(
      message: data['message'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      id: data['id'] ?? '',
    );
  }
}
