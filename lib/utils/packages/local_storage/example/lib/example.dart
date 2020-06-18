import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: RawMaterialButton(
          fillColor: Colors.blue,
          onPressed: () => accessPreference(),
          child: Text('Tap to play with shared preference'),
        ),
      ),
    );
  }

  /// Here we store and retrieve num, string and a list into shared preference.
  /// Examples of using [await] and [then] approach to handle shared pref asynchronous operation is shown below.
  accessPreference() async {
    /// A plain text is stores and retrieved.
    'Text to save'.putStringPreferenceValue(key: 'Keyss3').then((value) {
      print('Storage status is : $value');
      'Keyss3'
          .getStringPreferenceValue()
          .then((value) => print('The stored value is : $value'));
    });

    const appleKey = 'Jbbabgg';
    var isSuccess = await 'Apple'.putStringPreferenceValue(key: appleKey);
    if (isSuccess) {
      var apple = await appleKey.getStringPreferenceValue();
      print('The value for the key ($appleKey) is ($apple)');
    }

    /// Delete a value from shared pref.
    appleKey
        .deletePreferenceValue()
        .then((status) => print('delete status is $status'));

    /// An int value is stores and retrieved.
    20.putNumberPreferenceValue(key: 'Keyzzsss').then((value) async {
      print('int storage status is : $value');
      final intValue = await 'Keyzzsss'.getIntegerPreferenceValue();
      print(intValue);
    });

    /// An double value is stores and retrieved.
    222.678.putNumberPreferenceValue(key: 'KessDouble').then((value) async {
      print('int storage status is : $value');
      final doubleValue = await 'KessDouble'.getDoublePreferenceValue();
      print(doubleValue);
    });

    /// An flag value (bool) is stores and retrieved.
    await false.putBoolPreferenceValue(key: 'FLAG');
    final flag = await 'FLAG'.getBoolPreferenceValue();
    print('The flag status is $flag');

    /// Here we store and retrieve a List<String> value into the shared preference.
    await ['a', 'b', 'c'].putStringListPreferenceValue(key: 'LETTERS');
    final letters = await 'LETTERS'.getStringListPreferenceValue();
    print(letters);
  }
}
