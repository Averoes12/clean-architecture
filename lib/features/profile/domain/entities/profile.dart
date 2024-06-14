import 'package:equatable/equatable.dart';

class ProfileEntities extends Equatable {
  final int? id;
  final String? email, fullName, avatar;

  const ProfileEntities({this.id, this.email, this.fullName, this.avatar});
  
  @override
  List<Object?> get props => [
    id,
    email,
    fullName,
    avatar
  ];

  
}
