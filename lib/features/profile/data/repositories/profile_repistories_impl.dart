import 'package:clean_architecture/core/error/error.dart';
import 'package:clean_architecture/features/profile/data/datasources/local.dart';
import 'package:clean_architecture/features/profile/data/datasources/remote.dart';
import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:clean_architecture/features/profile/domain/entities/profile.dart';
import 'package:clean_architecture/features/profile/domain/repositories/profile_repositories.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

class ProfileRepositoriesImpl extends ProfileRepositories {
  final ProfileRemote profileRemote;
  final ProfileLocal profileLocal;
  final HiveInterface hive;

  ProfileRepositoriesImpl(
      {required this.profileLocal,
      required this.profileRemote,
      required this.hive});

  @override
  Future<Either<Failure, List<ProfileEntities>>> getAllUser(int page) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        List<ProfileModel> list = await profileLocal.getAllUser(page);

        var box = hive.box("profile_box");
        box.put("getAllUser", list);
        return Right(list);
      } else {
        List<ProfileModel> list = await profileRemote.getAllUser(page);
        return Right(list);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ProfileEntities>> getUser(int id) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        ProfileModel profile = await profileLocal.getUser(id);
        var box = hive.box("profile_box");
        box.put("getUser", profile);
        return Right(profile);
      } else {
        ProfileModel profile = await profileRemote.getUser(id);
        return Right(profile);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
