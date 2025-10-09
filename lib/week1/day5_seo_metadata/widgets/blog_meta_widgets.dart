import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../utils/seo_utils.dart';

/// Blog listing with meta tags
class BlogListCard extends StatelessWidget {
  const BlogListCard({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = BlogPost.getSamplePosts();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.article,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '📝 Blog Posts with SEO',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Each blog post has optimized meta tags for search engines and social media sharing.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            ...posts.map((post) => _buildBlogPostItem(context, post)),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogPostItem(BuildContext context, BlogPost post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          _showBlogPostDialog(context, post);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      post.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                post.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    post.author,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    post.formattedDate,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post.readTimeMinutes} min read',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: post.tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    labelStyle: const TextStyle(fontSize: 12),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBlogPostDialog(BuildContext context, BlogPost post) {
    // Update meta tags for this blog post
    final seoConfig = SeoUtils.getSeoConfigForRoute('/week1/day5/blog');
    SeoUtils.updateMetaTags(seoConfig.copyWith(
      title: '${post.title} | Blog',
      description: post.description,
      keywords: post.keywords,
      author: post.author,
    ));

    // Generate and inject structured data
    final structuredData = SeoUtils.generateBlogPostSchema(
      title: post.title,
      description: post.description,
      author: post.author,
      publishedDate: post.publishedDate,
      imageUrl: post.imageUrl,
    );
    SeoUtils.injectStructuredData(structuredData);

    showDialog(
      context: context,
      builder: (context) => BlogPostDialog(post: post),
    );
  }
}

/// Dialog showing full blog post with meta information
class BlogPostDialog extends StatelessWidget {
  final BlogPost post;

  const BlogPostDialog({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
        child: Column(
          children: [
            AppBar(
              title: const Text('Blog Post Details'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 20),
                        const SizedBox(width: 8),
                        Text(post.author),
                        const SizedBox(width: 24),
                        const Icon(Icons.calendar_today, size: 20),
                        const SizedBox(width: 8),
                        Text(post.formattedDate),
                      ],
                    ),
                    const SizedBox(height: 24),
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
                            '🏷️ SEO Metadata for this post:',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildMetaItem(context, 'Title', '${post.title} | Blog'),
                          _buildMetaItem(context, 'Description', post.description),
                          _buildMetaItem(context, 'Keywords', post.keywords),
                          _buildMetaItem(context, 'Author', post.author),
                          _buildMetaItem(context, 'Published Date', post.publishedDate.toIso8601String()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    Text(
                      post.content,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Card explaining blog SEO implementation
class BlogSeoGuideCard extends StatelessWidget {
  const BlogSeoGuideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📚 Blog SEO Implementation Guide',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildGuideSection(
              context,
              '1. Dynamic Meta Tags',
              'Update meta tags when a blog post is opened',
              Icons.edit,
              Colors.blue,
            ),
            _buildGuideSection(
              context,
              '2. Structured Data',
              'Add JSON-LD schema for rich snippets',
              Icons.code,
              Colors.green,
            ),
            _buildGuideSection(
              context,
              '3. Unique URLs',
              'Each post should have a unique, SEO-friendly URL slug',
              Icons.link,
              Colors.purple,
            ),
            _buildGuideSection(
              context,
              '4. Social Sharing',
              'Optimize Open Graph tags for social media',
              Icons.share,
              Colors.orange,
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
                    '💻 Example Code',
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
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        '''
// Update meta tags for blog post
final seoConfig = SeoConfig(
  title: '\${post.title} | Blog',
  description: post.description,
  keywords: post.keywords,
  author: post.author,
  ogTitle: post.title,
  ogDescription: post.description,
  ogImage: post.imageUrl,
);
SeoUtils.updateMetaTags(seoConfig);

// Add structured data
final schema = SeoUtils.generateBlogPostSchema(
  title: post.title,
  description: post.description,
  author: post.author,
  publishedDate: post.publishedDate,
  imageUrl: post.imageUrl,
);
SeoUtils.injectStructuredData(schema);
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideSection(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
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

