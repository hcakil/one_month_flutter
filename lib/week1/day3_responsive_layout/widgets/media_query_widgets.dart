import 'package:flutter/material.dart';

import '../models/device_info.dart';
import '../utils/responsive_breakpoints.dart';

/// Widget demonstrating MediaQuery basic usage
class MediaQueryInfoCard extends StatelessWidget {
  const MediaQueryInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceInfo = DeviceInfo.fromMediaQuery(mediaQuery);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📱 MediaQuery Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              context,
              'Screen Dimensions',
              [
                'Width: ${deviceInfo.screenWidth.toInt()}px',
                'Height: ${deviceInfo.screenHeight.toInt()}px',
                'Device Pixel Ratio: ${deviceInfo.devicePixelRatio.toStringAsFixed(2)}',
                'Orientation: ${deviceInfo.orientation.name}',
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              context,
              'Device Classification',
              [
                'Device Type: ${deviceInfo.deviceType.name}',
                'Is Mobile: ${deviceInfo.isMobile}',
                'Is Tablet: ${deviceInfo.isTablet}',
                'Is Desktop: ${deviceInfo.isDesktop}',
                'Is Web: ${deviceInfo.isWeb}',
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              context,
              'Layout Properties',
              [
                'Column Count: ${deviceInfo.columnCount}',
                'Horizontal Padding: ${deviceInfo.horizontalPadding}px',
                'Font Size Multiplier: ${deviceInfo.fontSizeMultiplier.toStringAsFixed(2)}x',
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              context,
              'MediaQuery Properties',
              [
                'Text Scale Factor: ${mediaQuery.textScaler.scale(1.0).toStringAsFixed(2)}',
                'Platform Brightness: ${mediaQuery.platformBrightness.name}',
                'Padding Top: ${mediaQuery.padding.top.toStringAsFixed(1)}px',
                'Padding Bottom: ${mediaQuery.padding.bottom.toStringAsFixed(1)}px',
                'View Insets Bottom: ${mediaQuery.viewInsets.bottom.toStringAsFixed(1)}px',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, String title, List<String> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• $item',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )),
        ],
      ),
    );
  }
}

/// Widget demonstrating orientation-based layout changes
class OrientationAwareCard extends StatelessWidget {
  const OrientationAwareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔄 Orientation Aware Layout',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            OrientationBuilder(
              builder: (context, orientation) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: orientation == Orientation.portrait
                      ? _buildPortraitLayout(context)
                      : _buildLandscapeLayout(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.phone_android,
          size: 48,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        const SizedBox(height: 16),
        Text(
          'Portrait Mode',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
        Text(
          'Vertical Layout',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.tablet_android,
          size: 48,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Landscape Mode',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            Text(
              'Horizontal Layout',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget demonstrating safe area usage
class SafeAreaDemoCard extends StatelessWidget {
  const SafeAreaDemoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🛡️ Safe Area & Padding',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  // Full area
                  Container(
                                         color: Colors.red.withValues(alpha: 0.1),
                    child: const Center(
                      child: Text('Full Area'),
                    ),
                  ),
                  // Safe area
                  SafeArea(
                    child: Container(
                                             color: Colors.green.withValues(alpha: 0.2),
                      margin: EdgeInsets.all(mediaQuery.padding.top > 0 ? 8 : 0),
                      child: const Center(
                        child: Text('Safe Area'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildPaddingInfo(context, mediaQuery),
          ],
        ),
      ),
    );
  }

  Widget _buildPaddingInfo(BuildContext context, MediaQueryData mediaQuery) {
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
            'Device Padding Information:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text('Top: ${mediaQuery.padding.top.toStringAsFixed(1)}px (Status bar)'),
          Text('Bottom: ${mediaQuery.padding.bottom.toStringAsFixed(1)}px (Home indicator)'),
          Text('Left: ${mediaQuery.padding.left.toStringAsFixed(1)}px'),
          Text('Right: ${mediaQuery.padding.right.toStringAsFixed(1)}px'),
          const SizedBox(height: 8),
          Text(
            'View Insets (Keyboard):',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text('Bottom: ${mediaQuery.viewInsets.bottom.toStringAsFixed(1)}px'),
        ],
      ),
    );
  }
}

/// Widget demonstrating text scaling
class TextScalingDemoCard extends StatelessWidget {
  const TextScalingDemoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final textScaler = mediaQuery.textScaler;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📝 Text Scaling',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Text Scale Factor: ${textScaler.scale(1.0).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Small Text (12px)',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Normal Text (16px)',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Large Text (20px)',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Extra Large Text (24px)',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Note: Text scaling is controlled by device accessibility settings. Users can increase text size for better readability.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget demonstrating responsive breakpoint visualization
class BreakpointVisualizerCard extends StatelessWidget {
  const BreakpointVisualizerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📏 Breakpoint Visualizer',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Stack(
                children: [
                  // Mobile range
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: _getBreakpointWidth(ResponsiveBreakpoints.mobileMax, screenWidth),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.3),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Center(child: Text('Mobile', style: TextStyle(fontSize: 12))),
                    ),
                  ),
                  // Tablet range
                  Positioned(
                    left: _getBreakpointWidth(ResponsiveBreakpoints.mobileMax, screenWidth),
                    top: 0,
                    bottom: 0,
                    width: _getBreakpointWidth(
                        ResponsiveBreakpoints.tabletMax - ResponsiveBreakpoints.tabletMin, screenWidth),
                    child: Container(
                      color: Colors.green.withValues(alpha: 0.3),
                      child: const Center(child: Text('Tablet', style: TextStyle(fontSize: 12))),
                    ),
                  ),
                  // Desktop range
                  Positioned(
                    left: _getBreakpointWidth(ResponsiveBreakpoints.tabletMax, screenWidth),
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.3),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: const Center(child: Text('Desktop', style: TextStyle(fontSize: 12))),
                    ),
                  ),
                  // Current position indicator
                  Positioned(
                    left: _getCurrentPosition(screenWidth) - 1,
                    top: 0,
                    bottom: 0,
                    width: 2,
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildBreakpointInfo(context, screenWidth),
          ],
        ),
      ),
    );
  }

  double _getBreakpointWidth(double breakpoint, double screenWidth) {
    const maxWidth = 1400.0; // Max width for visualization
    final containerWidth = screenWidth > maxWidth ? maxWidth : screenWidth;
    return (breakpoint / maxWidth) * (containerWidth - 32); // 32 for padding
  }

  double _getCurrentPosition(double screenWidth) {
    const maxWidth = 1400.0;
    final containerWidth = screenWidth > maxWidth ? maxWidth : screenWidth;
    return (screenWidth / maxWidth) * (containerWidth - 32);
  }

  Widget _buildBreakpointInfo(BuildContext context, double screenWidth) {
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
            'Breakpoint Information:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text('📱 Mobile: 0px - ${ResponsiveBreakpoints.mobileMax.toInt()}px'),
          Text(
              '💻 Tablet: ${ResponsiveBreakpoints.tabletMin.toInt()}px - ${ResponsiveBreakpoints.tabletMax.toInt()}px'),
          Text('🖥️ Desktop: ${ResponsiveBreakpoints.desktopMin.toInt()}px+'),
          const SizedBox(height: 8),
          Text(
            'Current: ${screenWidth.toInt()}px (${ResponsiveBreakpoints.getDeviceTypeName(screenWidth)})',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}
