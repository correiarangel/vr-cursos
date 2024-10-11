import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vr_curso_app/app/core/shared/failures/sherad_preference_errors.dart';
import 'package:vr_curso_app/app/core/shared/services/shared_preferences/adapters/shared_params.dart';
import 'package:vr_curso_app/app/core/shared/services/shared_preferences/i_local_storage.dart';
import 'package:vr_curso_app/app/core/shared/services/shared_preferences/shared_preferences_service.dart';

void main() {
  late ILocalStorage sharedInterface;
  late SharedPreferences sharedPreferences;

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedInterface =
        SharedPreferencesService(sharedPreferences);
  });

  group('Group to enter the data', () {
    test('Must return true when entering a string', () async {
      //Arrange
      final params = SharedParams(key: 'string', value: 'ok');
      //act
      final result = await sharedInterface.setData(params: params);
      //expect
      expect(result, true);
       final result2 = await  sharedInterface.getData('string');
      expect(result2,'ok');
    });

    test('Must return true when entering a int', () async {
      //Arrange
      final params = SharedParams(key: 'int', value: 0);
      //act
      final result = await sharedInterface.setData(params: params);
      //expect
      expect(result, true);
      final resp = await sharedInterface.getData('int');
      expect(resp, 0);
    });

    test('Must return true when entering a double', () async {
      //Arrange
      final params = SharedParams(key: 'double', value: 2.5);
      //act
      final result = await sharedInterface.setData(params: params);
      //expect
      expect(result, true);
      final resp = await sharedInterface.getData('double');
      expect(resp, 2.5);
    });

    test('Must return true when entering a bool', () async {
      //Arrange
      final params = SharedParams(key: 'bool', value: true);
      //act
      final result = await sharedInterface.setData(params: params);
      //expect
      expect(result, true);
      final resp = await sharedInterface.getData('bool');
      expect(resp, true);
    });

    test('Must return true when entering a StringList', () async {
      //Arrange
      final List<String> list = ['a', 'b', 'c'];
      final params = SharedParams(key: 'StringList', value: list);
      //act
      final result = await sharedInterface.setData(params: params);
      //expect
      expect(result, true);
            final resp = await sharedInterface.getData('StringList');
      expect(resp, ['a', 'b', 'c']);
    });
  });

  group('Group to recover data', () {
    test('Must return the data type string passing the key', () async {
      //Arrange
      final params = SharedParams(key: 'string0', value: 'oi');
      //act
      await sharedInterface.setData(params: params);
      //act
      final result = await sharedInterface.getData('string0');
      //expect
      expect(result, 'oi');
    });

    test('Must return the data type int passing the key', () async {
      //Arrange
      final params = SharedParams(key: 'int0', value: 0);
      //act
      await sharedInterface.setData(params: params);
      //act
      final result = await sharedInterface.getData('int0');
      //expect
      expect(result, 0);
    });

    test('Must return the data type double passing the key', () async {
      //Arrange
      final params = SharedParams(key: 'double0', value: 2.5);
      //act
      await sharedInterface.setData(params: params);
      //act
      final result = await sharedInterface.getData('double0');
      //expect
      expect(result, 2.5);
    });

    test('Must return the data type bool passing the key', () async {
      //Arrange
      final params = SharedParams(key: 'bool0', value: true);
      //act
      await sharedInterface.setData(params: params);
      //act
      final result = await sharedInterface.getData('bool0');
      //expect
      expect(result, true);
    });

    test('Must return the data type StringList passing the key', () async {
      //Arrange
      final params = SharedParams(key: 'StringList0', value: ['a', 'b', 'c']);
      //act
      await sharedInterface.setData(params: params);
      //act
      final result = await sharedInterface.getData('StringList0');
      //expect
      expect(result, ['a', 'b', 'c']);
    });
  });

  test(
      'should return SharedPreferencesException when passing a non-existent key',
      () {
    //expect
    expect(() => sharedInterface.getData('asdasdasdsad'),
        throwsA(isA<SharedPreferencesException>()));
  });

  test('should return true when removing a record by key', () async {
    //Arrange
    final params = SharedParams(key: 'string0', value: 'oi');
    //act
    await sharedInterface.setData(params: params);
    final result = await sharedInterface.removeData('string0');
    //expect
    expect(result, true);
  });
}
