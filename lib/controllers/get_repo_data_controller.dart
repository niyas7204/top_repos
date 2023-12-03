import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:top_git/core/helpers/enums.dart';
import 'package:top_git/core/helpers/response_handler.dart';
import 'package:top_git/database/database_handler.dart';
import 'package:top_git/infrastructure/data_source/get_repo_implimentation.dart';
import 'package:top_git/infrastructure/repository/get_repo_interface.dart';
import 'package:top_git/model/repo_database_model.dart';
import 'package:top_git/model/state_model.dart';

class GetReposNotifier extends StateNotifier<StateModel> {
  final GetRepoService getRepoService;
  GetReposNotifier(this.getRepoService)
      : super(StateModel(null, StateResponse.initial()));
  // To set pagination from each call return 5 items;
  int itemCount = 5;
  int page = 0;
  Future<void> getRepo({required bool pagination}) async {
    pagination ? page += 1 : page = 1;

//set the state as loading when triger the call
    state = StateModel(state.wholeRepos, StateResponse.loading());
//fetch the current date and from it find day before 60 days
    DateTime currentDate = DateTime.now();
    DateTime fromDate = currentDate.subtract(const Duration(days: 60));
    //converting the date to string format
    String date = DateFormat('yyyy-MM-dd').format(fromDate);
//get the result server
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.none) {
      final result = await getRepoService.getRepo(
          date: date, itemCount: itemCount, page: page);
//clear the data base when the app opening

      if (page == 1) {
        await DataBaseHandler.instance.delete();
      }
      //add each item to the data base
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
    }

    //fetch all data from data base
    final repos = await DataBaseHandler.instance.getAllData();
//after sll set the state success and pass the data
    state = StateModel(
        repos,
        connectivity == ConnectivityResult.none
            ? StateResponse.error("Network not found")
            : StateResponse.success(repos));
  }
}

final getServiceprovider =
    Provider<GetRepoService>((ref) => GetRepoImplimentation());
final getRepoNotifier =
    StateNotifierProvider<GetReposNotifier, StateModel>((ref) {
  final getService = ref.read(getServiceprovider);
  return GetReposNotifier(getService);
});
