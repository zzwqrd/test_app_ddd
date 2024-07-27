import 'package:dartz/dartz.dart';

import '../../../../core/network/exceptions/failures.dart';
import '../../data/models/model_name.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductModel>> getData();
}
