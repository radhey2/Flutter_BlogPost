import 'dart:convert';

import 'package:blogpost/Auth/datasource/modal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('.fromJson', () {
      const jsonStr =
          '{ "email" : "abc@xyz.com", "first name" : "ABC", "last name" : "XYZ" }';
      final json = jsonDecode(jsonStr);

      expect(json,
          allOf([isNotNull, isA<Map<String, dynamic>>(), contains('email')]));
      final user = User.fromJson(json);

      expect(user.email, 'abc@xyz.com');
      expect(user.lastName, 'XYZ');

      final user2 = User.fromJson(json);

      expect(user, user2);
    });
  });
}
