import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'state.dart';

class ControllerCubit extends Cubit<SplashState> {
  ControllerCubit() : super(SplashStateInitial());
}
