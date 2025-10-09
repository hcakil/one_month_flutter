/// Model for SEO configuration
class SeoConfig {
  final String title;
  final String description;
  final String keywords;
  final String author;
  final String ogTitle;
  final String ogDescription;
  final String ogImage;
  final String twitterCard;
  final String canonicalUrl;

  const SeoConfig({
    required this.title,
    required this.description,
    this.keywords = '',
    this.author = '',
    this.ogTitle = '',
    this.ogDescription = '',
    this.ogImage = '',
    this.twitterCard = 'summary_large_image',
    this.canonicalUrl = '',
  });

  SeoConfig copyWith({
    String? title,
    String? description,
    String? keywords,
    String? author,
    String? ogTitle,
    String? ogDescription,
    String? ogImage,
    String? twitterCard,
    String? canonicalUrl,
  }) {
    return SeoConfig(
      title: title ?? this.title,
      description: description ?? this.description,
      keywords: keywords ?? this.keywords,
      author: author ?? this.author,
      ogTitle: ogTitle ?? this.ogTitle,
      ogDescription: ogDescription ?? this.ogDescription,
      ogImage: ogImage ?? this.ogImage,
      twitterCard: twitterCard ?? this.twitterCard,
      canonicalUrl: canonicalUrl ?? this.canonicalUrl,
    );
  }

  Map<String, String> toMetaTags() {
    return {
      'title': title,
      'description': description,
      if (keywords.isNotEmpty) 'keywords': keywords,
      if (author.isNotEmpty) 'author': author,
      'og:title': ogTitle.isNotEmpty ? ogTitle : title,
      'og:description': ogDescription.isNotEmpty ? ogDescription : description,
      if (ogImage.isNotEmpty) 'og:image': ogImage,
      'twitter:card': twitterCard,
      'twitter:title': ogTitle.isNotEmpty ? ogTitle : title,
      'twitter:description': ogDescription.isNotEmpty ? ogDescription : description,
      if (canonicalUrl.isNotEmpty) 'canonical': canonicalUrl,
    };
  }
}

