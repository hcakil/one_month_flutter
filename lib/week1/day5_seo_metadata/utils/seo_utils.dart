import 'dart:html' as html;
import '../models/seo_config.dart';

/// Utility class for SEO operations
class SeoUtils {
  /// Updates the page title
  static void updateTitle(String title) {
    html.document.title = title;
  }

  /// Updates meta tags based on SEO configuration
  static void updateMetaTags(SeoConfig config) {
    // Update title
    updateTitle(config.title);

    // Update or create meta tags
    final metaTags = config.toMetaTags();

    metaTags.forEach((name, content) {
      if (name == 'title') {
        updateTitle(content);
      } else if (name == 'canonical') {
        _updateCanonicalLink(content);
      } else if (name.startsWith('og:')) {
        _updateMetaTag(name, content, isProperty: true);
      } else if (name.startsWith('twitter:')) {
        _updateMetaTag(name, content);
      } else {
        _updateMetaTag(name, content);
      }
    });
  }

  /// Updates or creates a meta tag
  static void _updateMetaTag(String name, String content, {bool isProperty = false}) {
    final attribute = isProperty ? 'property' : 'name';
    final selector = '[$attribute="$name"]';

    // Try to find existing tag
    html.MetaElement? metaTag = html.document.querySelector('meta$selector') as html.MetaElement?;

    if (metaTag == null) {
      // Create new meta tag
      metaTag = html.MetaElement();
      if (isProperty) {
        metaTag.setAttribute('property', name);
      } else {
        metaTag.setAttribute('name', name);
      }
      html.document.head?.append(metaTag);
    }

    // Update content
    metaTag.content = content;
  }

  /// Updates the canonical link
  static void _updateCanonicalLink(String url) {
    html.LinkElement? canonicalLink = html.document.querySelector('link[rel="canonical"]') as html.LinkElement?;

    if (canonicalLink == null) {
      canonicalLink = html.LinkElement();
      canonicalLink.rel = 'canonical';
      html.document.head?.append(canonicalLink);
    }

    canonicalLink.href = url;
  }

  /// Generates SEO config from route
  static SeoConfig getSeoConfigForRoute(String route, {Map<String, dynamic>? params}) {
    switch (route) {
      case '/week1/day5':
        return const SeoConfig(
          title: 'Day 5: SEO & Web Metadata | One Month Flutter',
          description: 'Learn SEO optimization and web metadata management for Flutter Web applications.',
          keywords: 'Flutter, Web, SEO, Metadata, Optimization',
          author: 'Flutter Dev Team',
        );
      case '/week1/day5/blog':
        return const SeoConfig(
          title: 'Blog | SEO & Metadata Guide',
          description: 'Read comprehensive guides about SEO, meta tags, and web optimization for Flutter applications.',
          keywords: 'Blog, SEO, Flutter Web, Meta Tags, Tutorials',
        );
      case '/week1/day5/notes':
        return const SeoConfig(
          title: 'My Notes | Learning Tracker',
          description: 'Personal notes and learning progress for SEO and web metadata optimization.',
          keywords: 'Notes, Learning, SEO, Progress Tracking',
        );
      default:
        return const SeoConfig(
          title: 'One Month Flutter | Web Development Learning',
          description: '30-day comprehensive Flutter web development learning journey with hands-on projects.',
          keywords: 'Flutter, Web Development, Learning, Tutorial',
        );
    }
  }

  /// Generates structured data (JSON-LD) for a blog post
  static String generateBlogPostSchema({
    required String title,
    required String description,
    required String author,
    required DateTime publishedDate,
    required String imageUrl,
    String? url,
  }) {
    return '''
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "$title",
  "description": "$description",
  "author": {
    "@type": "Person",
    "name": "$author"
  },
  "datePublished": "${publishedDate.toIso8601String()}",
  "image": "$imageUrl"
  ${url != null ? ',"url": "$url"' : ''}
}
''';
  }

  /// Injects structured data script into the page
  static void injectStructuredData(String jsonLd) {
    // Remove existing structured data
    final existingScript = html.document.querySelector('script[type="application/ld+json"]');
    existingScript?.remove();

    // Create new script element
    final script = html.ScriptElement();
    script.type = 'application/ld+json';
    script.text = jsonLd;

    // Append to head
    html.document.head?.append(script);
  }

