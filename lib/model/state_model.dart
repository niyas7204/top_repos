import 'package:top_git/core/helpers/enums.dart';
import 'package:top_git/core/helpers/response_handler.dart';
import 'package:top_git/model/repo_database_model.dart';

class StateModel {
  DatabaseModelList? wholeRepos;
  StateResponse<DatabaseModelList>? status;
  StateModel(this.wholeRepos, this.status);
}
