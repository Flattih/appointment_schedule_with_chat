import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final String profImg;
  final String title;
  final String description;
  final String location;
  final List<String> approvalsCount;

  final List<String> approvalsCount2;

  final List<String> approvalsCount3;

  final DateTime createdAt;
  final String username;
  final String uid;
  final String appointmentDate;
  final String appointmentTime;
  final String? appointmentTime2;
  final String? appointmentTime3;
  Post({
    required this.id,
    required this.profImg,
    required this.title,
    required this.description,
    required this.location,
    required this.approvalsCount,
    required this.approvalsCount2,
    required this.approvalsCount3,
    required this.createdAt,
    required this.username,
    required this.uid,
    required this.appointmentDate,
    required this.appointmentTime,
    this.appointmentTime2,
    this.appointmentTime3,
  });

  Post copyWith({
    String? id,
    String? profImg,
    String? title,
    String? description,
    String? location,
    List<String>? approvalsCount,
    List<String>? disapprovalCount,
    List<String>? approvalsCount2,
    List<String>? disapprovalCount2,
    List<String>? approvalsCount3,
    List<String>? disapprovalCount3,
    DateTime? createdAt,
    String? username,
    String? uid,
    String? appointmentDate,
    String? appointmentTime,
    String? appointmentTime2,
    String? appointmentTime3,
  }) {
    return Post(
      id: id ?? this.id,
      profImg: profImg ?? this.profImg,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      approvalsCount: approvalsCount ?? this.approvalsCount,
      approvalsCount2: approvalsCount2 ?? this.approvalsCount2,
      approvalsCount3: approvalsCount3 ?? this.approvalsCount3,
      createdAt: createdAt ?? this.createdAt,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      appointmentTime2: appointmentTime2 ?? this.appointmentTime2,
      appointmentTime3: appointmentTime3 ?? this.appointmentTime3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profImg': profImg,
      'title': title,
      'description': description,
      'location': location,
      'approvalsCount': approvalsCount,
      'approvalsCount2': approvalsCount2,
      'approvalsCount3': approvalsCount3,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'username': username,
      'uid': uid,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'appointmentTime2': appointmentTime2,
      'appointmentTime3': appointmentTime3,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      profImg: map['profImg'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      approvalsCount: List<String>.from(map['approvalsCount']),
      approvalsCount2: List<String>.from(map['approvalsCount2']),
      approvalsCount3: List<String>.from(map['approvalsCount3']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      appointmentDate: map['appointmentDate'] ?? '',
      appointmentTime: map['appointmentTime'] ?? '',
      appointmentTime2: map['appointmentTime2'],
      appointmentTime3: map['appointmentTime3'],
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, profImg: $profImg, title: $title, description: $description, location: $location, approvalsCount: $approvalsCount, approvalsCount2: $approvalsCount2, approvalsCount3: $approvalsCount3,createdAt: $createdAt, username: $username, uid: $uid, appointmentDate: $appointmentDate, appointmentTime: $appointmentTime, appointmentTime2: $appointmentTime2, appointmentTime3: $appointmentTime3)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.id == id &&
        other.profImg == profImg &&
        other.title == title &&
        other.description == description &&
        other.location == location &&
        listEquals(other.approvalsCount, approvalsCount) &&
        listEquals(other.approvalsCount2, approvalsCount2) &&
        listEquals(other.approvalsCount3, approvalsCount3) &&
        other.createdAt == createdAt &&
        other.username == username &&
        other.uid == uid &&
        other.appointmentDate == appointmentDate &&
        other.appointmentTime == appointmentTime &&
        other.appointmentTime2 == appointmentTime2 &&
        other.appointmentTime3 == appointmentTime3;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        profImg.hashCode ^
        title.hashCode ^
        description.hashCode ^
        location.hashCode ^
        approvalsCount.hashCode ^
        approvalsCount2.hashCode ^
        approvalsCount3.hashCode ^
        createdAt.hashCode ^
        username.hashCode ^
        uid.hashCode ^
        appointmentDate.hashCode ^
        appointmentTime.hashCode ^
        appointmentTime2.hashCode ^
        appointmentTime3.hashCode;
  }
}
