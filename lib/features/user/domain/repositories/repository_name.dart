import 'package:dartz/dartz.dart';

import '../../../../core/network/exceptions/failures.dart';
import '../../data/models/user.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<UserModle>>> getData();
}
