import 'package:bierzaehler/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => const <dynamic>[];
}

class CreateBeverageParams extends Equatable {
  const CreateBeverageParams({
    @required this.categoryName,
    @required this.name,
    @required this.color,
    @required this.alcohol,
  });

  final String categoryName;
  final String name;
  final int color;
  final double alcohol;

  @override
  List<Object> get props => <Object>[
        categoryName,
        name,
        color,
        alcohol,
      ];
}
