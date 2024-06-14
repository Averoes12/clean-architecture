import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:hive/hive.dart';

abstract class ProfileLocal {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileLocalImpl extends ProfileLocal {
  final HiveInterface hive;

  ProfileLocalImpl({required this.hive});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    var box = hive.box("profile_box");
    return await box.get("getAllUser");
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    var box = hive.box("profile_box");
    return await box.get("getUser");
  }
}
