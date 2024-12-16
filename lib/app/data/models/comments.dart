import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  final String user;
  final String userId;
  final String text;
  final DateTime waktu;

  Comments({
    required this.user,
    required this.userId,
    required this.text,
    required this.waktu,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      user: json['user'] ?? '',
      userId: json['userId'] ?? '',
      text: json['text'] ?? '',
      waktu: (json['waktu'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'userId': userId,
      'text': text,
      'waktu': waktu,
    };
  }
}