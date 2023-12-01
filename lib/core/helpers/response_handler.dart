import 'package:top_git/core/helpers/enums.dart';

class StateResponse<T> {
  String? errorMessage;
  T? data;
  StateStatus? status;
  StateResponse({this.data, this.errorMessage, this.status});
  StateResponse.loading() : status = StateStatus.loading;
  StateResponse.initial() : status = StateStatus.initial;
  StateResponse.error(this.errorMessage) : status = StateStatus.error;
  StateResponse.success(this.data) : status = StateStatus.success;
}
