import 'package:flutter/material.dart';
import '../models/seo_config.dart';
import '../utils/seo_utils.dart';

/// Card explaining SEO renderer concepts
class SeoRendererOverviewCard extends StatelessWidget {
  const SeoRendererOverviewCard({super.key});

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
                  Icons.search,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '🔍 SEO Renderer for Flutter Web',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'SEO rendering is crucial for Flutter Web applications to be discoverable by search engines. Since Flutter Web is a single-page application (SPA), proper SEO implementation requires special attention.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(
              context,
              Icons.title,
              'Dynamic Page Titles',
              'Update page titles based on route navigation for better indexing',
            ),
            const SizedBox(height: 12),
            _buildFeatureItem(
              context,
              Icons.description,
              'Meta Tag Management',
              'Programmatically control meta tags for SEO and social media',
            ),
            const SizedBox(height: 12),
            _buildFeatureItem(
              context,
              Icons.code,
              'Structured Data',
              'Implement JSON-LD for rich snippets in search results',
            ),
            const SizedBox(height: 12),
            _buildFeatureItem(
              context,
              Icons.share,
              'Social Media Integration',
              'Open Graph and Twitter Card tags for optimal sharing',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Interactive SEO configuration demo
class SeoConfigDemoCard extends StatefulWidget {
  const SeoConfigDemoCard({super.key});

  @override
  State<SeoConfigDemoCard> createState() => _SeoConfigDemoCardState();
}

class _SeoConfigDemoCardState extends State<SeoConfigDemoCard> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _keywordsController;
  Map<String, dynamic>? _validation;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: 'Flutter Web SEO Tutorial');
    _descriptionController = TextEditingController(
      text: 'Learn how to optimize your Flutter web applications for search engines with proper meta tags and structured data.',
    );
    _keywordsController = TextEditingController(text: 'Flutter, Web, SEO, Tutorial');
    _validateConfig();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _keywordsController.dispose();
    super.dispose();
  }

  void _validateConfig() {
    final config = SeoConfig(
      title: _titleController.text,
      description: _descriptionController.text,
      keywords: _keywordsController.text,
    );
    setState(() {
      _validation = SeoUtils.validateSeoConfig(config);
    });
  }

  void _applySeoConfig() {
    final config = SeoConfig(
      title: _titleController.text,
      description: _descriptionController.text,
      keywords: _keywordsController.text,
      author: 'Flutter Dev Team',
      ogTitle: _titleController.text,
      ogDescription: _descriptionController.text,
    );

    SeoUtils.updateMetaTags(config);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ SEO configuration applied! Check your browser tab and page source.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final score = _validation?['score'] ?? 0;
    final issues = _validation?['issues'] as List<String>? ?? [];
    final warnings = _validation?['warnings'] as List<String>? ?? [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎛️ Interactive SEO Configuration',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Page Title',
                helperText: '${_titleController.text.length}/60 characters',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _titleController.clear();
                    _validateConfig();
                  },
                ),
              ),
              onChanged: (_) => _validateConfig(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Meta Description',
                helperText: '${_descriptionController.text.length}/160 characters',
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (_) => _validateConfig(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _keywordsController,
              decoration: const InputDecoration(
                labelText: 'Keywords (comma separated)',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _validateConfig(),
            ),
            const SizedBox(height: 20),
            // SEO Score
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getScoreColor(score).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _getScoreColor(score)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getScoreIcon(score),
                    color: _getScoreColor(score),
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SEO Score: $score/100',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _getScoreColor(score),
                          ),
                        ),
                        Text(
                          _getScoreDescription(score),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (issues.isNotEmpty) ...[
              const SizedBox(height: 12),
              ...issues.map((issue) => _buildValidationMessage(context, issue, true)),
            ],
            if (warnings.isNotEmpty) ...[
              const SizedBox(height: 12),
              ...warnings.map((warning) => _buildValidationMessage(context, warning, false)),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _applySeoConfig,
                icon: const Icon(Icons.check),
                label: const Text('Apply SEO Configuration'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationMessage(BuildContext context, String message, bool isError) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isError
            ? Colors.red.withValues(alpha: 0.1)
            : Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isError ? Colors.red : Colors.orange,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isError ? Icons.error : Icons.warning,
            color: isError ? Colors.red : Colors.orange,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: isError ? Colors.red : Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  IconData _getScoreIcon(int score) {
    if (score >= 80) return Icons.check_circle;
    if (score >= 60) return Icons.warning;
    return Icons.error;
  }

  String _getScoreDescription(int score) {
    if (score >= 80) return 'Excellent! Your SEO configuration is well optimized.';
    if (score >= 60) return 'Good, but there\'s room for improvement.';
    return 'Needs work. Follow the suggestions above.';
  }
}

/// SEO Tips and Best Practices Card
class SeoTipsCard extends StatelessWidget {
  const SeoTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = SeoUtils.getSeoTips();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💡 SEO Best Practices',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...tips.map((tip) => _buildTipItem(context, tip)),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(BuildContext context, Map<String, String> tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tip['category']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
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
    );
  }
}

