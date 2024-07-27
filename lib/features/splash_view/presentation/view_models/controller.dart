import 'package:bloc/bloc.dart';
import 'package:test_app_ddd/core/utils/helpers/route.dart';

import '../../../../core/routes/routes.dart';

part 'state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashStateInitial());

  initialState() async {
    await Future.delayed(const Duration(seconds: 3), () {
      pushAndRemoveUntil(NamedRoutes.i.user, type: NavigatorAnimation.scale);
      print("object 🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍🧟‍");
    });
  }
}
