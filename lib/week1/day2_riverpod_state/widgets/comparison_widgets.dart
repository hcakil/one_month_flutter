import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StateManagementComparisonCard extends StatelessWidget {
  const StateManagementComparisonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '⚖️ State Management Comparison',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(
                color: Theme.of(context).colorScheme.outline.withAlpha(76),
              ),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
              },
              children: [
                _buildTableRow(['Feature', 'Riverpod', 'Provider', 'Bloc', 'GetX'], isHeader: true, context: context),
                _buildTableRow(['Type Safety', '✅', '❌', '✅', '❌'], context: context),
                _buildTableRow(['Performance', '✅', '⚠️', '✅', '✅'], context: context),
                _buildTableRow(['Learning Curve', '⚠️', '✅', '❌', '✅'], context: context),
                _buildTableRow(['Code Generation', '✅', '❌', '❌', '❌'], context: context),
                _buildTableRow(['Testing', '✅', '⚠️', '✅', '⚠️'], context: context),
                _buildTableRow(['Community', '⚠️', '✅', '✅', '✅'], context: context),
                _buildTableRow(['Bundle Size', '✅', '✅', '⚠️', '⚠️'], context: context),
                _buildTableRow(['Memory Usage', '✅', '⚠️', '✅', '⚠️'], context: context),
              ],
            ),
            const SizedBox(height: 16),
            _buildLegend(context),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false, required BuildContext context}) {
    return TableRow(
      decoration: isHeader
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            )
          : null,
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cell,
            style: isHeader
                ? Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                : Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Legend:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('✅ Excellent  ⚠️ Good  ❌ Limited'),
        ],
      ),
    );
  }
}

class ArchitecturalAdvantagesCard extends StatelessWidget {
  const ArchitecturalAdvantagesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🏗️ Riverpod\'s Architectural Advantages',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildAdvantageItem(
              Icons.security,
              'Compile-time Safety',
              'Provides type safety at compile time. Minimizes runtime errors.',
              Colors.green,
              context,
            ),
            _buildAdvantageItem(
              Icons.memory,
              'Memory Management',
              'Automatic disposal. Prevents memory leaks.',
              Colors.blue,
              context,
            ),
            _buildAdvantageItem(
              Icons.speed,
              'Performance',
              'Prevents unnecessary rebuilds. Only necessary widgets are updated.',
              Colors.orange,
              context,
            ),
            _buildAdvantageItem(
              Icons.bug_report,
              'Debugging',
              'Excellent debugging tools. You can monitor state with Provider Inspector.',
              Colors.purple,
              context,
            ),
            _buildAdvantageItem(
              Icons.code,
              'Code Generation',
              'Reduces boilerplate code with Riverpod Generator.',
              Colors.teal,
              context,
            ),
            _buildAdvantageItem(
              Icons.checklist,
              'Testability',
              'You can easily mock providers and test them.',
              Colors.red,
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvantageItem(IconData icon, String title, String description, Color color, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BestPracticesCard extends StatelessWidget {
  const BestPracticesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💡 Riverpod Best Practices',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildBestPracticeItem(
              '✅ Define providers globally',
              'Define providers at the top of the file, in global scope',
              context,
            ),
            _buildBestPracticeItem(
              '✅ Use StateNotifier',
              'Prefer StateNotifier for complex state logic',
              context,
            ),
            _buildBestPracticeItem(
              '✅ Handle async operations with AsyncValue',
              'Properly manage loading, error and success states',
              context,
            ),
            _buildBestPracticeItem(
              '✅ Compose providers',
              'Create large states by combining small providers',
              context,
            ),
            _buildBestPracticeItem(
              '✅ Know the difference between ref.watch() and ref.read()',
              'watch: for listening, read: for one-time reading',
              context,
            ),
            _buildBestPracticeItem(
              '✅ Use ProviderScope for testing',
              'You can override providers in tests',
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestPracticeItem(String title, String description, BuildContext context) {
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
} 