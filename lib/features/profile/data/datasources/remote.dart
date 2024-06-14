import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:http/http.dart' as http;

abstract class ProfileRemote {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileRemoteImpl extends ProfileRemote {
  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    Uri url = Uri.parse("https://reqres.in/api/users?page=$page");
    var resp = await http.get(url);

    Map<String, dynamic> data = jsonDecode(resp.body);
    List<ProfileModel> list;
    if (resp.statusCode == 200) {
      if (data['data'].isEmpty) throw EmptyException(message: "Data is empty");
      list = (data['data'] as List)
          .map((value) => ProfileModel.fromJson(value))
          .toList();
    } else if (resp.statusCode == 404) {
      throw EmptyException(message: "Data not found");
    } else {
      throw ServerException(message: "Server error");
    }
    return list;
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    Uri url = Uri.parse("https://reqres.in/api/users/$id");
    var resp = await http.get(url);

    Map<String, dynamic> data = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
    } else if (resp.statusCode == 401) {
      throw EmptyException(message: "Data not found");
    } else {
      throw ServerException(message: "Server error");
    }
    return ProfileModel.fromJson(data['data']);
  }
}
