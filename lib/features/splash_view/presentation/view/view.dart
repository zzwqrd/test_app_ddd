import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../view_models/controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: KiwiContainer().resolve<SplashController>()..initialState(),
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: Text("SplashView"),
          ),
        );
      },
    );
  }
}
