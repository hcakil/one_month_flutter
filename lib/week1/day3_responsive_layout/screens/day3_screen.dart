import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/language_provider.dart';
import '../widgets/layout_builder_widgets.dart' hide AdaptiveNavigationCard;
import '../widgets/media_query_widgets.dart';
import '../widgets/adaptive_widgets.dart' as adaptive;
import '../widgets/mini_task_widgets.dart';
import '../widgets/best_practices_widgets.dart';

/// Main Day 3 screen with tabbed interface
class Day3ResponsiveLayoutScreen extends ConsumerStatefulWidget {
  const Day3ResponsiveLayoutScreen({super.key});

  @override
  ConsumerState<Day3ResponsiveLayoutScreen> createState() => _Day3ResponsiveLayoutScreenState();
}

class _Day3ResponsiveLayoutScreenState extends ConsumerState<Day3ResponsiveLayoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageNotifier = ref.read(languageProvider.notifier);
    final currentLocale = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Day 3: Responsive & Adaptive Layout'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
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
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.info), text: 'Overview'),
            Tab(icon: Icon(Icons.build), text: 'LayoutBuilder'),
            Tab(icon: Icon(Icons.phone_android), text: 'MediaQuery'),
            Tab(icon: Icon(Icons.auto_awesome), text: 'Adaptive'),
            Tab(icon: Icon(Icons.task), text: 'Mini Task'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildLayoutBuilderTab(),
          _buildMediaQueryTab(),
          _buildAdaptiveTab(),
          _buildMiniTaskTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(),
          const SizedBox(height: 16),
          const BestPracticesCard(),
          const SizedBox(height: 16),
          const ResponsiveApproachesCard(),
          const SizedBox(height: 16),
          const FlutterResponsiveWidgetsCard(),
          const SizedBox(height: 16),
          const ResponsivePatternsCard(),
          const SizedBox(height: 16),
          const TestingTipsCard(),
        ],
      ),
    );
  }

  Widget _buildLayoutBuilderTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          BasicLayoutBuilderCard(),
          SizedBox(height: 16),
          ResponsiveGridCard(),
          SizedBox(height: 16),
          ResponsiveCardLayoutCard(),
        ],
      ),
    );
  }

  Widget _buildMediaQueryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          MediaQueryInfoCard(),
          SizedBox(height: 16),
          OrientationAwareCard(),
          SizedBox(height: 16),
          SafeAreaDemoCard(),
          SizedBox(height: 16),
          TextScalingDemoCard(),
          SizedBox(height: 16),
          BreakpointVisualizerCard(),
        ],
      ),
    );
  }

  Widget _buildAdaptiveTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: [
          adaptive.AdaptiveWidgetsCard(),
          SizedBox(height: 16),
          adaptive.ImprovedResponsiveNavigationCard(),
          SizedBox(height: 16),
          adaptive.AdaptiveNavigationCard(),
          SizedBox(height: 16),
          adaptive.AdaptiveGridCard(),
        ],
      ),
    );
  }

  Widget _buildMiniTaskTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          ResponsiveMiniTaskCard(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.devices,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '🎯 Day 3: Responsive & Adaptive Layout',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to Day 3! Today we\'re exploring responsive and adaptive layout techniques in Flutter.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            _buildLearningObjectives(),
            const SizedBox(height: 16),
            _buildTabGuide(),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningObjectives() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📚 Learning Objectives',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          ...[
            'Master LayoutBuilder for constraint-based layouts (40 min)',
            'Understand MediaQuery for device information (40 min)',
            'Create adaptive widgets that respond to screen size (40 min)',
            'Build a complete responsive dashboard (Mini Task)',
            'Learn responsive design best practices',
          ].map((objective) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    objective,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTabGuide() {
    final tabs = [
      {
        'name': 'Overview',
        'icon': Icons.info,
        'description': 'Best practices, patterns, and responsive design principles',
      },
      {
        'name': 'LayoutBuilder',
        'icon': Icons.build,
        'description': 'Constraint-based layouts and responsive grids',
      },
      {
        'name': 'MediaQuery',
        'icon': Icons.phone_android,
        'description': 'Device information, orientation, and safe areas',
      },
      {
        'name': 'Adaptive',
        'icon': Icons.auto_awesome,
        'description': 'Platform-aware widgets and adaptive components',
      },
      {
        'name': 'Mini Task',
        'icon': Icons.task,
        'description': 'Complete responsive dashboard implementation',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🗂️ Tab Guide',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          ...tabs.map((tab) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  tab['icon'] as IconData,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tab['name'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                        ),
                      ),
                      Text(
                        tab['description'] as String,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondaryContainer.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
