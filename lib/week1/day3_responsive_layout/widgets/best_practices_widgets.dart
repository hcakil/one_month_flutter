import 'package:flutter/material.dart';

/// Widget showcasing responsive design best practices
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
              '✨ Responsive Design Best Practices',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildPracticeSection(
              context,
              '1. Mobile-First Approach',
              [
                'Design for mobile screens first, then scale up',
                'Use min-width media queries for larger screens',
                'Prioritize content and functionality on smaller screens',
                'Progressive enhancement for larger displays',
              ],
              Icons.phone_android,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildPracticeSection(
              context,
              '2. Flexible Layouts',
              [
                'Use flexible units (percentages, vh/vw, em/rem)',
                'Avoid fixed pixel values for major layout elements',
                'Implement fluid grids and flexible images',
                'Use LayoutBuilder and MediaQuery effectively',
              ],
              Icons.view_quilt,
              Colors.green,
            ),
            const SizedBox(height: 16),
            _buildPracticeSection(
              context,
              '3. Touch-Friendly Design',
              [
                'Minimum 44px touch targets (iOS) / 48dp (Android)',
                'Adequate spacing between interactive elements',
                'Consider thumb reach zones on mobile devices',
                'Test with real devices and different hand sizes',
              ],
              Icons.touch_app,
              Colors.orange,
            ),
            const SizedBox(height: 16),
            _buildPracticeSection(
              context,
              '4. Performance Optimization',
              [
                'Lazy load images and content below the fold',
                'Use appropriate image sizes for different screens',
                'Minimize layout shifts and reflows',
                'Optimize animations for 60fps performance',
              ],
              Icons.speed,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeSection(
    BuildContext context,
    String title,
    List<String> practices,
    IconData icon,
    Color color,
  ) {
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
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...practices.map((practice) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 6, right: 8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    practice,
                    style: Theme.of(context).textTheme.bodyMedium,
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

/// Widget comparing different responsive approaches
class ResponsiveApproachesCard extends StatelessWidget {
  const ResponsiveApproachesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔄 Responsive vs Adaptive Approaches',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
              },
              children: [
                _buildTableHeader(context),
                _buildTableRow(
                  context,
                  'Definition',
                  'Fluid layouts that adapt continuously to any screen size',
                  'Fixed layouts designed for specific screen sizes/devices',
                ),
                _buildTableRow(
                  context,
                  'Implementation',
                  'CSS media queries, flexible grids, fluid images',
                  'Device detection, separate layouts per device type',
                ),
                _buildTableRow(
                  context,
                  'Pros',
                  'Works on all devices, future-proof, cost-effective',
                  'Optimized for specific devices, better control',
                ),
                _buildTableRow(
                  context,
                  'Cons',
                  'More complex testing, potential compromises',
                  'More maintenance, limited device support',
                ),
                _buildTableRow(
                  context,
                  'Best For',
                  'Most web/mobile apps, content-heavy sites',
                  'Apps with very specific device requirements',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableHeader(BuildContext context) {
    return TableRow(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      children: [
        _buildTableCell(
          context,
          'Aspect',
          isHeader: true,
        ),
        _buildTableCell(
          context,
          'Responsive Design',
          isHeader: true,
        ),
        _buildTableCell(
          context,
          'Adaptive Design',
          isHeader: true,
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    BuildContext context,
    String aspect,
    String responsive,
    String adaptive,
  ) {
    return TableRow(
      children: [
        _buildTableCell(context, aspect, isAspect: true),
        _buildTableCell(context, responsive),
        _buildTableCell(context, adaptive),
      ],
    );
  }

  Widget _buildTableCell(
    BuildContext context,
    String text, {
    bool isHeader = false,
    bool isAspect = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAspect 
          ? Theme.of(context).colorScheme.surfaceContainerHighest 
          : null,
      ),
      child: Text(
        text,
        style: isHeader
          ? Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            )
          : isAspect
            ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              )
            : Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

/// Widget showing Flutter-specific responsive widgets
class FlutterResponsiveWidgetsCard extends StatelessWidget {
  const FlutterResponsiveWidgetsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📱 Flutter Responsive Widgets',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildWidgetSection(
              context,
              'LayoutBuilder',
              'Provides constraints information to build responsive layouts',
              [
                'Access to parent widget constraints',
                'Build different layouts based on available space',
                'Useful for creating adaptive components',
                'Works at any level in the widget tree',
              ],
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildWidgetSection(
              context,
              'MediaQuery',
              'Provides device and app window information',
              [
                'Screen dimensions and pixel density',
                'Orientation and safe area insets',
                'Text scaling and platform brightness',
                'System navigation bar information',
              ],
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildWidgetSection(
              context,
              'OrientationBuilder',
              'Rebuilds when device orientation changes',
              [
                'Detects portrait vs landscape orientation',
                'Automatically rebuilds on orientation change',
                'Useful for layout adjustments',
                'Works with both device and app orientation',
              ],
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildWidgetSection(
              context,
              'AspectRatio',
              'Maintains consistent aspect ratios across devices',
              [
                'Ensures consistent proportions',
                'Useful for images and videos',
                'Prevents layout distortion',
                'Works with flexible layouts',
              ],
              Colors.purple,
            ),
            const SizedBox(height: 12),
            _buildWidgetSection(
              context,
              'Flexible & Expanded',
              'Creates flexible layouts that adapt to available space',
              [
                'Distributes space among children',
                'Flex property controls space allocation',
                'Prevents overflow in dynamic layouts',
                'Essential for responsive row/column layouts',
              ],
              Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetSection(
    BuildContext context,
    String widgetName,
    String description,
    List<String> features,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widgetName,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    feature,
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
}

/// Widget showing common responsive patterns
class ResponsivePatternsCard extends StatelessWidget {
  const ResponsivePatternsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎨 Common Responsive Patterns',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildPatternSection(
              context,
              '1. Column Drop',
              'Columns stack vertically on smaller screens',
              Icons.view_column,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildPatternSection(
              context,
              '2. Mostly Fluid',
              'Layout adapts with margins at larger breakpoints',
              Icons.water_drop,
              Colors.cyan,
            ),
            const SizedBox(height: 12),
            _buildPatternSection(
              context,
              '3. Layout Shifter',
              'Major layout changes at different breakpoints',
              Icons.transform,
              Colors.purple,
            ),
            const SizedBox(height: 12),
            _buildPatternSection(
              context,
              '4. Tiny Tweaks',
              'Small adjustments to font sizes and spacing',
              Icons.tune,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildPatternSection(
              context,
              '5. Off Canvas',
              'Navigation hidden behind menu on small screens',
              Icons.menu,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatternSection(
    BuildContext context,
    String pattern,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pattern,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget showing testing and debugging tips
class TestingTipsCard extends StatelessWidget {
  const TestingTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🧪 Testing & Debugging Responsive Layouts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildTipCategory(
              context,
              'Testing Strategies',
              [
                'Test on real devices, not just emulators',
                'Use browser dev tools for web responsive testing',
                'Test with different text sizes and accessibility settings',
                'Verify touch targets meet platform guidelines',
                'Test with slow network conditions',
              ],
              Icons.bug_report,
              Colors.red,
            ),
            const SizedBox(height: 16),
            _buildTipCategory(
              context,
              'Flutter Debugging Tools',
              [
                'Use Flutter Inspector to examine widget tree',
                'Enable "Select Widget Mode" for layout debugging',
                'Use "debugPaintSizeEnabled" to visualize widget bounds',
                'Check MediaQuery values in debug console',
                'Use layout explorer for complex layouts',
              ],
              Icons.build,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildTipCategory(
              context,
              'Common Issues',
              [
                'Overflow errors on small screens',
                'Touch targets too small on mobile',
                'Text not scaling properly',
                'Images not responsive',
                'Performance issues on lower-end devices',
              ],
              Icons.warning,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCategory(
    BuildContext context,
    String category,
    List<String> tips,
    IconData icon,
    Color color,
  ) {
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
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                category,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...tips.map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 6, right: 8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    tip,
                    style: Theme.of(context).textTheme.bodyMedium,
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
