import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:dartz/dartz.dart';

abstract class BeverageRepository {
  Future<Either<Failure, List<Beverage>>> getAllBeverages();
}

extension TaskX<T extends Either<Object, dynamic>> on Task<T> {
  Task<Either<Failure, A>> mapLeftToFailure<A>() {
    return map<Either<Failure, A>>((Either<Object, dynamic> either) =>
        either.fold<Either<Failure, A>>((Object obj) {
          try {
            return Left<Failure, A>(obj as Failure);
          } catch (e) {
            throw obj;
          }
        }, (dynamic u) {
          try {
            return Right<Failure, A>(u as A);
          } catch (e) {
            throw u;
          }
        }));
  }
}
