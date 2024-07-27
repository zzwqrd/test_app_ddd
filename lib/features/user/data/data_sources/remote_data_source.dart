import 'package:dartz/dartz.dart';

import '../../../../core/baseRepo/base_repo.dart';
import '../../../../core/network/api_config.dart';
import '../../../../core/network/exceptions/failures.dart';
import '../models/user.dart';

class RemoteDataSource extends NetworkService {
  Future<Either<Failure, List<UserModle>>> getProducts() async {
    return await exceptionHandler(
      () async {
        final result = await dioHelper.getRequest(
          // url: 'test404',
          url: ApiConfig.users,
        );
        List<UserModle> model = UserModle.fromJsonList(result.data);

        return model;
      },
    );
  }
}
