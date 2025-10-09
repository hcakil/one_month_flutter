import 'package:flutter/material.dart';
import '../utils/seo_utils.dart';

/// Card explaining route-based title updates
class RouteTitleOverviewCard extends StatelessWidget {
  const RouteTitleOverviewCard({super.key});

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
                  Icons.route,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '🧭 Route-Based Title Updates',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Dynamic page title updates are essential for Flutter Web SPAs. Each route should have a unique, descriptive title for better SEO and user experience.',
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
                    '🎯 Why It Matters',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildBenefitItem(context, 'SEO', 'Search engines index pages based on titles'),
                  _buildBenefitItem(context, 'UX', 'Browser tabs show meaningful names'),
                  _buildBenefitItem(context, 'Analytics', 'Better tracking of page views'),
                  _buildBenefitItem(context, 'Bookmarks', 'Users save pages with descriptive names'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCodeExample(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, String label, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeExample(BuildContext context) {
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
            '💻 Implementation Example',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                '''
import 'dart:html' as html;

void updatePageTitle(String route) {
  final title = getTitleForRoute(route);
  html.document.title = title;
}

String getTitleForRoute(String route) {
  return switch (route) {
    '/home' => 'Home | My App',
    '/about' => 'About Us | My App',
    '/blog' => 'Blog | My App',
    _ => 'My App',
  };
}
''',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Interactive route title demonstration
class RouteTitleDemoCard extends StatefulWidget {
  const RouteTitleDemoCard({super.key});

  @override
  State<RouteTitleDemoCard> createState() => _RouteTitleDemoCardState();
}

class _RouteTitleDemoCardState extends State<RouteTitleDemoCard> {
  String? _selectedRoute;
  final _customTitleController = TextEditingController();

  @override
  void dispose() {
    _customTitleController.dispose();
    super.dispose();
  }

  void _updateTitle(String route) {
    final templates = SeoUtils.getRouteTitleTemplates();
    final title = templates[route] ?? 'One Month Flutter';
    SeoUtils.updateTitle(title);

    setState(() {
      _selectedRoute = route;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ Title updated to: $title'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _updateCustomTitle() {
    if (_customTitleController.text.isNotEmpty) {
      SeoUtils.updateTitle(_customTitleController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Custom title applied: ${_customTitleController.text}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final templates = SeoUtils.getRouteTitleTemplates();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎮 Interactive Title Demo',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try different routes and watch the browser tab title change!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Available Routes:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: templates.entries.map((entry) {
                final isSelected = _selectedRoute == entry.key;
                return FilterChip(
                  label: Text(entry.key),
                  selected: isSelected,
                  onSelected: (_) => _updateTitle(entry.key),
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  selectedColor: Theme.of(context).colorScheme.primaryContainer,
                );
              }).toList(),
            ),
            if (_selectedRoute != null) ...[
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
                      'Current Route:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      _selectedRoute!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Page Title:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      templates[_selectedRoute]!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              '✏️ Custom Title',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _customTitleController,
              decoration: const InputDecoration(
                labelText: 'Enter custom page title',
                border: OutlineInputBorder(),
                hintText: 'My Custom Page | Website Name',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _updateCustomTitle,
                icon: const Icon(Icons.edit),
                label: const Text('Apply Custom Title'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Best practices for page titles
class TitleBestPracticesCard extends StatelessWidget {
  const TitleBestPracticesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📋 Title Best Practices',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPracticeItem(
              context,
              '✅ Keep it Concise',
              '30-60 characters is optimal for search results',
              Colors.green,
            ),
            _buildPracticeItem(
              context,
              '✅ Include Keywords',
              'Put important keywords at the beginning',
              Colors.blue,
            ),
            _buildPracticeItem(
              context,
              '✅ Add Branding',
              'Include site/app name consistently (e.g., " | AppName")',
              Colors.purple,
            ),
            _buildPracticeItem(
              context,
              '✅ Be Descriptive',
              'Clearly describe the page content',
              Colors.orange,
            ),
            _buildPracticeItem(
              context,
              '✅ Unique Per Page',
              'Every page should have a unique title',
              Colors.teal,
            ),
            _buildPracticeItem(
              context,
              '❌ Avoid Keyword Stuffing',
              'Don\'t repeat the same keyword multiple times',
              Colors.red,
            ),
            _buildPracticeItem(
              context,
              '❌ Don\'t Use Generic Titles',
              'Avoid "Home", "Page 1", or "Untitled"',
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeItem(BuildContext context, String title, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            title.startsWith('✅') ? Icons.check_circle : Icons.cancel,
            color: color,
            size: 24,
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
}

