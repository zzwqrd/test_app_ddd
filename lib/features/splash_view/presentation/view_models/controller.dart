import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/dialogs/error_alert_dialogue_widget.dart';
import '../../domain/usecases/usecase_name.dart';

part 'state.dart';

class SplashController extends Cubit<StateTest> {
  SplashController() : super(const StateTest(status: Status.initial));

  initialState() async {
    emit(state.copyWith(status: Status.start));

    final res = await ProductUseCaseImp().getData();

    res.fold((l) {
      if (l.statusCode == 404) {
        showErrorDialogue("not");
      } else {
        showErrorDialogue(l.message!);
      }
      emit(state.copyWith(status: Status.failed, error: l.message));
    }, (r) {
      emit(state.copyWith(status: Status.success, data: r));
    });
    // await Future.delayed(const Duration(seconds: 3), () {
    //   print("object 🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍");
    // });
  }
}
