import 'dart:convert';

import 'package:flutter/physics.dart';

class User {
  String status;
  User({this.status});

  User copyWith({String status}) {
    return User(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {'status': status};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User( status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
