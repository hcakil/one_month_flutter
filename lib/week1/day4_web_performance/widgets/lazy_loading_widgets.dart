import 'package:flutter/material.dart';
import '../utils/web_performance_utils.dart';

/// Main lazy loading overview card
class LazyLoadingOverviewCard extends StatelessWidget {
  const LazyLoadingOverviewCard({super.key});

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
                  Icons.hourglass_empty,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '⏳ Lazy Loading Implementation (30 min)',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Lazy loading defers the loading of non-critical resources until they are needed, improving initial page load performance and reducing bandwidth usage.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _buildLazyLoadingBenefits(context),
            const SizedBox(height: 16),
            _buildImplementationStrategies(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLazyLoadingBenefits(BuildContext context) {
    final benefits = [
      {'title': 'Faster Initial Load', 'description': 'Reduce time to first contentful paint'},
      {'title': 'Reduced Bandwidth', 'description': 'Load only what users actually see'},
      {'title': 'Better Performance', 'description': 'Improved Core Web Vitals scores'},
      {'title': 'Progressive Enhancement', 'description': 'Content loads as users interact'},
      {'title': 'Resource Efficiency', 'description': 'Optimal memory and network usage'},
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
            '🚀 Lazy Loading Benefits',
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

  Widget _buildImplementationStrategies(BuildContext context) {
    final strategies = [
      'Intersection Observer for viewport detection',
      'Progressive image loading with placeholders',
      'Component-based lazy loading',
      'Infinite scroll implementation',
      'Preloading for anticipated user actions',
    ];

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
            '🛠️ Implementation Strategies',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          ...strategies.map((strategy) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    strategy,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
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

/// Interactive lazy loading demo with images
class LazyImageLoadingDemoCard extends StatefulWidget {
  const LazyImageLoadingDemoCard({super.key});

  @override
  State<LazyImageLoadingDemoCard> createState() => _LazyImageLoadingDemoCardState();
}

class _LazyImageLoadingDemoCardState extends State<LazyImageLoadingDemoCard> {
  final ScrollController _scrollController = ScrollController();
  final List<bool> _imageLoaded = List.filled(20, false);
  int _visibleImages = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load first few images immediately
    for (int i = 0; i < 3; i++) {
      _imageLoaded[i] = true;
    }
    _visibleImages = 3;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrollPosition = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final threshold = maxScroll * 0.8; // Load more when 80% scrolled

    if (scrollPosition > threshold && _visibleImages < _imageLoaded.length) {
      setState(() {
        // Load next batch of images
        final nextBatch = (_visibleImages + 3).clamp(0, _imageLoaded.length);
        for (int i = _visibleImages; i < nextBatch; i++) {
          _imageLoaded[i] = true;
        }
        _visibleImages = nextBatch;
      });
    }
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
                  Icons.photo_library,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Lazy Image Loading Demo',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Scroll down to see images load progressively. Notice how images only load when they come into view or are about to be visible.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            _buildLoadingStats(),
            const SizedBox(height: 16),
            _buildImageGrid(),
            const SizedBox(height: 16),
            _buildResetButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingStats() {
    final loadedCount = _imageLoaded.where((loaded) => loaded).length;
    final totalCount = _imageLoaded.length;
    final percentage = (loadedCount / totalCount * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Loading Progress',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: loadedCount / totalCount,
                  backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$loadedCount of $totalCount images loaded ($percentage%)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              Icon(
                Icons.data_usage,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 4),
              Text(
                '~${(loadedCount * 0.5).toStringAsFixed(1)}MB',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Data Used',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
        ),
        itemCount: _imageLoaded.length,
        itemBuilder: (context, index) {
          return _LazyImageCard(
            index: index,
            isLoaded: _imageLoaded[index],
            onLoad: () => _loadImage(index),
          );
        },
      ),
    );
  }

  Widget _buildResetButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _resetDemo,
        icon: const Icon(Icons.refresh),
        label: const Text('Reset Demo'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  void _loadImage(int index) {
    if (!_imageLoaded[index]) {
      setState(() {
        _imageLoaded[index] = true;
      });
    }
  }

  void _resetDemo() {
    setState(() {
      _imageLoaded.fillRange(0, _imageLoaded.length, false);
      // Load first few images immediately
      for (int i = 0; i < 3; i++) {
        _imageLoaded[i] = true;
      }
      _visibleImages = 3;
    });
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

/// Individual lazy loading image card
class _LazyImageCard extends StatefulWidget {
  final int index;
  final bool isLoaded;
  final VoidCallback onLoad;

  const _LazyImageCard({
    required this.index,
    required this.isLoaded,
    required this.onLoad,
  });

  @override
  State<_LazyImageCard> createState() => _LazyImageCardState();
}

class _LazyImageCardState extends State<_LazyImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    if (widget.isLoaded) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(_LazyImageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoaded && !oldWidget.isLoaded) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoaded ? null : _simulateLoad,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.isLoaded 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        child: widget.isLoaded
            ? _buildLoadedImage()
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildLoadedImage() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Container(
              color: _getImageColor(),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Image ${widget.index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isLoading)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    Icon(
                      Icons.image_not_supported,
                      size: 32,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  const SizedBox(height: 8),
                  Text(
                    _isLoading ? 'Loading...' : 'Tap to Load',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Image ${widget.index + 1}',
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getImageColor() {
    final colors = [
      Colors.blue.shade400,
      Colors.green.shade400,
      Colors.orange.shade400,
      Colors.purple.shade400,
      Colors.red.shade400,
      Colors.teal.shade400,
    ];
    return colors[widget.index % colors.length];
  }

  Future<void> _simulateLoad() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      widget.onLoad();
    }
  }
}

/// Lazy loading component demo
class LazyComponentLoadingDemoCard extends StatefulWidget {
  const LazyComponentLoadingDemoCard({super.key});

  @override
  State<LazyComponentLoadingDemoCard> createState() => _LazyComponentLoadingDemoCardState();
}

class _LazyComponentLoadingDemoCardState extends State<LazyComponentLoadingDemoCard> {
  final LazyLoadingController _controller = LazyLoadingController();
  final List<String> _components = [
    'user_profile',
    'analytics_dashboard',
    'chat_widget',
    'notification_center',
    'settings_panel',
  ];

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
                  Icons.widgets,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Lazy Component Loading Demo',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Click on components below to simulate lazy loading of different UI components. Each component loads independently when needed.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            _buildComponentsList(),
            const SizedBox(height: 20),
            _buildResetButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentsList() {
    return Column(
      children: _components.map((componentId) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 100)),
            builder: (context, snapshot) {
              final isLoaded = _controller.isComponentLoaded(componentId);
              return _LazyComponentCard(
                componentId: componentId,
                isLoaded: isLoaded,
                onLoad: () => _loadComponent(componentId),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildResetButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            _controller.reset();
          });
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Reset All Components'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Future<void> _loadComponent(String componentId) async {
    await _controller.loadComponent(componentId);
    if (mounted) {
      setState(() {});
    }
  }
}

/// Individual lazy loading component card
class _LazyComponentCard extends StatelessWidget {
  final String componentId;
  final bool isLoaded;
  final VoidCallback onLoad;

  const _LazyComponentCard({
    required this.componentId,
    required this.isLoaded,
    required this.onLoad,
  });

  @override
  Widget build(BuildContext context) {
    final componentInfo = _getComponentInfo(componentId);

    return Card(
      elevation: isLoaded ? 4 : 1,
      child: InkWell(
        onTap: isLoaded ? null : onLoad,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isLoaded 
                ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isLoaded 
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  componentInfo['icon'] as IconData,
                  size: 24,
                  color: isLoaded 
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      componentInfo['title'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isLoaded 
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      componentInfo['description'] as String,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Size: ${componentInfo['size']}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Load Time: ${componentInfo['loadTime']}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (isLoaded)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                )
              else
                Icon(
                  Icons.download,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getComponentInfo(String componentId) {
    final componentData = {
      'user_profile': {
        'title': 'User Profile',
        'description': 'Complete user profile with avatar and details',
        'icon': Icons.person,
        'size': '~45KB',
        'loadTime': '~300ms',
      },
      'analytics_dashboard': {
        'title': 'Analytics Dashboard',
        'description': 'Charts and metrics visualization',
        'icon': Icons.analytics,
        'size': '~120KB',
        'loadTime': '~600ms',
      },
      'chat_widget': {
        'title': 'Chat Widget',
        'description': 'Real-time messaging interface',
        'icon': Icons.chat,
        'size': '~80KB',
        'loadTime': '~400ms',
      },
      'notification_center': {
        'title': 'Notification Center',
        'description': 'Push notifications and alerts',
        'icon': Icons.notifications,
        'size': '~35KB',
        'loadTime': '~250ms',
      },
      'settings_panel': {
        'title': 'Settings Panel',
        'description': 'Application configuration options',
        'icon': Icons.settings,
        'size': '~60KB',
        'loadTime': '~350ms',
      },
    };

    return componentData[componentId] ?? {
      'title': 'Unknown Component',
      'description': 'Component details not available',
      'icon': Icons.help,
      'size': '~0KB',
      'loadTime': '~0ms',
    };
  }
}

