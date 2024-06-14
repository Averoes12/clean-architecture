import 'dart:convert';

import 'package:clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:equatable/equatable.dart';

class ProfileModel extends ProfileEntities {
  final String? firstName, lastName;

  const ProfileModel(
      {required super.id,
      required super.email,
      required super.avatar,
      this.firstName,
      this.lastName})
      : super(fullName: "$firstName $lastName");

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }

  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar];
}
