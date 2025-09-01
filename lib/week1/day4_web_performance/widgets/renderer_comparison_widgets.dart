import 'package:flutter/material.dart';
import '../models/performance_metrics.dart';
import '../utils/web_performance_utils.dart';

/// Main renderer comparison widget with tabs
class RendererComparisonCard extends StatefulWidget {
  const RendererComparisonCard({super.key});

  @override
  State<RendererComparisonCard> createState() => _RendererComparisonCardState();
}

class _RendererComparisonCardState extends State<RendererComparisonCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  PerformanceMetrics? _canvasKitMetrics;
  PerformanceMetrics? _htmlMetrics;
  bool _isLoadingCanvasKit = false;
  bool _isLoadingHtml = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                  Icons.compare,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '⚡ CanvasKit vs HTML Renderer (30 min)',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Compare Flutter\'s two web renderers: CanvasKit (WebAssembly) vs HTML (DOM). Each has different performance characteristics.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.info), text: 'Overview'),
                Tab(icon: Icon(Icons.speed), text: 'Performance Test'),
                Tab(icon: Icon(Icons.compare_arrows), text: 'Comparison'),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 600,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildPerformanceTestTab(),
                  _buildComparisonTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRendererOverview('CanvasKit', _getCanvasKitInfo()),
          const SizedBox(height: 20),
          _buildRendererOverview('HTML', _getHtmlInfo()),
          const SizedBox(height: 20),
          _buildSelectionGuide(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTestTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Testing',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildRendererTestingInstructions(),
          const SizedBox(height: 20),
          _buildPerformanceTestButtons(),
          const SizedBox(height: 20),
          if (_canvasKitMetrics != null || _htmlMetrics != null)
            _buildPerformanceResults(),
        ],
      ),
    );
  }

  Widget _buildComparisonTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detailed Comparison',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailedComparison(),
        ],
      ),
    );
  }

  Widget _buildRendererOverview(String rendererName, Map<String, dynamic> info) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: rendererName == 'CanvasKit' 
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                rendererName == 'CanvasKit' ? Icons.memory : Icons.web,
                size: 24,
                color: rendererName == 'CanvasKit' 
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              const SizedBox(width: 8),
              Text(
                '$rendererName Renderer',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: rendererName == 'CanvasKit' 
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            info['description'] as String,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: rendererName == 'CanvasKit' 
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 16),
          _buildProsCons(info, rendererName == 'CanvasKit'),
        ],
      ),
    );
  }

  Widget _buildProsCons(Map<String, dynamic> info, bool isPrimary) {
    final textColor = isPrimary 
        ? Theme.of(context).colorScheme.onPrimaryContainer
        : Theme.of(context).colorScheme.onSecondaryContainer;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✅ Pros',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              ...(info['pros'] as List<String>).map((pro) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• $pro',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor,
                  ),
                ),
              )),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '❌ Cons',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              ...(info['cons'] as List<String>).map((con) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• $con',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor,
                  ),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRendererTestingInstructions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.science,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'How to Test Different Renderers',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTestingStep(
            '1. Test Current Renderer (Real Data)',
            'Click "Test Current Renderer" to get actual performance metrics from your browser.',
            Icons.sensors,
            Colors.green,
            isHighlighted: true,
          ),
          const SizedBox(height: 12),
          _buildTestingStep(
            '2. Compare with Simulations',
            'Use "Simulate CanvasKit" and "Simulate HTML" to see typical performance differences.',
            Icons.compare_arrows,
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildRendererSwitchingGuide(),
        ],
      ),
    );
  }

  Widget _buildTestingStep(String title, String description, IconData icon, Color color, {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlighted 
            ? color.withValues(alpha: 0.1)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted 
            ? Border.all(color: color.withValues(alpha: 0.3))
            : null,
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
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isHighlighted ? color : null,
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

  Widget _buildRendererSwitchingGuide() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.swap_horiz,
                size: 20,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 8),
              Text(
                'To Test Different Renderers:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildCommandStep(
            'Current Session (CanvasKit detected)',
            'flutter run -d chrome',
            'You\'re currently using CanvasKit renderer in debug mode',
          ),
          const SizedBox(height: 8),
          _buildCommandStep(
            'Force HTML Renderer',
            'Add to web/index.html: <script>window.flutterConfiguration = {renderer: "html"};</script>',
            'Then restart: flutter run -d chrome',
          ),
          const SizedBox(height: 8),
          _buildCommandStep(
            'Production Build',
            'flutter build web\ncd build/web && python -m http.server 8000',
            'Open http://localhost:8000 for production testing',
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Note: Modern Flutter automatically chooses the best renderer. Manual selection may require configuration.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommandStep(String title, String command, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          child: Text(
            command,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionGuide() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                size: 24,
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
              const SizedBox(width: 8),
              Text(
                'Renderer Selection Guide',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSelectionItem(
            'Choose CanvasKit for:',
            'Complex graphics, games, custom painting, consistent cross-platform rendering',
            Icons.palette,
          ),
          const SizedBox(height: 8),
          _buildSelectionItem(
            'Choose HTML for:',
            'Text-heavy apps, forms, SEO requirements, accessibility-first design',
            Icons.text_fields,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionItem(String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onTertiaryContainer,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceTestButtons() {
    return Column(
      children: [
        // Current renderer info
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _getCurrentRendererColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                _getCurrentRendererIcon(),
                color: _getCurrentRendererIconColor(),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Renderer',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: _getCurrentRendererTextColor(),
                      ),
                    ),
                    Text(
                      WebPerformanceUtils.getCurrentRenderer(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _getCurrentRendererTextColor(),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    // Force refresh the renderer detection
                    WebPerformanceUtils.forceRefreshRendererDetection();
                  });
                },
                icon: const Icon(Icons.refresh, size: 18),
                tooltip: 'Refresh renderer detection',
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(4),
                  minimumSize: const Size(24, 24),
                  foregroundColor: _getCurrentRendererTextColor(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Test buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _isLoadingCanvasKit ? null : () => _testCurrentRenderer(),
                icon: _isLoadingCanvasKit 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.sensors),
                label: Text(_isLoadingCanvasKit ? 'Testing...' : 'Test Current Renderer'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _isLoadingCanvasKit ? null : () => _testCanvasKitPerformance(),
                icon: _isLoadingCanvasKit 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.memory),
                label: Text(_isLoadingCanvasKit ? 'Testing...' : 'Simulate CanvasKit'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _isLoadingHtml ? null : () => _testHtmlPerformance(),
                icon: _isLoadingHtml 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.web),
                label: Text(_isLoadingHtml ? 'Testing...' : 'Simulate HTML'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Test Results',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (_canvasKitMetrics != null)
          _buildMetricsCard(_canvasKitMetrics!, Colors.blue),
        if (_canvasKitMetrics != null && _htmlMetrics != null)
          const SizedBox(height: 16),
        if (_htmlMetrics != null)
          _buildMetricsCard(_htmlMetrics!, Colors.green),
        if (_canvasKitMetrics != null && _htmlMetrics != null) ...[
          const SizedBox(height: 16),
          _buildMetricsComparison(),
        ],
      ],
    );
  }

  Widget _buildMetricsCard(PerformanceMetrics metrics, Color color) {
    final isRealData = metrics.additionalMetrics['isRealData'] as bool? ?? false;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                metrics.rendererType == 'CanvasKit' ? Icons.memory : Icons.web,
                color: color,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${metrics.rendererType} Results',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          isRealData ? Icons.sensors : Icons.science,
                          size: 12,
                          color: isRealData ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isRealData ? 'Real Browser Data' : 'Simulated Data',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: isRealData ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Grade ${metrics.performanceGrade}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  'Load Time',
                  metrics.formattedLoadTime,
                  Icons.timer,
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  'Render Time',
                  metrics.formattedRenderTime,
                  Icons.speed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  'Memory',
                  metrics.formattedMemoryUsage,
                  Icons.memory,
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  'FPS',
                  '${metrics.fps}',
                  Icons.show_chart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricsComparison() {
    if (_canvasKitMetrics == null || _htmlMetrics == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Head-to-Head Comparison',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildComparisonRow(
            'Load Time',
            _canvasKitMetrics!.loadTime,
            _htmlMetrics!.loadTime,
            'ms',
            false, // Lower is better
          ),
          _buildComparisonRow(
            'Render Time',
            _canvasKitMetrics!.renderTime,
            _htmlMetrics!.renderTime,
            'ms',
            false,
          ),
          _buildComparisonRow(
            'Memory Usage',
            _canvasKitMetrics!.memoryUsage,
            _htmlMetrics!.memoryUsage,
            'MB',
            false,
          ),
          _buildComparisonRow(
            'FPS',
            _canvasKitMetrics!.fps.toDouble(),
            _htmlMetrics!.fps.toDouble(),
            '',
            true, // Higher is better
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    String metric,
    double canvasKitValue,
    double htmlValue,
    String unit,
    bool higherIsBetter,
  ) {
    final canvasKitWins = higherIsBetter 
        ? canvasKitValue > htmlValue 
        : canvasKitValue < htmlValue;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              metric,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: canvasKitWins ? Colors.green.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${canvasKitValue.toStringAsFixed(1)}$unit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: canvasKitWins ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('vs', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: !canvasKitWins ? Colors.green.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${htmlValue.toStringAsFixed(1)}$unit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !canvasKitWins ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedComparison() {
    final comparisonData = WebPerformanceUtils.getRendererComparison();
    
    return Column(
      children: [
        _buildComparisonTable(comparisonData),
        const SizedBox(height: 20),
        _buildUseCaseRecommendations(comparisonData),
      ],
    );
  }

  Widget _buildComparisonTable(Map<String, Map<String, dynamic>> data) {
    final canvasKit = data['CanvasKit']!;
    final html = data['HTML']!;
    
    return Table(
      border: TableBorder.all(
        color: Theme.of(context).colorScheme.outline,
        width: 1,
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          children: [
            _buildTableCell('Feature', isHeader: true),
            _buildTableCell('CanvasKit', isHeader: true),
            _buildTableCell('HTML', isHeader: true),
          ],
        ),
        ..._buildPerformanceTableRows(canvasKit, html),
      ],
    );
  }

  List<TableRow> _buildPerformanceTableRows(
    Map<String, dynamic> canvasKit,
    Map<String, dynamic> html,
  ) {
    final performance = canvasKit['performance'] as Map<String, dynamic>;
    final htmlPerformance = html['performance'] as Map<String, dynamic>;
    
    return [
      'bundleSize',
      'loadTime',
      'renderPerformance',
      'memoryUsage',
      'accessibility',
    ].map((key) => TableRow(
      children: [
        _buildTableCell(_formatMetricName(key)),
        _buildTableCell(performance[key] as String),
        _buildTableCell(htmlPerformance[key] as String),
      ],
    )).toList();
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: isHeader
            ? Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              )
            : Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  String _formatMetricName(String key) {
    switch (key) {
      case 'bundleSize':
        return 'Bundle Size';
      case 'loadTime':
        return 'Load Time';
      case 'renderPerformance':
        return 'Render Performance';
      case 'memoryUsage':
        return 'Memory Usage';
      case 'accessibility':
        return 'Accessibility';
      default:
        return key;
    }
  }

  Widget _buildUseCaseRecommendations(Map<String, Map<String, dynamic>> data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildUseCaseCard(
            'CanvasKit Best For',
            data['CanvasKit']!['bestFor'] as List<String>,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildUseCaseCard(
            'HTML Best For',
            data['HTML']!['bestFor'] as List<String>,
            Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildUseCaseCard(String title, List<String> useCases, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
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
          const SizedBox(height: 12),
          ...useCases.map((useCase) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: color,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    useCase,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Future<void> _testCurrentRenderer() async {
    setState(() {
      _isLoadingCanvasKit = true;
    });

    try {
      final currentRenderer = WebPerformanceUtils.getCurrentRenderer();
      final realMetrics = await WebPerformanceUtils.getRealPerformanceMetrics(
        rendererType: currentRenderer,
      );
      
      // Create performance metrics based on current renderer
      if (currentRenderer.contains('CanvasKit') || currentRenderer.contains('WebGL')) {
        _canvasKitMetrics = PerformanceMetrics.canvasKit(
          loadTime: realMetrics['loadTime'] ?? 1000.0,
          renderTime: realMetrics['renderTime'] ?? 16.67,
          memoryUsage: realMetrics['memoryUsage'] ?? 50.0,
          fps: (realMetrics['fps'] ?? 60.0).round(),
          additionalMetrics: {
            'firstPaint': realMetrics['firstPaint'] ?? 0.0,
            'firstContentfulPaint': realMetrics['firstContentfulPaint'] ?? 0.0,
            'domContentLoaded': realMetrics['domContentLoaded'] ?? 0.0,
            'rendererScore': realMetrics['rendererScore'] ?? 80.0,
            'isRealData': true,
            'detectedRenderer': currentRenderer,
          },
        );
      } else {
        _htmlMetrics = PerformanceMetrics.html(
          loadTime: realMetrics['loadTime'] ?? 800.0,
          renderTime: realMetrics['renderTime'] ?? 12.0,
          memoryUsage: realMetrics['memoryUsage'] ?? 35.0,
          fps: (realMetrics['fps'] ?? 60.0).round(),
          additionalMetrics: {
            'firstPaint': realMetrics['firstPaint'] ?? 0.0,
            'firstContentfulPaint': realMetrics['firstContentfulPaint'] ?? 0.0,
            'domContentLoaded': realMetrics['domContentLoaded'] ?? 0.0,
            'rendererScore': realMetrics['rendererScore'] ?? 75.0,
            'isRealData': true,
            'detectedRenderer': currentRenderer,
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingCanvasKit = false;
        });
      }
    }
  }

  Future<void> _testCanvasKitPerformance() async {
    setState(() {
      _isLoadingCanvasKit = true;
    });

    try {
      // Use simulation for CanvasKit comparison
      final metrics = await WebPerformanceUtils.simulatePerformanceMetrics(
        rendererType: 'CanvasKit',
      );
      
      _canvasKitMetrics = PerformanceMetrics.canvasKit(
        loadTime: metrics['loadTime'] ?? 1000.0,
        renderTime: metrics['renderTime'] ?? 16.67,
        memoryUsage: metrics['memoryUsage'] ?? 50.0,
        fps: (metrics['fps'] ?? 60.0).round(),
        additionalMetrics: {
          'firstPaint': 0.0,
          'firstContentfulPaint': 0.0,
          'domContentLoaded': 0.0,
          'rendererScore': 85.0,
          'isRealData': false,
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingCanvasKit = false;
        });
      }
    }
  }

  Future<void> _testHtmlPerformance() async {
    setState(() {
      _isLoadingHtml = true;
    });

    try {
      // Use simulation for HTML comparison
      final metrics = await WebPerformanceUtils.simulatePerformanceMetrics(
        rendererType: 'HTML',
      );
      
      _htmlMetrics = PerformanceMetrics.html(
        loadTime: metrics['loadTime'] ?? 800.0,
        renderTime: metrics['renderTime'] ?? 12.0,
        memoryUsage: metrics['memoryUsage'] ?? 35.0,
        fps: (metrics['fps'] ?? 60.0).round(),
        additionalMetrics: {
          'firstPaint': 0.0,
          'firstContentfulPaint': 0.0,
          'domContentLoaded': 0.0,
          'rendererScore': 75.0,
          'isRealData': false,
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingHtml = false;
        });
      }
    }
  }

  Map<String, dynamic> _getCanvasKitInfo() {
    return WebPerformanceUtils.getRendererComparison()['CanvasKit']!;
  }

  Map<String, dynamic> _getHtmlInfo() {
    return WebPerformanceUtils.getRendererComparison()['HTML']!;
  }

  // Helper methods for renderer styling
  Color _getCurrentRendererColor() {
    final renderer = WebPerformanceUtils.getCurrentRenderer();
    if (renderer.contains('HTML')) {
      return Colors.green.withValues(alpha: 0.1);
    } else if (renderer.contains('CanvasKit')) {
      return Colors.blue.withValues(alpha: 0.1);
    }
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  IconData _getCurrentRendererIcon() {
    final renderer = WebPerformanceUtils.getCurrentRenderer();
    if (renderer.contains('HTML')) {
      return Icons.web;
    } else if (renderer.contains('CanvasKit')) {
      return Icons.memory;
    }
    return Icons.info;
  }

  Color _getCurrentRendererIconColor() {
    final renderer = WebPerformanceUtils.getCurrentRenderer();
    if (renderer.contains('HTML')) {
      return Colors.green.shade700;
    } else if (renderer.contains('CanvasKit')) {
      return Colors.blue.shade700;
    }
    return Theme.of(context).colorScheme.primary;
  }

  Color _getCurrentRendererTextColor() {
    final renderer = WebPerformanceUtils.getCurrentRenderer();
    if (renderer.contains('HTML')) {
      return Colors.green.shade800;
    } else if (renderer.contains('CanvasKit')) {
      return Colors.blue.shade800;
    }
    return Theme.of(context).colorScheme.onSurface;
  }
}
