import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:top_git/core/helpers/response_handler.dart';
import 'package:top_git/core/urls.dart';
import 'package:top_git/infrastructure/repository/get_repo_interface.dart';
import 'package:top_git/model/topratedmodel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class GetRepoImplimentation implements GetRepoService {
  @override
  Future<StateResponse<TopRatedRepoModel>> getRepo(
      {required String date, required int itemCount, required int page}) async {
    final dio = Dio();
    String url = GetRepoUrl(
            date: date, itemCount: itemCount.toString(), page: page.toString())
        .getRepoUrl;

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = TopRatedRepoModel.fromJson(response.data);
        return StateResponse.success(data);
      }
    } on SocketException {
      log("not network");
      return StateResponse.error("Network not found");
    } catch (e) {
      return StateResponse.error("api call failed");
    }
    throw UnimplementedError();
  }
}
