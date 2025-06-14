# Flutter Localization Guide with Bloc

## Overview
In this guide, we will learn a simple and effective way to support multiple languages in a Flutter app. I have used the **Bloc pattern** here to make it easy to dynamically change and manage the language. This will help you understand how to handle text resources using `.arb` files, and how the user interface updates when the language changes.

---

## 1. Project Setup

First, you need to add necessary dependencies in your `pubspec.yaml`. This project includes the following packages:

- `flutter_localizations`: For Flutter's localization features
- `intl`: For internationalization
- `bloc` & `flutter_bloc`: For state management to handle language changes

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: any
  bloc: ^8.1.2
  flutter_bloc: ^8.1.3
```

---

## 2. Localization Configuration (l10n.yaml)

This file sets up localization generation. Here you define the folder path of `.arb` files, the template language file, and the location of the generated Dart localization file.

```yaml
arb-dir: lib/config/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
output-dir: lib/config/generated/l10n
synthetic-package: false
```

---

## 3. Language Resource Files (`.arb`)

`.arb` files are basically JSON format files that store app text for each language.

### English (`app_en.arb`)
```json
{
  "@@locale": "en",
  "appTitle": "My App",
  "changeLanguage": "Change Language"
}
```

### Hindi (`app_hi.arb`)
```json
{
  "@@locale": "hi",
  "appTitle": "मेरा ऐप",
  "changeLanguage": "भाषा बदलें"
}
```

---

## 4. Bloc-based Language Management

### Language State
This class represents the current language of the app.

```dart
class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState(this.locale);

  @override
  List<Object?> get props => [locale];
}
```

### Language Events
Here we define the events that can happen in the app. We only have `ChangeLanguageEvent` which comes with the new locale.

```dart
sealed class LanguageEvent extends Equatable {}

final class ChangeLanguageEvent extends LanguageEvent {
  final Locale local;
  ChangeLanguageEvent(this.local);

  @override
  List<Object?> get props => [local];
}
```

### Language Bloc
The bloc listens to events and updates the state. When the user changes the language, it emits the new locale which updates the UI.

```dart
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(Locale('en'))) {
    on<ChangeLanguageEvent>((event, emit) => emit(LanguageState(event.local)));
  }
}
```

---

## 5. Main App Code

Here we provide the `LanguageBloc` at the root of the app. The `locale` of `MaterialApp` is set from the bloc's current state, which makes the app language update immediately in the UI.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = context.watch<LanguageBloc>().state.locale;

    return MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

---

## 6. UI with Language Switcher

A `PopupMenuButton` is added in the AppBar that shows available languages. When the user clicks on a language, a `ChangeLanguageEvent` is dispatched and the app immediately switches to that language.

```dart
PopupMenuButton(
  icon: Icon(Icons.translate),
  itemBuilder: (context) {
    var localeList = ['en', 'hi'];
    return localeList.map((lang) {
      return PopupMenuItem(
        child: Text(lang),
        onTap: () {
          context.read<LanguageBloc>().add(ChangeLanguageEvent(Locale(lang)));
        },
      );
    }).toList();
  },
),
```

---

## Summary

- Flutter localization uses `.arb` files to manage language resources.
- Bloc pattern makes it very convenient to handle language change state.
- Dynamically setting `MaterialApp`'s `locale` from bloc state instantly updates the UI.
- A user-friendly language switcher UI is created to make language change easy.

With this approach, your app can efficiently support multiple languages and adding new languages in the future becomes straightforward.

---

### If you found this guide useful, please like/share! 😊
