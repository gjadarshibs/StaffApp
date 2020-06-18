# global_theme
A common theme handler that load theme JSON and apply it to the Theme Data.

## What are the asset files needed ?
Presently we are loading multiple theme configuration files the assets and will be loaded and apply to the global ThemeData in the root material widget.

## How to add global theming ?

* Import the theme package into your project.  
````
import ‘package:global_theme/global_theme.dart’;
````
* Place the theme JSON files and the fonts under your project assets folder.
* Refer the below code snippet to avail configurable theme into your project. Wrap this with the MaterialApp in main.dart file and pass the JSON file path.
````
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc()
          ..add(ThemeUpdateEvent(
              themeJson: 'assets/configurations/theme_one.json')),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder:
_buildWithTheme));
}
  /// This widget is the root of your application.
  /// ThemeData will be configured based on the configuration json
received.
  ///
  /// [state] contains the reference to the configured ThemeData.
  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
        title: 'Flutter Demo',
   
 } }
theme: state.themeData,
home: MyHomePage(
  title: 'HOME',
));
````
## What should be the format of theme configuration JSON?
````
{
  "theme_configuration": {
    "color": {
      "auto_brightness": true,
      "primary_color": "#311B92",
      "accent_color": "#7E57C2",
      "app_bar_color": "#7B1FA2",
      "scaffold_background_color": "#F3E5F5"
    },
    "text_style": {
      "font_family": "Arimo",
      "heading": {
        "color": "#454545",
        "font_size": 25.0
      },
      "sub_heading": {
        "color": "#454545",
        "font_size": 20.0
}, "body": {
        "color": "#454545",
        "font_size": 17.0
      }
    },
    "decoration": {
      "rounded_edge": {
        "corner_radius": 10.0,
        "border_width": 3.0,
        "border_color": "#F807A6B",
        "color": "#f4829b2"
      },
      "image_backgrounded": {
"asset_location": "assets/images/background.png"
      }
} }
}
````
## How to add custom text styles and colors that can be accessed using Theme.of(context) ?
* Create a theme extension class and import it wherever needed to access those colors and text style elements.
* Here you can find the extension on TextTheme and ColorScheme

````
extension textStyles on TextTheme {
  TextStyle get captionText {
    return TextStyle(
        color: Colors.grey[700], fontSize: 12.0, fontWeight:
FontWeight.w400);
  }
}
extension customColors on ColorScheme {
  Color get logoColor => const Color(0xFFdc3545);
}
````

## How can I add ThemeData params which are not mentioned in the configuration JSON?
* Go to package lib/src/app_style/basic_theme.dart.
* Here you can find a global instance of ThemeData, into which the ThemeData params can be added.