import 'dart:convert';

class UserModel {
  final String name;
  final String profilePic;
  final String uid;
  final String? email;

  final String? fcmtoken;
  final bool isOnline;

  UserModel({
    required this.name,
    required this.profilePic,
    required this.uid,
    this.email,
    this.fcmtoken,
    required this.isOnline,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? uid,
    String? email,
    String? fcmtoken,
    bool? isOnline,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fcmtoken: fcmtoken ?? this.fcmtoken,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'profilePic': profilePic});
    result.addAll({'uid': uid});
    if (email != null) {
      result.addAll({'email': email});
    }

    if (fcmtoken != null) {
      result.addAll({'fcmtoken': fcmtoken});
    }
    result.addAll({'isOnline': isOnline});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'],
      fcmtoken: map['fcmtoken'],
      isOnline: map['isOnline'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, uid: $uid, email: $email, fcmtoken: $fcmtoken, isOnline: $isOnline)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.email == email &&
        other.fcmtoken == fcmtoken &&
        other.isOnline == isOnline;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        email.hashCode ^
        fcmtoken.hashCode ^
        isOnline.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
