/// Model for blog post with SEO metadata
class BlogPost {
  final String id;
  final String title;
  final String description;
  final String content;
  final String author;
  final DateTime publishedDate;
  final List<String> tags;
  final String imageUrl;
  final String slug;
  final int readTimeMinutes;

  const BlogPost({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    required this.publishedDate,
    this.tags = const [],
    this.imageUrl = '',
    required this.slug,
    this.readTimeMinutes = 5,
  });

  String get keywords => tags.join(', ');

  String get formattedDate {
    return '${publishedDate.day}/${publishedDate.month}/${publishedDate.year}';
  }

  // Sample blog posts for demonstration
  static List<BlogPost> getSamplePosts() {
    return [
      BlogPost(
        id: '1',
        title: 'Getting Started with Flutter Web SEO',
        description: 'Learn how to optimize your Flutter web applications for search engines and improve discoverability.',
        content: '''
# Getting Started with Flutter Web SEO

Flutter Web has revolutionized cross-platform development, but SEO optimization remains crucial for web applications. In this comprehensive guide, we'll explore essential SEO techniques for Flutter Web.

## Why SEO Matters for Flutter Web

Search Engine Optimization (SEO) is critical for:
- Improving discoverability
- Increasing organic traffic
- Better user engagement
- Higher conversion rates

## Key SEO Strategies

### 1. Meta Tags
Properly configure meta tags including title, description, and Open Graph tags for social media sharing.

### 2. Semantic HTML
Use semantic HTML elements to help search engines understand your content structure.

### 3. Dynamic Title Updates
Update page titles based on route navigation to reflect current content accurately.

### 4. Image Optimization
Optimize images with proper alt text and lazy loading for better performance and accessibility.

## Best Practices

- Keep titles under 60 characters
- Write compelling meta descriptions (150-160 characters)
- Use relevant keywords naturally
- Ensure mobile responsiveness
- Optimize page load speed

## Conclusion

Implementing proper SEO techniques in Flutter Web applications can significantly improve your online presence and user reach. Start with these fundamentals and continuously monitor and optimize your results.
        ''',
        author: 'Flutter Dev Team',
        publishedDate: DateTime(2024, 10, 1),
        tags: ['Flutter', 'Web', 'SEO', 'Tutorial'],
        imageUrl: 'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png',
        slug: 'getting-started-flutter-web-seo',
        readTimeMinutes: 8,
      ),
      BlogPost(
        id: '2',
        title: 'Meta Tags Best Practices for Web Apps',
        description: 'Deep dive into meta tags, Open Graph protocol, and Twitter Cards for optimal social media sharing.',
        content: '''
# Meta Tags Best Practices for Web Apps

Meta tags are essential HTML elements that provide metadata about your web page. They help search engines and social media platforms understand and display your content correctly.

## Essential Meta Tags

### Basic Meta Tags
- **Title Tag**: The most important on-page SEO element
- **Meta Description**: Brief summary displayed in search results
- **Meta Keywords**: Legacy tag, less important now but still useful

### Open Graph Protocol
Developed by Facebook, Open Graph tags control how your content appears when shared on social media:

- og:title - The title of your page
- og:description - A brief description
- og:image - Featured image URL
- og:url - Canonical URL
- og:type - Type of content (website, article, etc.)

### Twitter Cards
Twitter uses its own meta tags for rich content display:

- twitter:card - Card type (summary, summary_large_image, etc.)
- twitter:title - Title for Twitter
- twitter:description - Description for Twitter
- twitter:image - Image for Twitter preview

## Implementation Tips

1. **Keep it Concise**: Titles should be under 60 characters, descriptions under 160
2. **Be Descriptive**: Clearly explain what users will find on the page
3. **Include Keywords**: Use relevant keywords naturally
4. **Unique Per Page**: Each page should have unique meta tags
5. **Test Your Tags**: Use social media debuggers to verify appearance

## Common Mistakes to Avoid

- Duplicate meta tags across pages
- Missing essential tags
- Too long titles or descriptions
- Generic or irrelevant descriptions
- Broken image URLs

## Conclusion

Properly implemented meta tags can significantly improve your content's visibility and click-through rates on search engines and social media platforms.
        ''',
        author: 'SEO Expert',
        publishedDate: DateTime(2024, 9, 15),
        tags: ['SEO', 'Meta Tags', 'Social Media', 'Best Practices'],
        imageUrl: 'https://via.placeholder.com/800x400/4285F4/FFFFFF?text=Meta+Tags',
        slug: 'meta-tags-best-practices',
        readTimeMinutes: 10,
      ),
      BlogPost(
        id: '3',
        title: 'Dynamic Page Titles in Flutter Web',
        description: 'Implement route-based dynamic page title updates for better SEO and user experience in Flutter Web applications.',
        content: '''
# Dynamic Page Titles in Flutter Web

Dynamic page titles are crucial for SEO and user experience in single-page applications (SPAs) like Flutter Web apps. This guide shows you how to implement them effectively.

## Why Dynamic Titles Matter

1. **SEO Benefits**: Search engines index pages based on titles
2. **User Experience**: Browser tabs show meaningful names
3. **Analytics**: Better tracking of page views
4. **Social Sharing**: Correct titles when sharing links

## Implementation Approaches

### 1. Route-Based Titles
Update titles based on the current route:

```dart
void updateTitle(String route) {
  final title = getTitleForRoute(route);
  html.document.title = title;
}
```

### 2. Using go_router
Integrate with go_router for automatic title updates:

```dart
GoRoute(
  path: '/blog',
  builder: (context, state) => BlogPage(),
  onEnter: (context, state) {
    updateMetaTags(route: '/blog');
  },
)
```

### 3. Provider Pattern
Use state management to centralize title management:

```dart
class TitleProvider extends StateNotifier<String> {
  TitleProvider() : super('Default Title');
  
  void setTitle(String title) {
    state = title;
    html.document.title = title;
  }
}
```

## Best Practices

- Update titles on route changes
- Include brand name consistently
- Keep titles descriptive but concise
- Use separators like " | " or " - "
- Implement fallbacks for undefined routes

## Testing Your Implementation

1. Navigate between routes
2. Check browser tab titles
3. Verify search engine indexing
4. Test with browser history
5. Ensure titles persist on reload

## Advanced Techniques

- Template-based title generation
- Localized titles for multi-language apps
- Dynamic titles from CMS or API data
- Title sanitization and validation

## Conclusion

Dynamic page titles are a fundamental SEO technique that's easy to implement and provides significant benefits for Flutter Web applications.
        ''',
        author: 'Web Developer',
        publishedDate: DateTime(2024, 9, 28),
        tags: ['Flutter', 'Web', 'SEO', 'Dynamic Content', 'Routing'],
        imageUrl: 'https://via.placeholder.com/800x400/0D47A1/FFFFFF?text=Dynamic+Titles',
        slug: 'dynamic-page-titles-flutter-web',
        readTimeMinutes: 7,
      ),
    ];
  }

  static BlogPost? getPostBySlug(String slug) {
    try {
      return getSamplePosts().firstWhere((post) => post.slug == slug);
    } catch (e) {
      return null;
    }
  }
}

