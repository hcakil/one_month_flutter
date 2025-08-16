import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/language_provider.dart';

class Day1FlutterUpdatesScreen extends ConsumerStatefulWidget {
  const Day1FlutterUpdatesScreen({super.key});

  @override
  ConsumerState<Day1FlutterUpdatesScreen> createState() => _Day1FlutterUpdatesScreenState();
}

class _Day1FlutterUpdatesScreenState extends ConsumerState<Day1FlutterUpdatesScreen> with TickerProviderStateMixin {
  bool _isImpellerEnabled = true;
  int _selectedSegment = 0;
  late AnimationController _performanceController;
  late AnimationController _memoryController;
  late AnimationController _batteryController;
  late Animation<double> _performanceAnimation;
  late Animation<double> _memoryAnimation;
  late Animation<double> _batteryAnimation;

  @override
  void initState() {
    super.initState();
    _performanceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _memoryController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _batteryController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _performanceAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _performanceController, curve: Curves.easeOut),
    );
    _memoryAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _memoryController, curve: Curves.easeOut),
    );
    _batteryAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _batteryController, curve: Curves.easeOut),
    );

    // Start animations after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _performanceController.forward();
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      _memoryController.forward();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      _batteryController.forward();
    });
  }

  @override
  void dispose() {
    _performanceController.dispose();
    _memoryController.dispose();
    _batteryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageNotifier = ref.read(languageProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.day1Title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          // Language toggle button
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: l10n.changeLanguage,
            onPressed: () => languageNotifier.toggleLanguage(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(l10n),
            const SizedBox(height: 16),
            _buildMaterial3Section(l10n),
            const SizedBox(height: 16),
            _buildImpellerSection(l10n),
            const SizedBox(height: 16),
            _buildImpellerVsSkiaComparison(l10n),
            const SizedBox(height: 16),
            _buildNewFeaturesSection(l10n),
            const SizedBox(height: 16),
            _buildTasksSection(l10n),
          ],
        ),
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
                  Icons.update,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.flutterUpdatesTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(l10n.flutterUpdatesDescription),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: const Text('Material 3'),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                Chip(
                  label: const Text('Impeller'),
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
                Chip(
                  label: Text(l10n.webPerformanceImprovements),
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterial3Section(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎨 ${l10n.material3Components}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // Buttons Section
            Text(
              l10n.buttons,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.filledButtonClicked)),
                    );
                  },
                  child: const Text('FilledButton'),
                ),
                FilledButton.tonal(
                  onPressed: () {},
                  child: const Text('FilledButton.tonal'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('OutlinedButton'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('TextButton'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Segmented Button
            Text(
              l10n.segmentedButton,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: [
                ButtonSegment<int>(
                  value: 0,
                  label: Text(l10n.day),
                  icon: const Icon(Icons.calendar_today),
                ),
                ButtonSegment<int>(
                  value: 1,
                  label: Text(l10n.week),
                  icon: const Icon(Icons.date_range),
                ),
                ButtonSegment<int>(
                  value: 2,
                  label: Text(l10n.month),
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
              selected: {_selectedSegment},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() {
                  _selectedSegment = newSelection.first;
                });
              },
            ),

            const SizedBox(height: 16),

            // Cards and Containers
            Text(
              l10n.cardsContainers,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Card.filled(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 8),
                          Text(l10n.filledCard),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(height: 8),
                          Text(l10n.outlinedCard),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpellerSection(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '⚡ ${l10n.impellerRenderingEngine}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(l10n.impellerDescription),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(l10n.impellerActive),
              subtitle: Text(l10n.renderingEngineSelection),
              value: _isImpellerEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isImpellerEnabled = value;
                });
                // Restart animations when engine changes
                _performanceController.reset();
                _memoryController.reset();
                _batteryController.reset();
                Future.delayed(const Duration(milliseconds: 200), () {
                  _performanceController.forward();
                  _memoryController.forward();
                  _batteryController.forward();
                });
              },
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isImpellerEnabled
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _isImpellerEnabled ? Icons.rocket_launch : Icons.warning,
                    color: _isImpellerEnabled
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _isImpellerEnabled ? l10n.impellerActiveStatus : l10n.skiaOldEngine,
                      style: TextStyle(
                        color: _isImpellerEnabled
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onErrorContainer,
                      ),
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

  Widget _buildImpellerVsSkiaComparison(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📊 ${l10n.impellerVsSkia}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              '${l10n.currentEngine}: ${_isImpellerEnabled ? "Impeller" : "Skia"}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),

            // Performance Comparison Charts
            _buildPerformanceBar(
              l10n.performance,
              _performanceAnimation,
              _isImpellerEnabled ? 0.9 : 0.6,
              Icons.speed,
            ),
            const SizedBox(height: 12),
            _buildPerformanceBar(
              l10n.memoryUsage,
              _memoryAnimation,
              _isImpellerEnabled ? 0.7 : 0.9,
              Icons.memory,
              isInverted: true, // Lower is better for memory usage
            ),
            const SizedBox(height: 12),
            _buildPerformanceBar(
              l10n.batteryLife,
              _batteryAnimation,
              _isImpellerEnabled ? 0.85 : 0.65,
              Icons.battery_full,
            ),
            const SizedBox(height: 12),
            _buildPerformanceBar(
              l10n.animationSmoothness,
              _performanceAnimation,
              _isImpellerEnabled ? 0.95 : 0.7,
              Icons.animation,
            ),

            const SizedBox(height: 16),

            // Visual comparison
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _isImpellerEnabled
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.outline,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.rocket_launch,
                            color: _isImpellerEnabled
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Impeller',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _isImpellerEnabled ? '✅ Active' : '⚪ Inactive',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Text('VS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: !_isImpellerEnabled
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.outline,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.settings,
                            color: !_isImpellerEnabled
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Skia',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          !_isImpellerEnabled ? '✅ Active' : '⚪ Inactive',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
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

  Widget _buildPerformanceBar(
    String label,
    Animation<double> animation,
    double value,
    IconData icon, {
    bool isInverted = false,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final animatedValue = animation.value * value;
        final displayValue = isInverted ? 1 - animatedValue : animatedValue;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16),
                const SizedBox(width: 8),
                Text(label, style: const TextStyle(fontSize: 14)),
                const Spacer(),
                Text(
                  '${(displayValue * 100).round()}%',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline.withAlpha(2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: displayValue,
                child: Container(
                  decoration: BoxDecoration(
                    color: displayValue > 0.8
                        ? Colors.green
                        : displayValue > 0.6
                            ? Colors.orange
                            : Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNewFeaturesSection(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🆕 ${l10n.otherNewFeatures}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(
              icon: Icons.web,
              title: l10n.webPerformanceImprovements,
              description: l10n.webPerformanceDescription,
            ),
            _buildFeatureItem(
              icon: Icons.security,
              title: l10n.securityUpdates,
              description: l10n.securityDescription,
            ),
            _buildFeatureItem(
              icon: Icons.developer_mode,
              title: l10n.developerExperience,
              description: l10n.developerDescription,
            ),
            _buildFeatureItem(
              icon: Icons.mobile_friendly,
              title: l10n.platformIntegration,
              description: l10n.platformDescription,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
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

  Widget _buildTasksSection(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '✅ ${l10n.day1Tasks}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildTaskItem(
              task: l10n.task1,
              duration: '20 dk',
              completed: true,
            ),
            _buildTaskItem(
              task: l10n.task2,
              duration: '40 dk',
              completed: true,
            ),
            _buildTaskItem(
              task: l10n.task3,
              duration: '30 dk',
              completed: false,
            ),
            _buildTaskItem(
              task: l10n.task4,
              duration: '30 dk',
              completed: false,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.congratulationsMessage),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle),
                label: Text(l10n.completeDay1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem({
    required String task,
    required String duration,
    required bool completed,
  }) {
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
