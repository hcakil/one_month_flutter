import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/language_provider.dart';
import '../widgets/deferred_components_widgets.dart';
import '../widgets/renderer_comparison_widgets.dart';
import '../widgets/renderer_switcher_widget.dart';
import '../widgets/webp_optimization_widgets.dart';
import '../widgets/lazy_loading_widgets.dart';
import '../utils/web_performance_utils.dart';

/// Main Day 4 screen with tabbed interface for web performance optimization
class Day4WebPerformanceScreen extends ConsumerStatefulWidget {
  const Day4WebPerformanceScreen({super.key});

  @override
  ConsumerState<Day4WebPerformanceScreen> createState() => _Day4WebPerformanceScreenState();
}

class _Day4WebPerformanceScreenState extends ConsumerState<Day4WebPerformanceScreen>
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
        title: const Text('Day 4: Web Performance Optimization'),
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
            Tab(icon: Icon(Icons.schedule), text: 'Deferred Components'),
            Tab(icon: Icon(Icons.compare), text: 'Renderer Comparison'),
            Tab(icon: Icon(Icons.image), text: 'WebP Optimization'),
            Tab(icon: Icon(Icons.hourglass_empty), text: 'Lazy Loading'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildDeferredComponentsTab(),
          _buildRendererComparisonTab(),
          _buildWebPOptimizationTab(),
          _buildLazyLoadingTab(),
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
          _buildLearningObjectivesCard(),
          const SizedBox(height: 16),
          _buildTabGuideCard(),
          const SizedBox(height: 16),
          _buildOptimizationTipsCard(),
        ],
      ),
    );
  }

  Widget _buildDeferredComponentsTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          DeferredComponentsOverviewCard(),
          SizedBox(height: 16),
          DeferredLoadingDemoCard(),
          SizedBox(height: 16),
          BundleSizeComparisonCard(),
        ],
      ),
    );
  }

  Widget _buildRendererComparisonTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          RendererSwitcherWidget(),
          SizedBox(height: 16),
          RendererComparisonCard(),
        ],
      ),
    );
  }

  Widget _buildWebPOptimizationTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          WebPOptimizationCard(),
          SizedBox(height: 16),
          ImageOptimizationCalculatorCard(),
          SizedBox(height: 16),
          WebPImplementationGuideCard(),
        ],
      ),
    );
  }

  Widget _buildLazyLoadingTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          LazyLoadingOverviewCard(),
          SizedBox(height: 16),
          LazyImageLoadingDemoCard(),
          SizedBox(height: 16),
          LazyComponentLoadingDemoCard(),
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
                  Icons.speed,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '🚀 Day 4: Web Performance Optimization',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to Day 4! Today we\'re focusing on optimizing Flutter web applications for better performance, faster loading times, and improved user experience.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎯 Today\'s Focus: Web Performance',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Learn essential techniques to make your Flutter web apps load faster and perform better for users worldwide.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningObjectivesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📚 Learning Objectives',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildObjectiveItem(
              '1. Deferred Components (30 min)',
              'Learn to split your app into smaller chunks that load on-demand, reducing initial bundle size and improving startup performance.',
              Icons.schedule,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildObjectiveItem(
              '2. CanvasKit vs HTML Renderer (30 min)',
              'Understand the differences between Flutter\'s two web renderers and choose the right one for your use case.',
              Icons.compare,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildObjectiveItem(
              '3. Image WebP Optimization (30 min)',
              'Optimize your images using WebP format for better compression and faster loading without quality loss.',
              Icons.image,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildObjectiveItem(
              '4. Lazy Loading Implementation (30 min)',
              'Implement lazy loading for images and components to improve perceived performance and reduce bandwidth usage.',
              Icons.hourglass_empty,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildObjectiveItem(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabGuideCard() {
    final tabs = [
      {
        'name': 'Overview',
        'icon': Icons.info,
        'description': 'Learning objectives, optimization tips, and performance best practices',
      },
      {
        'name': 'Deferred Components',
        'icon': Icons.schedule,
        'description': 'Code splitting, bundle size optimization, and progressive loading',
      },
      {
        'name': 'Renderer Comparison',
        'icon': Icons.compare,
        'description': 'CanvasKit vs HTML renderer performance testing and comparison',
      },
      {
        'name': 'WebP Optimization',
        'icon': Icons.image,
        'description': 'Image format optimization, compression calculator, and implementation guide',
      },
      {
        'name': 'Lazy Loading',
        'icon': Icons.hourglass_empty,
        'description': 'Progressive content loading, image lazy loading, and component deferring',
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🗂️ Tab Navigation Guide',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...tabs.map((tab) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    tab['icon'] as IconData,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tab['name'] as String,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          tab['description'] as String,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
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
      ),
    );
  }

  Widget _buildOptimizationTipsCard() {
    final tips = WebPerformanceUtils.getOptimizationTips();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💡 Performance Optimization Tips',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...tips.map((tip) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            tip['title']!,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            _buildImpactChip(tip['impact']!),
                            const SizedBox(width: 8),
                            _buildDifficultyChip(tip['difficulty']!),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tip['description']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactChip(String impact) {
    Color color;
    switch (impact.toLowerCase()) {
      case 'high':
        color = Colors.red;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      case 'low':
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Impact: $impact',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    Color color;
    switch (difficulty.toLowerCase()) {
      case 'high':
        color = Colors.red;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      case 'low':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Difficulty: $difficulty',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

