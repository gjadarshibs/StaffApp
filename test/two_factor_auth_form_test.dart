import 'package:flutter_test/flutter_test.dart';
import 'package:ifly_corporate_app/presentation/pages/two_factor_validation/widgets/two_factor_auth_form.dart';

void main() {
  
  group('OTP Validation', () {
    test('OTP having less than 4 digits', () {
      String result = OTPFieldValidation.validate('213');
      expect(result, 'Enter the full OTP Digits');
    });

    test('OTP having 4 digits', () {
      String result = OTPFieldValidation.validate('2137');
      expect(result, null);
    });
  });
}