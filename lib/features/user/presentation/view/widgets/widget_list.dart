import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../core/utils/helpers/empty_widget.dart';
import '../../../../../custom_widget/bloc/generic_bloc_builder.dart';
import '../../../data/models/user.dart';
import '../../view_models/controller.dart';
import 'list_user.dart';

class WidgetList extends StatelessWidget {
  const WidgetList({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericBlocBuilder<UserController, List<UserModle>>(
      bloc: KiwiContainer().resolve<UserController>()..getData(),
      emptyWidget: const EmptyWidget(message: "No user!"),
      onRetryPressed: () {},
      successWidget: (state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.data!.length ?? 0,
          itemBuilder: (_, index) {
            UserModle item = state.data![index];
            return ListUser(user: item);
          },
        );
      },
    );
  }
}
