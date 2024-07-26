import 'package:kiwi/kiwi.dart';

import 'features/splash_view/presentation/view_models/controller.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();
  container.registerFactory((c) => SplashController());
  // container.registerFactory((c) => ProductController());
  // container.registerFactory((c) => DeleteController());
  // container.registerFactory((c) => DataCubitFreezedEnum());
  // container.registerFactory((c) => GetDataTestCubit());
}