  /// Validates SEO configuration
  static Map<String, dynamic> validateSeoConfig(SeoConfig config) {
    final issues = <String>[];
    final warnings = <String>[];

    // Check title length
    if (config.title.isEmpty) {
      issues.add('Title is required');
    } else if (config.title.length > 60) {
      warnings.add('Title is longer than 60 characters (${config.title.length})');
    } else if (config.title.length < 30) {
      warnings.add('Title is shorter than 30 characters (${config.title.length})');
    }

    // Check description length
    if (config.description.isEmpty) {
      issues.add('Description is required');
    } else if (config.description.length > 160) {
      warnings.add('Description is longer than 160 characters (${config.description.length})');
    } else if (config.description.length < 120) {
      warnings.add('Description is shorter than 120 characters (${config.description.length})');
    }

    // Check keywords
    if (config.keywords.isEmpty) {
      warnings.add('Keywords are recommended');
    }

    // Check Open Graph tags
    if (config.ogImage.isEmpty) {
      warnings.add('Open Graph image is recommended for social sharing');
    }

    return {
      'isValid': issues.isEmpty,
      'issues': issues,
      'warnings': warnings,
      'score': _calculateSeoScore(config, issues, warnings),
    };
  }

  /// Calculates SEO score (0-100)
  static int _calculateSeoScore(SeoConfig config, List<String> issues, List<String> warnings) {
    int score = 100;

    // Deduct for issues
    score -= issues.length * 20;

    // Deduct for warnings
    score -= warnings.length * 10;

    // Bonus for complete configuration
    if (config.title.length >= 30 && config.title.length <= 60) score += 5;
    if (config.description.length >= 120 && config.description.length <= 160) score += 5;
    if (config.keywords.isNotEmpty) score += 5;
    if (config.ogImage.isNotEmpty) score += 5;
    if (config.author.isNotEmpty) score += 5;

    return score.clamp(0, 100);
  }

  /// Gets SEO best practices
  static List<Map<String, String>> getSeoTips() {
    return [
      {
        'title': 'Optimize Page Titles',
        'description': 'Keep titles between 30-60 characters, include primary keywords, and make them compelling.',
        'category': 'Meta Tags',
      },
      {
        'title': 'Write Compelling Meta Descriptions',
        'description': 'Aim for 120-160 characters, include call-to-action, and accurately describe page content.',
        'category': 'Meta Tags',
      },
      {
        'title': 'Use Relevant Keywords',
        'description': 'Research and include keywords naturally in content, titles, and meta tags.',
        'category': 'Content',
      },
      {
        'title': 'Implement Structured Data',
        'description': 'Use JSON-LD for rich snippets in search results (breadcrumbs, reviews, etc.).',
        'category': 'Technical',
      },
      {
        'title': 'Optimize Images',
        'description': 'Use descriptive file names, alt text, and modern formats like WebP.',
        'category': 'Content',
      },
      {
        'title': 'Mobile Responsiveness',
        'description': 'Ensure your site works perfectly on all devices and screen sizes.',
        'category': 'Technical',
      },
      {
        'title': 'Page Load Speed',
        'description': 'Optimize performance with lazy loading, code splitting, and compression.',
        'category': 'Performance',
      },
      {
        'title': 'Social Media Integration',
        'description': 'Implement Open Graph and Twitter Card tags for better social sharing.',
        'category': 'Social',
      },
    ];
  }

  /// Gets route-based title templates
  static Map<String, String> getRouteTitleTemplates() {
    return {
      '/': 'Home | One Month Flutter',
      '/week1/day1': 'Day 1: Flutter Updates | One Month Flutter',
      '/week1/day2': 'Day 2: Riverpod State Management | One Month Flutter',
      '/week1/day3': 'Day 3: Responsive Layout | One Month Flutter',
      '/week1/day4': 'Day 4: Web Performance | One Month Flutter',
      '/week1/day5': 'Day 5: SEO & Metadata | One Month Flutter',
      '/week1/day6': 'Day 6: Mini Project | One Month Flutter',
    };
  }
}

