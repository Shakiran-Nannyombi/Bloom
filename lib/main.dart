import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'router.dart';
import 'state/app_state.dart';
import 'theme/bloom_theme.dart';

void main() {
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  runApp(const BloomApp());
}

class BloomApp extends StatefulWidget {
  const BloomApp({super.key});

  @override
  State<BloomApp> createState() => _BloomAppState();
}

class _BloomAppState extends State<BloomApp> {
  late final BloomAppState _state = BloomAppState();
  late final _router = createRouter(_state);

  @override
  Widget build(BuildContext context) {
    return BloomScope(
      notifier: _state,
      child: ListenableBuilder(
        listenable: _state,
        builder: (context, _) {
          return MaterialApp.router(
            title: 'Bloom',
            debugShowCheckedModeBanner: false,
            theme: BloomTheme.light,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
