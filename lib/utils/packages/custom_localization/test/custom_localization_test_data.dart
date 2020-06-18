
class LocalizationTestData {

  static Future<Map<String, dynamic>> content() => Future.value({
      'welcome': 'Welcome',
      'animals': {
        'dog': 'Dog',
        'elephant': 'Elephant',
      },
      'format': 'Number of count is {count}'
    });
}