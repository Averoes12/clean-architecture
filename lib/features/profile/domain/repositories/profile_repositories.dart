import 'package:clean_architecture/core/error/error.dart';
import 'package:clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepositories {
  Future<Either<Failure, List<ProfileEntities>>> getAllUser(int page);
  Future<Either<Failure, ProfileEntities>> getUser(int id);
}
