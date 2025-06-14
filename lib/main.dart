import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/generated/l10n/app_localizations.dart';
import 'localization/bloc/language_bloc.dart';
import 'localization/bloc/language_event.dart';
import 'localization/bloc/language_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(create: (context) => LanguageBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var locale = context.watch<LanguageBloc>().state.locale;

    return MaterialApp(
      locale: locale,
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('VIJAY\'s'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.translate),
            itemBuilder: (context) {
              var locale = <String>['en', 'hi'];
              return List.generate(
                locale.length,
                (index) => PopupMenuItem(
                  child: Text(locale[index]),
                  onTap: () {
                    context.read<LanguageBloc>().add(ChangeLanguageEvent(Locale(locale[index])));
                  },
                ),
              );
            },
          ),

          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return Text(state.locale.toString());
            },
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(AppLocalizations.of(context)!.changeLanguage.toString())],
        ),
      ),
    );
  }
}
