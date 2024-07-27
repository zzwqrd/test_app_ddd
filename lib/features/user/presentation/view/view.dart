import 'package:flutter/material.dart';

import 'widgets/widget_list.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetList(),
    );
  }
}
