
# APIHandler

Simple wrapper classes to ease interaction with REST API.

## How to use

Import the package in your dart file

```dart
import 'package:api_handler/api_handler.dart';
```
Create a custom extension for ApiHandler

Get method
```dart
final response = await requestWith(type: RequestType.get, path:"movie/popular", queryParameter: queryParameter);
```

This is actually one form of making requests. Its full definition looks like this: 

```dart

Future<ApiResponse> requestWith({String path,
  RequestType type = RequestType.get,
  Map<String, String> headers,
  Map<String, dynamic> queryParameter,
  body,
  Encoding encoding,
  Duration timeLimit = const Duration(seconds: 60),
  OnTimeout onTimeout}) async {
```

| Attribute         | Type                  | Default                   |
| ----------------  | --------------------- | ------------------------- | 
| path              | String                |                           | 
| type              | RequestType           | RequestType.get           | 
| headers           | Map<String, String>   |                           | 
| queryParameter    | Map<String, dynamic>  |                           | 
| body              | Map                   |                           |
| encoding          | encoding              |                           | 
| timeLimit         | Duration              |   Duration(seconds: 60)   | 