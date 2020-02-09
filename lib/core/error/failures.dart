import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  const Failure([this.properties = const <dynamic>[]]);

  final List<dynamic> properties;

  @override
  List<Object> get props => properties;
}

/// A Failure when there is no data in the database stored for the request.
class NoDataFailure extends Failure {}

class SqlFailure extends Failure {}

class ArgumentFailure extends Failure{}
