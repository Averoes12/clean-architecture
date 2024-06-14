import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/profile/data/datasources/remote.dart';
import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<ProfileRemote>(), MockSpec<http.Client>()])
import 'remote_datasource_test.mocks.dart';

void main() {
  // Create mock object.
  int id = 1;
  int page = 1;
  MockProfileRemote profileRemote = MockProfileRemote();
  MockClient mockClient = MockClient();
  Uri urlGetAllUser = Uri.parse("https://reqres.in/api/users?page=$page");
  Uri urlGetUser = Uri.parse("https://reqres.in/api/users/$id");

  Map<String, dynamic> fakeJson = {
    "id": 1,
    "email": "michael.lawson@reqres.in",
    "first_name": "Michael",
    "last_name": "Lawson",
    "avatar": "https://reqres.in/img/faces/7-image.jpg"
  };

  ProfileModel mockProfile = ProfileModel.fromJson(fakeJson);

  group("Profile Remote Datasource", () {
    group("getUser() ", () {
      test("BERHASIL", () async {
        when(profileRemote.getUser(id)).thenAnswer((_) async => mockProfile);

        try {
          var response = await profileRemote.getUser(id);
          expect(response, mockProfile);
        } catch (e) {
          fail("IMPOSSIBLE");
        }
      });

      test("GAGAL", () async {
        when(profileRemote.getUser(id)).thenThrow(Exception());
        try {
          var response = await profileRemote.getUser(id);
          fail("IMPOSSIBLE");
        } catch (e) {
          expect(e, isException);
        }
      });
    });

    group("getAllUser()", () {
      test("BERHASIL (200)", () async {
        when(mockClient.get(urlGetAllUser))
            .thenAnswer((_) async => http.Response(
                jsonEncode({
                  "data": [fakeJson]
                }),
                200));

        try {
          var response = await profileRemote.getAllUser(page);
          expect(response, [mockProfile]);
        } catch (e) {
          fail("IMPOSSIBLE");
        }
      });

      test("GAGAL EMPTY DATA", () async {
        when(mockClient.get(urlGetAllUser)).thenAnswer(
            (_) async => http.Response(jsonEncode({"data": []}), 200));
        try {
          var response = await profileRemote.getAllUser(page);
        } on EmptyException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail("IMPOSSIBLE");
        }
      });
      test("GAGAL (404)", () async {
        when(mockClient.get(urlGetAllUser))
            .thenAnswer((_) async => http.Response(
                jsonEncode({
                  "data": [fakeJson]
                }),
                404));
        try {
          var response = await profileRemote.getAllUser(page);
          fail("IMPOSSIBLE");
        } on EmptyException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail("IMPOSSIBLE");
        }
      });

      test("GAGAL (500)", () async {
        when(mockClient.get(urlGetAllUser))
            .thenAnswer((_) async => http.Response(
                jsonEncode({
                  "data": [fakeJson]
                }),
                500));
        try {
          var response = await profileRemote.getAllUser(page);
          fail("IMPOSSIBLE");
        } on ServerException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail("IMPOSSIBLE");
        }
      });
    });
  });
}
