import 'package:flutter/material.dart';
import '../utils/web_performance_utils.dart';

/// Main WebP optimization overview card
class WebPOptimizationCard extends StatelessWidget {
  const WebPOptimizationCard({super.key});

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
                  Icons.image,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '🖼️ Image WebP Optimization (30 min)',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'WebP is a modern image format that provides superior compression for web images. Learn how to optimize your Flutter web app\'s images for better performance.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _buildWebPBenefits(context),
            const SizedBox(height: 16),
            _buildFormatComparison(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWebPBenefits(BuildContext context) {
    final benefits = [
      {'title': 'Smaller File Sizes', 'description': '25-35% smaller than JPEG, 80% smaller than PNG'},
      {'title': 'Better Quality', 'description': 'Superior compression algorithms maintain image quality'},
      {'title': 'Transparency Support', 'description': 'Supports alpha channel like PNG but with better compression'},
      {'title': 'Animation Support', 'description': 'Can replace GIF with better compression and quality'},
      {'title': 'Wide Browser Support', 'description': 'Supported by all modern browsers (95%+ coverage)'},
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
            '🚀 WebP Benefits',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          ...benefits.map((benefit) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        benefit['title']!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        benefit['description']!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
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

  Widget _buildFormatComparison(BuildContext context) {
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
            '📊 Format Comparison',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Table(
            border: TableBorder.all(
              color: Theme.of(context).colorScheme.onSecondaryContainer.withValues(alpha: 0.2),
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondaryContainer.withValues(alpha: 0.1),
                ),
                children: [
                  _buildTableCell(context, 'Format', isHeader: true),
                  _buildTableCell(context, 'Best For', isHeader: true),
                  _buildTableCell(context, 'Compression', isHeader: true),
                  _buildTableCell(context, 'Transparency', isHeader: true),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell(context, 'WebP'),
                  _buildTableCell(context, 'All purposes'),
                  _buildTableCell(context, 'Excellent'),
                  _buildTableCell(context, '✅'),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell(context, 'JPEG'),
                  _buildTableCell(context, 'Photos'),
                  _buildTableCell(context, 'Good'),
                  _buildTableCell(context, '❌'),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell(context, 'PNG'),
                  _buildTableCell(context, 'Graphics'),
                  _buildTableCell(context, 'Poor'),
                  _buildTableCell(context, '✅'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(BuildContext context, String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: isHeader
            ? Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              )
            : Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Interactive image optimization calculator
class ImageOptimizationCalculatorCard extends StatefulWidget {
  const ImageOptimizationCalculatorCard({super.key});

  @override
  State<ImageOptimizationCalculatorCard> createState() => _ImageOptimizationCalculatorCardState();
}

class _ImageOptimizationCalculatorCardState extends State<ImageOptimizationCalculatorCard> {
  String _selectedFormat = 'JPEG';
  double _imageSizeKB = 500;
  Map<String, dynamic>? _optimizationResult;

  final List<String> _formats = ['JPEG', 'PNG', 'WebP'];

  @override
  void initState() {
    super.initState();
    _calculateOptimization();
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
                  Icons.calculate,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Image Optimization Calculator',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Adjust the parameters below to see potential savings from WebP optimization:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            _buildInputControls(),
            const SizedBox(height: 20),
            if (_optimizationResult != null) _buildOptimizationResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputControls() {
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
            'Input Parameters',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Original Format',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedFormat,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      items: _formats.map((format) {
                        return DropdownMenuItem(
                          value: format,
                          child: Text(format),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedFormat = value;
                            _calculateOptimization();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Image Size: ${_imageSizeKB.round()} KB',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    Slider(
                      value: _imageSizeKB,
                      min: 10,
                      max: 2000,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() {
                          _imageSizeKB = value;
                          _calculateOptimization();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationResults() {
    final result = _optimizationResult!;
    final originalSize = result['originalSize'] as int;
    final optimizedSize = result['optimizedSize'] as int;
    final spaceSaved = result['spaceSaved'] as int;
    final spaceSavedPercentage = result['spaceSavedPercentage'] as double;
    final recommendedFormat = result['recommendedFormat'] as String;

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
            '📊 Optimization Results',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
          const SizedBox(height: 16),
          _buildResultsGrid(originalSize, optimizedSize, spaceSaved, spaceSavedPercentage),
          const SizedBox(height: 16),
          _buildSavingsVisualization(spaceSavedPercentage),
          const SizedBox(height: 16),
          _buildRecommendation(recommendedFormat, spaceSavedPercentage),
        ],
      ),
    );
  }

  Widget _buildResultsGrid(
    int originalSize,
    int optimizedSize,
    int spaceSaved,
    double spaceSavedPercentage,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _buildResultCard(
          'Original Size',
          WebPerformanceUtils.formatBytes(originalSize),
          Icons.file_present,
          Colors.red,
        ),
        _buildResultCard(
          'Optimized Size',
          WebPerformanceUtils.formatBytes(optimizedSize),
          Icons.file_download_done,
          Colors.green,
        ),
        _buildResultCard(
          'Space Saved',
          WebPerformanceUtils.formatBytes(spaceSaved),
          Icons.save,
          Colors.blue,
        ),
        _buildResultCard(
          'Reduction',
          '${spaceSavedPercentage.toStringAsFixed(1)}%',
          Icons.trending_down,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon, Color color) {
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
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsVisualization(double spaceSavedPercentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Savings Visualization',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 1 - (spaceSavedPercentage / 100),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const SizedBox(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remaining: ${(100 - spaceSavedPercentage).toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            ),
            Text(
              'Saved: ${spaceSavedPercentage.toStringAsFixed(1)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendation(String recommendedFormat, double spaceSavedPercentage) {
    Color recommendationColor;
    String recommendationText;
    IconData recommendationIcon;

    if (spaceSavedPercentage > 50) {
      recommendationColor = Colors.green;
      recommendationText = 'Excellent savings! Highly recommended to convert to $recommendedFormat.';
      recommendationIcon = Icons.thumb_up;
    } else if (spaceSavedPercentage > 25) {
      recommendationColor = Colors.orange;
      recommendationText = 'Good savings potential. Consider converting to $recommendedFormat.';
      recommendationIcon = Icons.info;
    } else {
      recommendationColor = Colors.blue;
      recommendationText = 'Minimal savings. Current format may be optimal.';
      recommendationIcon = Icons.check;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: recommendationColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: recommendationColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(recommendationIcon, color: recommendationColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommendation',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: recommendationColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  recommendationText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: recommendationColor.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _calculateOptimization() {
    final sizeBytes = (_imageSizeKB * 1024).round();
    _optimizationResult = WebPerformanceUtils.calculateImageOptimization(
      format: _selectedFormat,
      originalSize: sizeBytes,
    );
  }
}

/// Implementation guide for WebP in Flutter
class WebPImplementationGuideCard extends StatelessWidget {
  const WebPImplementationGuideCard({super.key});

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
                  Icons.code,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'WebP Implementation in Flutter',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildImplementationSteps(context),
            const SizedBox(height: 16),
            _buildCodeExamples(context),
            const SizedBox(height: 16),
            _buildBestPractices(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImplementationSteps(BuildContext context) {
    final steps = [
      'Convert existing images to WebP format',
      'Update pubspec.yaml to include WebP assets',
      'Use conditional loading for browser compatibility',
      'Implement fallback for unsupported browsers',
      'Test across different devices and browsers',
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
            '📋 Implementation Steps',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          ...steps.asMap().entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
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

  Widget _buildCodeExamples(BuildContext context) {
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
            '💻 Code Examples',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          _buildCodeExample(
            context,
            'Basic WebP Usage',
            '''Image.asset(
  'assets/images/hero.webp',
  width: 300,
  height: 200,
  fit: BoxFit.cover,
)''',
          ),
          const SizedBox(height: 12),
          _buildCodeExample(
            context,
            'Conditional Loading',
            '''Widget buildOptimizedImage() {
  if (kIsWeb && isWebPSupported()) {
    return Image.asset('assets/images/hero.webp');
  }
  return Image.asset('assets/images/hero.jpg');
}''',
          ),
        ],
      ),
    );
  }

  Widget _buildCodeExample(BuildContext context, String title, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          child: Text(
            code,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBestPractices(BuildContext context) {
    final practices = [
      'Always provide fallback formats (JPEG/PNG) for compatibility',
      'Use appropriate quality settings (80-90 for photos, 100 for graphics)',
      'Consider lazy loading for images below the fold',
      'Implement responsive images with different sizes',
      'Test loading performance across different network conditions',
      'Monitor Core Web Vitals impact after implementation',
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
            '⭐ Best Practices',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          ...practices.map((practice) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    practice,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
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
}
