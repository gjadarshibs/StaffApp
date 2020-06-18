# local_storage_package
A flutter package for handling local storage in a key value format.

## How to use this package ?
* Copy and paste the local storage package into your workspace.
* Mention the package in the pubspec.yaml file on your project. Refer the below snapshot 
```
local_storage_package:
    path: ‘package location’
```
* Import the local package into your project.  
````
import 'package:local_storage_package/local_storage_package.dart';
````


| DataType    | Store                                                               | Retrieve                                      |
| ----------- | --------------------------------------------------------------------| --------------------------------------------- |
| String      | await ‘data'.putStringPreferenceValue(key: key);                    | await key.getStringPreferenceValue();         |  
| Integer     | await 20.putNumberPreferenceValue(key: key);                        | await key.getIntegerPreferenceValue();        |  
| Double      | await 978.40.putNumberPreferenceValue(key: key);                    | await key.getDoublePreferenceValue();         |                                      |
| Bool        | await false.putBoolPreferenceValue(key: key);                       | await key.getBoolPreferenceValue();           |                                        | 
| List<String>| await ['A','B'].putStringListPreferenceValue                        | await 'LETTERS'.getStringListPreferenceValue()|                    |  |  

## Example

```
const appleKey = ‘Keyy6%%g’;
var isSuccess = await ‘string data to 	   store’.putStringPreferenceValue(key: appleKey);
if (isSuccess) {
  var apple = await appleKey.getStringPreferenceValue();
  print('The value for the key ($appleKey) is ($apple)');
}
```








