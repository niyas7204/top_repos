import 'package:top_git/core/helpers/response_handler.dart';
import 'package:top_git/model/topratedmodel.dart';

abstract class GetRepoService {
  Future<StateResponse<TopRatedRepoModel>> getRepo(
      {required String date, required int itemCount, required int page});
}
