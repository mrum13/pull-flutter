import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh_app/user_model.dart';
import 'package:pull_to_refresh_app/user_services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void getUser({required String page}) async {
    try {
      emit(UserLoading());

      List<DataListUser> dataListUser =
          await UserServices().getDataUser(page: page);

      emit(UserSuccess(dataListUser));
    } catch (e) {
      emit(UserFailed(e.toString()));
    }
  }

}
