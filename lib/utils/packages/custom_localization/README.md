# Custom Localization

Using this package easily we can integrate internationalization in our flutter app.

## Getting Started

Add to your `pubspec.yaml`:

```yaml
dependencies:
  custom_localization: <last_version> / path
```

Create folder and add translation files like this

```
assets
└── languages
    ├── {languageCode}.{ext}                  //only language code
```

Example:

```
assets
└── languages
    ├── en.json
```

Declare your assets localization directory in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/languages/
```

## ⚠️ Note on **iOS**

For translation to work on **iOS** you need to add supported locales to 
`ios/Runner/Info.plist` as described [here](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#specifying-supportedlocales).

Example:

```xml
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
	<string>nb</string>
</array>
```
###  Setup app

Add Custom Localization widget like in example

```dart
 CustomLocalizationBuilder(
  delegate: CustomLocalizationDelegate(
      supportedLocales: [
        Locale('en'),
        Locale('es'),
      ],
      notFoundString: 'Localization not found',
      getPathFunction: filePathFunction
  ),
  builder: (context, localizationDelegate) => MaterialApp(
    title: 'CustomLocalization Demo',
    home: MyApp(),
    localizationsDelegates: localizationDelegate.localizationDelegates,
    supportedLocales: localizationDelegate.supportedLocales,
    localeResolutionCallback: localizationDelegate.localeResolutionCallback,
  ),
);
```
###  Custom localization builder properties

| Properties       | Required | Default                   | Description |
| ---------------- | -------- | ------------------------- | ----------- |
| delegate         | true     |                           | Custom delegate to handle localization component |
| builder          | true     |                           | Context builder. |

###  Custom localization delegate  properties
| Properties       | Required | Default                   | Description |
| ---------------- | -------- | ------------------------- | ----------- |
| supportedLocales | true     | '[Locale('en')]'          | List of supported locales. |
| getPathFunction  | false    | 'CustomLocalization.defaultGetPathFunction'| Path to your folder with localization files. |
| notFoundString   | false    |                           | The string to return if the key is not found. |
| locale           | false    |                           | Returns the locale when the locale is not in the list `supportedLocales`.|

## Usage

### Change or get locale

Custom localization uses extension methods [BuildContext] for access to locale.

It's more easiest way change locale .

Example:

```dart
context.changeLocale(Locale('en'));
```

### Translation on nested strings

We can nest translation strings as such :

```json
{
  "animals": {
    "dog": "Dog"
  }
}
```

And it can be access using `context.get('animals.dog')`.

### Translation format arguments

In your translation string, we may add arguments using `{}` :

```json
{
  "format": "Number of count is {count}"
}
```

we can then fill them with `context.get('format', {'count': '10'})`.
Also, instead of a map you can pass a list and get your arguments by their indexes.

### Change the files path

we can change from the default path of `assets/languages/$languageCode.json` by passing `getPathFunction`
to `CustomLocalizationDelegate`. We will then have to provide a valid asset path according to the specified locale.