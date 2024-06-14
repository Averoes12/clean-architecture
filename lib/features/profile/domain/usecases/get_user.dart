import 'package:clean_architecture/core/error/error.dart';
import 'package:clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:clean_architecture/features/profile/domain/repositories/profile_repositories.dart';
import 'package:dartz/dartz.dart';

class GetUser {
  final ProfileRepositories repo;

  const GetUser({required this.repo});

  Future<Either<Failure, ProfileEntities>> execute(int id) async {
    return await repo.getUser(id);
  }
}
