import 'package:flutter/material.dart';
import 'package:test_app_ddd/features/splash_view/presentation/view/view.dart';
import 'package:test_app_ddd/features/user/presentation/view/view.dart';

import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.i.splash;

  AppRoutes._internal();
  Map<String, Widget Function(BuildContext context)> appRoutes = {
    NamedRoutes.i.splash: (context) => const SplashView(),
    NamedRoutes.i.user: (context) => const UserView(),

    // NamedRoutes.i.tasks: (context) => TasksView(title: context.arg["title"]),
    // NamedRoutes.i.allProjects: (context) => const AllProjectsView(),
    // NamedRoutes.i.navbar: (context) => NavbarView(index: context.arg["index"]),
    // NamedRoutes.i.allFavKitchen: (context) => AllFavKitchenView(
    //     bloc: context.arg["bloc"], roomsBloc: context.arg["roomBloc"]),
    // NamedRoutes.i.projectDetails: (context) =>
    //     ProjectDetailsView(data: context.arg["data"]),
    // NamedRoutes.i.myRequests: (context) => const MyRequestsView(),
    // NamedRoutes.i.myReports: (context) => const MyReportsView(),
    // NamedRoutes.i.myAccount: (context) => const MyAccountView(),
    // NamedRoutes.i.myVaccations: (context) => const MyVaccationsView(),
    // NamedRoutes.i.myFines: (context) => const MyFinesView(),
    // NamedRoutes.i.myOvertime: (context) => const MyOvertimeView(),
    // NamedRoutes.i.allProducts: (context) => AllProducts(
    //     bloc: context.arg["bloc"],
    //     roomsBloc: context.arg["roomBloc"],
    //     kitchensBloc: context.arg["kitchensBloc"]),
    // NamedRoutes.i.success: (context) => SuccessView(
    //     title: context.arg["title"], subtitle: context.arg["subtitle"]),
  };
}
