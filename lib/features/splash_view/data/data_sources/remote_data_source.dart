import 'package:dartz/dartz.dart';

import '../../../../core/baseRepo/base_repo.dart';
import '../../../../core/network/exceptions/failures.dart';
import '../models/model_name.dart';

class RemoteDataSource extends NetworkService {
  Future<Either<Failure, ProductModel>> getProducts() async {
    return await exceptionHandler(
      () async {
        final result = await dioHelper.getRequest(
          // url: 'test404',
          url: 'categoriesss',
        );
        ProductModel model = ProductModel.fromJson(result.data);

        return model;
      },
    );
  }
}
