# connectivity_widget

This plugin provide a widget and connectivity helper class. The widget shows the user if the device is connected to the internet or not.
Using Helper class we can check the device connectivity status and type of connection.

Internally we are using flutter connectivity package for checking connectivity status and also we checking internet connectivity is available
by pinging a google.com and verifying its response.

## Usage

### import the package
```dart
import 'package:connectivity_widget/connectivity_widget.dart';
```
### Using the ConnectivityWidget 

```dart
  ConnectivityWidget(
         child: Container(
           padding: EdgeInsets.all(16.0),
           child: Column(
             children: <Widget>[
               _buildTextFields(),
               _buildButtons(),
             ],
           ),
         ),
       ),
```

We can also customize the offlineWidget
1. Custom Height and Message

```dart
ConnectivityWidget(
         height: 150.0,
         message: "You are Offline!",
         child: Container(
         ),
       ),
```
2. Custom Decoration

```dart
ConnectivityWidget(
         decoration: BoxDecoration(
             color: Colors.red,
          ),
         child: Container(
         ),
       ),
```
3. Custom Alignment

```dart
ConnectivityWidget(
          alignment: Alignment.topCenter,
          child:
       )
```
4. We can provide our own custom Offline Widget also we can disable user interactions.
```dart
ConnectivityWidget(
        disableInteraction: true,
        offlineWidget: OfflineWidget(),
        child:       
)
```

### Using ConnectivityHelper we can check the connectivity type and internet availability. And also we can listen to network changes.

This library also provides access to the `ConnectivityHelper` class in which you can verify the status of the network.

```dart
import 'package:connectivity_widget/connectivity_helper.dart';
```

```dart
Stream<bool> ConnectivityHelper().isConnected // gets the internet connectivity is available or not.
Future<bool> ConnectivityHelper().connectivityType // gets the connectivity type
```

`ConnectivityHelper` also help us to listen the connection state change event.

```dart
ConnectivityHelper().connectionChange.listen(_updateConnectivity);

void _updateConnectivity(dynamic hasConnection) {
///Here we will get ConnectionResult model with connection type and internet availability status.
}}



```

