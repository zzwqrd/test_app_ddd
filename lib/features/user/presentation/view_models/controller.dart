import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/dialogs/error_alert_dialogue_widget.dart';
import '../../../../custom_widget/bloc/generic_bloc_state.dart';
import '../../data/models/user.dart';
import '../../domain/usecases/usecase_name.dart';

part 'state.dart';

class UserController extends Cubit<GenericBlocState<List<UserModle>>> {
  UserController() : super(GenericBlocState.empty());

  getData() async {
    emit(GenericBlocState.loading());

    final res = await ProductUseCaseImp().getData();

    res.fold((l) {
      showErrorDialogue(l.message!);
      emit(GenericBlocState.failure(l.message!));
    }, (r) {
      emit(GenericBlocState.success(r));
    });
  }
}
