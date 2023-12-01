import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:top_git/core/helpers/response_handler.dart';
import 'package:top_git/database/database_handler.dart';
import 'package:top_git/infrastructure/data_source/get_repo_implimentation.dart';
import 'package:top_git/infrastructure/repository/get_repo_interface.dart';
import 'package:top_git/model/repo_database_model.dart';
import 'package:top_git/model/topratedmodel.dart';

class GetReposNotifier extends StateNotifier<StateResponse<DatabaseModelList>> {
  final GetRepoService getRepoService;
  GetReposNotifier(this.getRepoService) : super(StateResponse.initial());
  int itemCount = 0;
  int page = 0;
  Future<void> getRepo() async {
    itemCount += 5;
    page += 1;

    state = StateResponse.loading();
    DateTime currentDate = DateTime.now();
    DateTime fromDate = currentDate.subtract(const Duration(days: 60));
    String date = DateFormat('yyyy-MM-dd').format(fromDate);

    final result = await getRepoService.getRepo(
        date: date, itemCount: itemCount, page: page);
    log("data $date");
    log(result.data.toString());
    for (var element in result.data!.items) {
      DatabaseModel data = DatabaseModel(
          id: element.id,
          name: element.name,
          fullName: element.fullName,
          user: element.owner.user,
          avatarurl: element.owner.avatarUrl,
          description: element.description,
          stargazersCount: element.stargazersCount);
      await DataBaseHandler.instance.insertData(data: data);
    }
    final repos = await DataBaseHandler.instance.getAllData();

    log(result.toString());
    state = StateResponse.success(repos);
  }
}

final getServiceprovider =
    Provider<GetRepoService>((ref) => GetRepoImplimentation());
final getRepoNotifier =
    StateNotifierProvider<GetReposNotifier, StateResponse<DatabaseModelList>>(
        (ref) {
  final getService = ref.read(getServiceprovider);
  return GetReposNotifier(getService);
});
