import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/language_provider.dart';
import '../widgets/seo_renderer_widgets.dart';
import '../widgets/route_title_widgets.dart';
import '../widgets/blog_meta_widgets.dart';
import '../widgets/notes_widgets.dart';
import '../utils/seo_utils.dart';

/// Main Day 5 screen with tabbed interface for SEO and metadata
class Day5SeoMetadataScreen extends ConsumerStatefulWidget {
  const Day5SeoMetadataScreen({super.key});

  @override
  ConsumerState<Day5SeoMetadataScreen> createState() => _Day5SeoMetadataScreenState();
}

class _Day5SeoMetadataScreenState extends ConsumerState<Day5SeoMetadataScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    
    // Update SEO metadata for Day 5
    final seoConfig = SeoUtils.getSeoConfigForRoute('/week1/day5');
    SeoUtils.updateMetaTags(seoConfig);
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
        title: const Text('Day 5: SEO & Web Metadata'),
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
            Tab(icon: Icon(Icons.search), text: 'SEO Renderer'),
            Tab(icon: Icon(Icons.route), text: 'Route Titles'),
            Tab(icon: Icon(Icons.article), text: 'Blog Meta'),
            Tab(icon: Icon(Icons.note_alt), text: 'Notes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildSeoRendererTab(),
          _buildRouteTitlesTab(),
          _buildBlogMetaTab(),
          _buildNotesTab(),
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
          _buildTasksCard(),
        ],
      ),
    );
  }

  Widget _buildSeoRendererTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SeoRendererOverviewCard(),
          SizedBox(height: 16),
          SeoConfigDemoCard(),
          SizedBox(height: 16),
          SeoTipsCard(),
        ],
      ),
    );
  }

  Widget _buildRouteTitlesTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          RouteTitleOverviewCard(),
          SizedBox(height: 16),
          RouteTitleDemoCard(),
          SizedBox(height: 16),
          TitleBestPracticesCard(),
        ],
      ),
    );
  }

  Widget _buildBlogMetaTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          BlogSeoGuideCard(),
          SizedBox(height: 16),
          BlogListCard(),
        ],
      ),
    );
  }

  Widget _buildNotesTab() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          NotesManagementCard(),
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
                  Icons.search,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '🔍 Day 5: SEO & Web Metadata',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to Day 5! Today we\'re diving into SEO (Search Engine Optimization) and metadata management for Flutter Web applications. Learn how to make your Flutter web apps discoverable by search engines and optimize for social media sharing.',
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
                    '🎯 Today\'s Focus: Making Your App Discoverable',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Master SEO techniques to ensure your Flutter Web applications rank well in search engines and look great when shared on social media.',
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
              '1. SEO Renderer (30 min)',
              'Understand how to implement SEO-friendly rendering for Flutter Web SPAs with meta tags and structured data.',
              Icons.search,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildObjectiveItem(
              '2. Route-Based Title Changing (30 min)',
              'Implement dynamic page title updates based on navigation routes for better indexing and user experience.',
              Icons.route,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildObjectiveItem(
              '3. Blog Page Meta Tags (30 min)',
              'Add comprehensive meta tags to blog posts including Open Graph and Twitter Cards for optimal social sharing.',
              Icons.article,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildObjectiveItem(
              '4. Note-Taking Feature (30 min)',
              'Build a practical note-taking system to document your SEO learnings and best practices.',
              Icons.note_alt,
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
                  style: Theme.of(context).textTheme.bodySmall,
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
        'description': 'Learning objectives, task overview, and SEO fundamentals',
      },
      {
        'name': 'SEO Renderer',
        'icon': Icons.search,
        'description': 'Interactive SEO configuration, validation, and best practices',
      },
      {
        'name': 'Route Titles',
        'icon': Icons.route,
        'description': 'Dynamic page title updates based on navigation routes',
      },
      {
        'name': 'Blog Meta',
        'icon': Icons.article,
        'description': 'Blog posts with complete meta tags and structured data',
      },
      {
        'name': 'Notes',
        'icon': Icons.note_alt,
        'description': 'Take and organize notes about your SEO learnings',
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

  Widget _buildTasksCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '✅ Day 5 Tasks',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildTaskItem('Explore SEO Renderer concepts and implementation', '30 min', true),
            _buildTaskItem('Practice route-based title updates', '30 min', true),
            _buildTaskItem('Add meta tags to blog posts', '30 min', true),
            _buildTaskItem('Create and organize learning notes', '30 min', true),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🎉 Congratulations! You\'ve completed Day 5!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.celebration),
                label: const Text('Complete Day 5'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(String task, String duration, bool completed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              task,
              style: TextStyle(
                decoration: completed ? TextDecoration.lineThrough : null,
                color: completed ? Theme.of(context).colorScheme.outline : null,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              duration,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

