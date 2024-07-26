import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashStateInitial());

  initialState() {
    Future.delayed(const Duration(seconds: 3), () {
      print("object 🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍");
    });
  }
}
