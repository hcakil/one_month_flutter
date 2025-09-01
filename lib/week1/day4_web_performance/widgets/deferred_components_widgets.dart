import 'package:flutter/material.dart';
import '../utils/web_performance_utils.dart';

/// Card explaining deferred components concept
class DeferredComponentsOverviewCard extends StatelessWidget {
  const DeferredComponentsOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '🚀 Deferred Components (30 min)',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Deferred components allow you to split your Flutter web app into smaller chunks that are loaded on-demand, reducing initial bundle size and improving startup performance.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _buildBenefitsSection(context),
            const SizedBox(height: 16),
            _buildImplementationTips(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitsSection(BuildContext context) {
    final benefits = [
      'Reduced initial bundle size',
      'Faster app startup',
      'Better perceived performance',
      'Improved Core Web Vitals scores',
      'Reduced memory usage',
    ];

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
            '✅ Benefits',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          ...benefits.map((benefit) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    benefit,
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

  Widget _buildImplementationTips(BuildContext context) {
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
            '💡 Implementation Tips',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '• Use deferred imports: import \'package:my_app/feature.dart\' deferred as feature;\n'
            '• Load components when needed: await feature.loadLibrary();\n'
            '• Show loading indicators during deferred loading\n'
            '• Consider user interaction patterns for optimal loading\n'
            '• Monitor bundle sizes and loading performance',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

/// Interactive deferred loading demo
class DeferredLoadingDemoCard extends StatefulWidget {
  const DeferredLoadingDemoCard({super.key});

  @override
  State<DeferredLoadingDemoCard> createState() => _DeferredLoadingDemoCardState();
}

class _DeferredLoadingDemoCardState extends State<DeferredLoadingDemoCard> {
  final LazyLoadingController _controller = LazyLoadingController();
  final List<String> _componentIds = [
    'advanced_chart',
    'image_gallery',
    'video_player',
    'data_table',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.play_circle_filled,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Interactive Deferred Loading Demo',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Click on components below to simulate deferred loading. Notice the loading states and progressive enhancement.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            _buildProgressIndicator(),
            const SizedBox(height: 20),
            _buildComponentGrid(),
            const SizedBox(height: 20),
            _buildResetButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 100)),
      builder: (context, snapshot) {
        final progress = _controller.getLoadingProgress(_componentIds);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Loading Progress',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildComponentGrid() {
    final components = [
      {
        'id': 'advanced_chart',
        'title': 'Advanced Chart',
        'description': 'Complex data visualization component',
        'icon': Icons.bar_chart,
        'size': '~150KB',
      },
      {
        'id': 'image_gallery',
        'title': 'Image Gallery',
        'description': 'Rich media gallery with zoom',
        'icon': Icons.photo_library,
        'size': '~200KB',
      },
      {
        'id': 'video_player',
        'title': 'Video Player',
        'description': 'Full-featured video player',
        'icon': Icons.video_library,
        'size': '~300KB',
      },
      {
        'id': 'data_table',
        'title': 'Data Table',
        'description': 'Advanced data table with sorting',
        'icon': Icons.table_chart,
        'size': '~100KB',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: components.length,
      itemBuilder: (context, index) {
        final component = components[index];
        final componentId = component['id'] as String;
        
        return StreamBuilder(
          stream: Stream.periodic(const Duration(milliseconds: 100)),
          builder: (context, snapshot) {
            final isLoaded = _controller.isComponentLoaded(componentId);
            
            return _DeferredComponentCard(
              title: component['title'] as String,
              description: component['description'] as String,
              icon: component['icon'] as IconData,
              size: component['size'] as String,
              isLoaded: isLoaded,
              onLoad: () => _loadComponent(componentId),
            );
          },
        );
      },
    );
  }

  Widget _buildResetButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            _controller.reset();
          });
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Reset Demo'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Future<void> _loadComponent(String componentId) async {
    await _controller.loadComponent(componentId);
    if (mounted) {
      setState(() {}); // Trigger rebuild to show loaded state
    }
  }
}

/// Individual deferred component card
class _DeferredComponentCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String size;
  final bool isLoaded;
  final VoidCallback onLoad;

  const _DeferredComponentCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.size,
    required this.isLoaded,
    required this.onLoad,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isLoaded ? 4 : 2,
      child: InkWell(
        onTap: isLoaded ? null : onLoad,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isLoaded 
                ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isLoaded 
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: isLoaded 
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isLoaded 
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      size,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (isLoaded)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                )
              else
                Icon(
                  Icons.download,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bundle size comparison widget
class BundleSizeComparisonCard extends StatelessWidget {
  const BundleSizeComparisonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.pie_chart,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Bundle Size Comparison',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Compare bundle sizes with and without deferred loading:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            _buildComparisonChart(context),
            const SizedBox(height: 20),
            _buildImpactMetrics(context),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonChart(BuildContext context) {
    return Column(
      children: [
        _buildBundleBar(
          context,
          'Without Deferred Loading',
          2.8,
          3.5,
          Colors.red,
          'Initial: 2.8MB, Total: 3.5MB',
        ),
        const SizedBox(height: 16),
        _buildBundleBar(
          context,
          'With Deferred Loading',
          1.2,
          3.5,
          Colors.green,
          'Initial: 1.2MB, Total: 3.5MB (same)',
        ),
      ],
    );
  }

  Widget _buildBundleBar(
    BuildContext context,
    String label,
    double initialSize,
    double totalSize,
    Color color,
    String details,
  ) {
    final percentage = (initialSize / totalSize);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              details,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 24,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${(percentage * 100).toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImpactMetrics(BuildContext context) {
    final metrics = [
      {'label': 'Startup Time Improvement', 'value': '~40%', 'icon': Icons.speed},
      {'label': 'Initial Bundle Reduction', 'value': '~57%', 'icon': Icons.file_download},
      {'label': 'First Contentful Paint', 'value': '~35%', 'icon': Icons.timer},
      {'label': 'Time to Interactive', 'value': '~45%', 'icon': Icons.touch_app},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📊 Performance Impact',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          ...metrics.map((metric) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  metric['icon'] as IconData,
                  size: 18,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    metric['label'] as String,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  ),
                ),
                Text(
                  metric['value'] as String,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
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

