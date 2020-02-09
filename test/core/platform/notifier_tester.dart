import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<R> expectNotifyListenerCalls<T extends ChangeNotifier, R>(
    T notifier,
    Future<R> Function() testFunction,
    Function(T) testValue,
    List<dynamic> matcherList) async {
  int i = 0;
  notifier.addListener(() {
    expect(testValue(notifier), matcherList[i]);
    i++;
  });
  final R result = await testFunction();
  expect(i, matcherList.length);
  return result;
}
