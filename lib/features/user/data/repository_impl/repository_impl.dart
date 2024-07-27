import 'package:dartz/dartz.dart';

import '../../../../core/network/exceptions/failures.dart';
import '../../domain/repositories/repository_name.dart';
import '../data_sources/remote_data_source.dart';
import '../models/user.dart';

class ProductRepositoryImp extends ProductRepository {
  final productEndPoint = RemoteDataSource();

  @override
  Future<Either<Failure, List<UserModle>>> getData() async {
    return await productEndPoint.getProducts();
  }
}
