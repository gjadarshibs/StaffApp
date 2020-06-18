# loading_indicator

Creates a Loading Indicator widget with a CircularProgressIndicator/gif view.

## Usage

### import the package
```dart
import 'package:loading_indicator/loading_indicator.dart';
```
### Using the loading indicator 

Create and initialise a LoadingIndicator Object

1. Initialise the LoadingIndicator Object

```dart
  final  loadingIndicator = LoadingIndicator();
```
2. By default it is a normal circular progress to show some message. 
If you would like to use it to show image/ gif then need to use different factory method LoadingIndicator.

```dart
// For normal Loading indicator
final loadingIndicator = LoadingIndicator(loadingMessage: 'Loading..',);
```

```dart
// For gif/image loading indicator
final loadingIndicator = LoadingIndicator.gifOrImage(gifOrImagePath: 'asset/images/ic_loading.gif',
loadingMessage: 'Loading..',);
```

3. Showing the loading indicator

Two different way we can show loading indicator

	a. Directly we can add loading indicator widget as child widget.
	b. We can show as dialogue box.

4. Hiding the loading indicator.

If we are adding as a child widget then replace with proper one else case just call loadingIndicator.hide() method.

| Attribute               | Type                           | Default                         |
| ------------------------| ------------------------------ | ------------------------------- | 
| loadingIndicatorPosition| LoadingIndicatorPosition(Enum) | LoadingIndicatorPosition.center | 
| backgroundColor         | Color                          | App theme color                 | 
| loadingMessage          | String                         | Nil                             | 
| valueColor              | Color                          | App theme accent color          | 
| messageTextStyle        | TextStyle                      | TextStyle(color: Colors.black, ontSize: 15)|
| gifOrImagePath          | String                         |                                 | 
