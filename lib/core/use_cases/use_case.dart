import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
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

class UpdateBeverageParams extends Equatable {
  final Beverage old;
  final String newCategoryName;
  final String newName;
  final int newColor;
  final double newAlcohol;

  const UpdateBeverageParams({
    @required this.old,
    @required this.newCategoryName,
    @required this.newName,
    @required this.newColor,
    @required this.newAlcohol,
  });

  @override
  List<Object> get props =>
      <Object>[old, newCategoryName, newName, newColor, newAlcohol];
}
