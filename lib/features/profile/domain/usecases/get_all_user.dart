import 'package:clean_architecture/core/error/error.dart';
import 'package:clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:clean_architecture/features/profile/domain/repositories/profile_repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllUser {
  final ProfileRepositories repo;

  const GetAllUser({required this.repo});

  Future<Either<Failure, List<ProfileEntities>>> execute(int page) async {
    return await repo.getAllUser(page);
  }
}
