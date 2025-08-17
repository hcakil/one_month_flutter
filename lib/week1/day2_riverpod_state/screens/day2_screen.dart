import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:one_month_flutter/providers/language_provider.dart';

import '../widgets/comparison_widgets.dart';
import '../widgets/counter_widgets.dart';
import '../widgets/user_preferences_widget.dart';

class Day2RiverpodStateScreen extends ConsumerStatefulWidget {
  const Day2RiverpodStateScreen({super.key});

  @override
  ConsumerState<Day2RiverpodStateScreen> createState() => _Day2RiverpodStateScreenState();
}

class _Day2RiverpodStateScreenState extends ConsumerState<Day2RiverpodStateScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: Text(l10n.day2Title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
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
          tabs: const [
            Tab(icon: Icon(Icons.info), text: 'Overview'),
            Tab(icon: Icon(Icons.add), text: 'Counter'),
            Tab(icon: Icon(Icons.cloud), text: 'Async'),
            Tab(icon: Icon(Icons.architecture), text: 'Architecture'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(l10n),
          _buildCounterTab(l10n),
          _buildAsyncTab(l10n),
          _buildArchitectureTab(l10n),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(l10n),
          const SizedBox(height: 16),
          _buildRiverpodBasicsCard(l10n),
          const SizedBox(height: 16),
          _buildProviderTypesCard(l10n),
          const SizedBox(height: 16),
          _buildTasksCard(l10n),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_tree,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Riverpod State Management',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(l10n.day2Description),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: const Text('StateNotifier'),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                Chip(
                  label: const Text('Provider'),
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
                Chip(
                  label: const Text('Consumer'),
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                Chip(
                  label: const Text('AsyncValue'),
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiverpodBasicsCard(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📚 Riverpod Basic Concepts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildConceptItem(
              icon: Icons.source,
              title: 'Provider',
              description: 'Data source. Accessible from anywhere in the application.',
              example: 'final counterProvider = StateProvider<int>((ref) => 0);',
            ),
            const SizedBox(height: 12),
            _buildConceptItem(
              icon: Icons.visibility,
              title: 'Consumer',
              description: 'Widget that listens to providers and updates the UI.',
              example: 'Consumer(builder: (context, ref, child) => Text(...));',
            ),
            const SizedBox(height: 12),
            _buildConceptItem(
              icon: Icons.notifications_active,
              title: 'StateNotifier',
              description: 'Class used for complex state logic.',
              example: 'class CounterNotifier extends StateNotifier<int>',
            ),
            const SizedBox(height: 12),
            _buildConceptItem(
              icon: Icons.sync,
              title: 'AsyncValue',
              description: 'Wrapper that manages loading, error and data states.',
              example: 'AsyncValue.when(data: (data) => ..., loading: () => ...)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptItem({
    required IconData icon,
    required String title,
    required String description,
    required String example,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withAlpha(76),
              ),
            ),
            child: Text(
              example,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderTypesCard(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔧 Provider Types',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildProviderTypeCard(
                    'Provider',
                    'Simple values',
                    Icons.data_object,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildProviderTypeCard(
                    'StateProvider',
                    'Mutable values',
                    Icons.edit,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildProviderTypeCard(
                    'FutureProvider',
                    'Async operations',
                    Icons.hourglass_empty,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildProviderTypeCard(
                    'StreamProvider',
                    'Data streams',
                    Icons.stream,
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderTypeCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(76)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCounterTab(AppLocalizations l10n) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleCounterCard(),
          SizedBox(height: 16),
          AsyncCounterCard(),
          SizedBox(height: 16),
          UserPreferencesCard(),
        ],
      ),
    );
  }

  Widget _buildAsyncTab(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAsyncPatternsCard(l10n),
          const SizedBox(height: 16),
          _buildErrorHandlingCard(l10n),
        ],
      ),
    );
  }

  Widget _buildAsyncPatternsCard(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔄 Async Patterns',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildCodeExample(
              'AsyncValue Usage',
              '''
// StateNotifier with async operations
class AsyncCounterNotifier extends StateNotifier<AsyncValue<int>> {
  AsyncCounterNotifier() : super(const AsyncValue.data(0));

  Future<void> incrementAsync() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncValue.data((state.value ?? 0) + 1);
  }

  Future<void> fetchRemoteCounter() async {
    state = const AsyncValue.loading();
    try {
      final remoteValue = await apiCall();
      state = AsyncValue.data(remoteValue);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}''',
            ),
            const SizedBox(height: 16),
            _buildCodeExample(
              'AsyncValue in UI',
              '''
Consumer(
  builder: (context, ref, child) {
    final asyncCount = ref.watch(asyncCounterProvider);
    
    return asyncCount.when(
      data: (count) => Text('Value: \$count'),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: \$error'),
    );
  },
)''',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorHandlingCard(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '⚠️ Error Handling Best Practices',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildBestPracticeItem(
              '✅ Use AsyncValue.when()',
              'Handle loading, error and data states separately',
            ),
            _buildBestPracticeItem(
              '✅ Use try-catch blocks',
              'Catch errors in StateNotifier and return AsyncValue.error',
            ),
            _buildBestPracticeItem(
              '✅ User-friendly error messages',
              'Show understandable error messages to users',
            ),
            _buildBestPracticeItem(
              '✅ Retry mechanisms',
              'Provide retry options for failed operations',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestPracticeItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
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

  Widget _buildArchitectureTab(AppLocalizations l10n) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArchitecturalAdvantagesCard(),
          SizedBox(height: 16),
          StateManagementComparisonCard(),
          SizedBox(height: 16),
          BestPracticesCard(),
        ],
      ),
    );
  }

  Widget _buildCodeExample(String title, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(76),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTasksCard(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day 2 Tasks',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildTaskItem('Study Riverpod.dev documentation', '30 min', true),
            _buildTaskItem('Create counter example with StateNotifierProvider', '40 min', true),
            _buildTaskItem('Mini task: Riverpod counter with async', '30 min', true),
            _buildTaskItem('Learn and apply architectural advantages', '20 min', false),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Congratulations! You have completed Day 2 tasks! 🎉'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Complete Day 2'),
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
            color: completed ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
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
