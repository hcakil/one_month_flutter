import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'providers/language_provider.dart';
import 'week1/day1_flutter_updates.dart';
import 'week1/day2_riverpod_state.dart';
import 'week1/day3_responsive_layout.dart';
import 'week1/day4_web_performance.dart';
import 'week1/day5_seo_metadata.dart';
import 'week1/day6_mini_project_web.dart';

void main() {
  runApp(const ProviderScope(child: OneMonthFlutterApp()));
}

class OneMonthFlutterApp extends ConsumerWidget {
  const OneMonthFlutterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);

    return MaterialApp.router(
      title: '30-Day Flutter Development Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
      ],
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    // Week 1 Routes
    GoRoute(
      path: '/week1/day1',
      builder: (context, state) => const Day1FlutterUpdatesScreen(),
    ),
    GoRoute(
      path: '/week1/day2',
      builder: (context, state) => const Day2RiverpodStateScreen(),
    ),
    GoRoute(
      path: '/week1/day3',
      builder: (context, state) => const Day3ResponsiveLayoutScreen(),
    ),
    GoRoute(
      path: '/week1/day4',
      builder: (context, state) => const Day4WebPerformanceScreen(),
    ),
    GoRoute(
      path: '/week1/day5',
      builder: (context, state) => const Day5SeoMetadataScreen(),
    ),
    GoRoute(
      path: '/week1/day6',
      builder: (context, state) => const Day6MiniProjectWebScreen(),
    ),
  ],
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final languageNotifier = ref.read(languageProvider.notifier);
    final currentLocale = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Language toggle button
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            tooltip: l10n.changeLanguage,
            onSelected: (Locale locale) {
              languageNotifier.setLanguage(locale);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<Locale>(
                value: const Locale('en'),
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: currentLocale.languageCode == 'en'
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.english),
                  ],
                ),
              ),
              PopupMenuItem<Locale>(
                value: const Locale('tr'),
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: currentLocale.languageCode == 'tr'
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                    ),
                    const SizedBox(width: 8),
                    Text(l10n.turkish),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🎯 ${l10n.projectPurpose}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(l10n.projectDescription),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '🔵 ${l10n.week1Title}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildDayCard(
                    context,
                    day: 1,
                    title: l10n.day1Title,
                    description: l10n.day1Description,
                    route: '/week1/day1',
                    icon: Icons.update,
                  ),
                  _buildDayCard(
                    context,
                    day: 2,
                    title: l10n.day2Title,
                    description: l10n.day2Description,
                    route: '/week1/day2',
                    icon: Icons.account_tree,
                  ),
                  _buildDayCard(
                    context,
                    day: 3,
                    title: l10n.day3Title,
                    description: l10n.day3Description,
                    route: '/week1/day3',
                    icon: Icons.devices,
                  ),
                  _buildDayCard(
                    context,
                    day: 4,
                    title: l10n.day4Title,
                    description: l10n.day4Description,
                    route: '/week1/day4',
                    icon: Icons.speed,
                  ),
                  _buildDayCard(
                    context,
                    day: 5,
                    title: l10n.day5Title,
                    description: l10n.day5Description,
                    route: '/week1/day5',
                    icon: Icons.search,
                  ),
                  _buildDayCard(
                    context,
                    day: 6,
                    title: l10n.day6Title,
                    description: l10n.day6Description,
                    route: '/week1/day6',
                    icon: Icons.web,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(
    BuildContext context, {
    required int day,
    required String title,
    required String description,
    required String route,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => context.go(route),
      ),
    );
  }
}
