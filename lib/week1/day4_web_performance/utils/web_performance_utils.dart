import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:math';
import 'package:flutter/foundation.dart';

/// Utilities for web performance optimization and measurement
class WebPerformanceUtils {
  /// Get real performance metrics from the browser
  static Future<Map<String, double>> getRealPerformanceMetrics({
    required String rendererType,
  }) async {
    if (!kIsWeb) {
      // Fallback to simulation on non-web platforms
      return simulatePerformanceMetrics(rendererType: rendererType);
    }

    try {
      final metrics = <String, double>{};
      
      // Get Navigation Timing API data
      final navigationTiming = _getNavigationTiming();
      metrics.addAll(navigationTiming);
      
      // Get Memory API data (if available)
      final memoryInfo = _getMemoryInfo();
      metrics.addAll(memoryInfo);
      
      // Get Paint Timing API data
      final paintTiming = _getPaintTiming();
      metrics.addAll(paintTiming);
      
      // Get current renderer information
      final rendererInfo = _getRendererInfo();
      metrics.addAll(rendererInfo);
      
      // Calculate FPS using requestAnimationFrame
      final fps = await _measureFPS();
      metrics['fps'] = fps;
      
      return metrics;
    } catch (e) {
      print('Error getting real performance metrics: $e');
      // Fallback to simulation if real metrics fail
      return simulatePerformanceMetrics(rendererType: rendererType);
    }
  }

  /// Simulate performance metrics for demonstration (fallback)
  static Future<Map<String, double>> simulatePerformanceMetrics({
    required String rendererType,
  }) async {
    // Simulate measurement delay
    await Future.delayed(const Duration(milliseconds: 500));

    final random = Random();
    
    // Simulate different performance characteristics for each renderer
    if (rendererType == 'CanvasKit') {
      return {
        'loadTime': 800 + random.nextDouble() * 400, // 800-1200ms
        'renderTime': 12 + random.nextDouble() * 8, // 12-20ms
        'memoryUsage': 45 + random.nextDouble() * 25, // 45-70MB
        'fps': (55 + random.nextDouble() * 10).roundToDouble(), // 55-65fps
      };
    } else {
      // HTML renderer
      return {
        'loadTime': 600 + random.nextDouble() * 300, // 600-900ms
        'renderTime': 8 + random.nextDouble() * 6, // 8-14ms
        'memoryUsage': 25 + random.nextDouble() * 20, // 25-45MB
        'fps': (58 + random.nextDouble() * 7).roundToDouble(), // 58-65fps
      };
    }
  }

  /// Get Navigation Timing API data
  static Map<String, double> _getNavigationTiming() {
    try {
      final performance = html.window.performance;
      final timing = performance.timing;
      
      final navigationStart = timing.navigationStart.toDouble();
      final loadEventEnd = timing.loadEventEnd.toDouble();
      final domContentLoadedEventEnd = timing.domContentLoadedEventEnd.toDouble();
      final responseEnd = timing.responseEnd.toDouble();
        
      return {
        'loadTime': loadEventEnd - navigationStart,
        'domContentLoaded': domContentLoadedEventEnd - navigationStart,
        'responseTime': responseEnd - navigationStart,
      };
    } catch (e) {
      print('Navigation timing not available: $e');
    }
    
    return {
      'loadTime': 1000.0,
      'domContentLoaded': 800.0,
      'responseTime': 500.0,
    };
  }

  /// Get Memory API data
  static Map<String, double> _getMemoryInfo() {
    try {
      // Check if memory API is available
      if (js.context.hasProperty('performance') && 
          js.context['performance'].hasProperty('memory')) {
        final memory = js.context['performance']['memory'];
        
        final usedJSHeapSize = (memory['usedJSHeapSize'] as num?)?.toDouble() ?? 0;
        final totalJSHeapSize = (memory['totalJSHeapSize'] as num?)?.toDouble() ?? 0;
        
        return {
          'memoryUsage': usedJSHeapSize / (1024 * 1024), // Convert to MB
          'totalMemory': totalJSHeapSize / (1024 * 1024), // Convert to MB
        };
      }
    } catch (e) {
      print('Memory API not available: $e');
    }
    
    return {
      'memoryUsage': 35.0, // Default fallback
      'totalMemory': 100.0,
    };
  }

  /// Get Paint Timing API data
  static Map<String, double> _getPaintTiming() {
    try {
      final performance = html.window.performance;
      final entries = performance.getEntriesByType('paint');
      
      double firstPaint = 0;
      double firstContentfulPaint = 0;
      
      for (final entry in entries) {
        if (entry.name == 'first-paint') {
          firstPaint = entry.startTime.toDouble();
        } else if (entry.name == 'first-contentful-paint') {
          firstContentfulPaint = entry.startTime.toDouble();
        }
      }
      
      return {
        'firstPaint': firstPaint,
        'firstContentfulPaint': firstContentfulPaint,
        'renderTime': firstContentfulPaint > 0 ? firstContentfulPaint : 16.67, // 60fps baseline
      };
    } catch (e) {
      print('Paint timing not available: $e');
    }
    
    return {
      'firstPaint': 100.0,
      'firstContentfulPaint': 200.0,
      'renderTime': 16.67,
    };
  }

  /// Get renderer information
  static Map<String, double> _getRendererInfo() {
    try {
      // Try to detect the current renderer
      final canvas = html.CanvasElement();
      final context = canvas.getContext('webgl2') ?? canvas.getContext('webgl');
      
      if (context != null) {
        // WebGL is available, likely CanvasKit
        try {
          final renderer = (context as dynamic).getParameter(0x1F01); // GL_RENDERER
          final vendor = (context as dynamic).getParameter(0x1F00); // GL_VENDOR
          print('Renderer: $renderer, Vendor: $vendor');
        } catch (e) {
          print('WebGL parameter access failed: $e');
        }
        
        // CanvasKit typically has better performance for complex graphics
        return {
          'rendererScore': 85.0, // CanvasKit score
          'graphicsScore': 90.0,
        };
      } else {
        // No WebGL, likely HTML renderer
        return {
          'rendererScore': 75.0, // HTML renderer score
          'graphicsScore': 70.0,
        };
      }
    } catch (e) {
      print('Renderer detection failed: $e');
    }
    
    return {
      'rendererScore': 80.0,
      'graphicsScore': 80.0,
    };
  }

  /// Measure FPS using requestAnimationFrame
  static Future<double> _measureFPS() async {
    final completer = Completer<double>();
    int frameCount = 0;
    late int startTime;
    late int lastTime;
    
    void frame(num currentTime) {
      if (frameCount == 0) {
        startTime = currentTime.round();
        lastTime = startTime;
      }
      
      frameCount++;
      lastTime = currentTime.round();
      
      // Measure for 1 second
      if (currentTime - startTime >= 1000) {
        final fps = frameCount * 1000 / (lastTime - startTime);
        completer.complete(fps);
        return;
      }
      
      html.window.requestAnimationFrame(frame);
    }
    
    try {
      html.window.requestAnimationFrame(frame);
      
      // Timeout after 2 seconds
      Timer(const Duration(seconds: 2), () {
        if (!completer.isCompleted) {
          completer.complete(60.0); // Default FPS
        }
      });
      
      return await completer.future;
    } catch (e) {
      print('FPS measurement failed: $e');
      return 60.0; // Default FPS
    }
  }

  /// Get current renderer type (web only)
  static String getCurrentRenderer() {
    if (kIsWeb) {
      try {
        // Check Flutter configuration first
        if (js.context.hasProperty('flutterConfiguration') && 
            js.context['flutterConfiguration'].hasProperty('renderer')) {
          final renderer = js.context['flutterConfiguration']['renderer'] as String?;
          if (renderer == 'html') {
            return 'HTML (DOM)';
          } else if (renderer == 'canvaskit') {
            return 'CanvasKit (WebGL)';
          }
        }
        
        // Check for CanvasKit specific indicators
        if (js.context.hasProperty('flutterCanvasKit')) {
          return 'CanvasKit (WebGL)';
        }
        
        // Check for HTML renderer indicators
        final flutterView = html.document.querySelector('flutter-view');
        if (flutterView != null) {
          return 'HTML (DOM)';
        }
        
        // Check for WebGL support (CanvasKit uses WebGL)
        final canvas = html.CanvasElement();
        final webglContext = canvas.getContext('webgl') ?? canvas.getContext('webgl2');
        
        if (webglContext != null) {
          // Check if Flutter is using WebGL for rendering
          try {
            final renderer = (webglContext as dynamic).getParameter(0x1F01); // GL_RENDERER
            if (renderer != null && renderer.toString().isNotEmpty) {
              // Additional check: see if Flutter is actually using this WebGL context
              if (js.context.hasProperty('flutterCanvasKit') || 
                  html.document.querySelector('canvas[data-flutter-renderer="canvaskit"]') != null) {
                return 'CanvasKit (WebGL)';
              }
            }
          } catch (e) {
            print('WebGL renderer detection failed: $e');
          }
        }
        
        // Check for HTML renderer by looking at DOM structure
        final body = html.document.body;
        if (body != null) {
          // HTML renderer typically creates more DOM elements
          final canvasElements = body.querySelectorAll('canvas');
          final divElements = body.querySelectorAll('div');
          
          // If there are many divs and few canvases, likely HTML renderer
          if (divElements.length > 10 && canvasElements.length < 3) {
            return 'HTML (DOM)';
          }
        }
        
        // Default to HTML if no clear CanvasKit indicators
        return 'HTML (DOM)';
      } catch (e) {
        print('Renderer detection error: $e');
        return 'Unknown';
      }
    }
    return 'Native (Mobile/Desktop)';
  }

  /// Create a comprehensive renderer test
  static Future<Map<String, dynamic>> createRendererTest() async {
    if (!kIsWeb) {
      return {
        'error': 'Renderer testing is only available on web platform',
        'currentRenderer': 'Native',
      };
    }

    try {
      final currentRenderer = getCurrentRenderer();
      final realMetrics = await getRealPerformanceMetrics(rendererType: currentRenderer);
      
      return {
        'currentRenderer': currentRenderer,
        'metrics': realMetrics,
        'browserInfo': {
          'userAgent': html.window.navigator.userAgent,
          'platform': html.window.navigator.platform,
          'language': html.window.navigator.language,
          'cookieEnabled': html.window.navigator.cookieEnabled,
          'onLine': html.window.navigator.onLine,
        },
        'screenInfo': {
          'width': html.window.screen?.width,
          'height': html.window.screen?.height,
          'pixelDepth': html.window.screen?.pixelDepth,
          'colorDepth': html.window.screen?.colorDepth,
        },
        'performanceInfo': {
          'hardwareConcurrency': html.window.navigator.hardwareConcurrency,
          'deviceMemory': _getDeviceMemory(),
          'connection': _getConnectionInfo(),
        },
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'error': 'Failed to create renderer test: $e',
        'currentRenderer': 'Unknown',
      };
    }
  }

  /// Force refresh renderer detection
  static String forceRefreshRendererDetection() {
    if (!kIsWeb) return 'Native (Mobile/Desktop)';
    
    try {
      // Clear any cached detection
      final currentRenderer = getCurrentRenderer();
      
      // Additional check for Flutter configuration
      if (js.context.hasProperty('flutterConfiguration')) {
        final config = js.context['flutterConfiguration'];
        if (config.hasProperty('renderer')) {
          final renderer = config['renderer'] as String?;
          print('Flutter configuration renderer: $renderer');
          if (renderer == 'html') {
            return 'HTML (DOM)';
          }
        }
      }
      
      // Check for CanvasKit specific elements
      final canvaskitElements = html.document.querySelectorAll('[data-flutter-renderer="canvaskit"]');
      if (canvaskitElements.isNotEmpty) {
        return 'CanvasKit (WebGL)';
      }
      
      // Check for HTML renderer elements
      final htmlElements = html.document.querySelectorAll('[data-flutter-renderer="html"]');
      if (htmlElements.isNotEmpty) {
        return 'HTML (DOM)';
      }
      
      return currentRenderer;
    } catch (e) {
      print('Force refresh renderer detection error: $e');
      return 'Unknown';
    }
  }

  /// Get device memory information
  static double _getDeviceMemory() {
    try {
      if (js.context['navigator'].hasProperty('deviceMemory')) {
        return (js.context['navigator']['deviceMemory'] as num?)?.toDouble() ?? 4.0;
      }
    } catch (e) {
      print('Device memory not available: $e');
    }
    return 4.0; // Default fallback
  }

  /// Get connection information
  static Map<String, dynamic> _getConnectionInfo() {
    try {
      if (js.context['navigator'].hasProperty('connection')) {
        final connection = js.context['navigator']['connection'];
        return {
          'effectiveType': connection['effectiveType'] ?? 'unknown',
          'downlink': (connection['downlink'] as num?)?.toDouble() ?? 10.0,
          'rtt': (connection['rtt'] as num?)?.toDouble() ?? 100.0,
        };
      }
    } catch (e) {
      print('Connection info not available: $e');
    }
    return {
      'effectiveType': 'unknown',
      'downlink': 10.0,
      'rtt': 100.0,
    };
  }

  /// Check if WebP is supported
  static bool isWebPSupported() {
    // In a real implementation, you'd check browser support
    // For demonstration, we'll assume modern browsers support WebP
    return kIsWeb;
  }

  /// Calculate image compression benefits
  static Map<String, dynamic> calculateImageOptimization({
    required String format,
    required int originalSize,
  }) {
    double compressionRatio;
    String recommendedFormat;
    
    switch (format.toLowerCase()) {
      case 'png':
        compressionRatio = 0.3; // WebP can reduce PNG by ~70%
        recommendedFormat = 'WebP';
        break;
      case 'jpg':
      case 'jpeg':
        compressionRatio = 0.25; // WebP can reduce JPEG by ~75%
        recommendedFormat = 'WebP';
        break;
      case 'webp':
        compressionRatio = 1.0; // Already optimized
        recommendedFormat = 'WebP (already optimal)';
        break;
      default:
        compressionRatio = 0.5;
        recommendedFormat = 'WebP';
    }

    final optimizedSize = (originalSize * compressionRatio).round();
    final spaceSaved = originalSize - optimizedSize;
    final spaceSavedPercentage = (spaceSaved / originalSize) * 100;

    return {
      'originalSize': originalSize,
      'optimizedSize': optimizedSize,
      'spaceSaved': spaceSaved,
      'spaceSavedPercentage': spaceSavedPercentage,
      'recommendedFormat': recommendedFormat,
      'compressionRatio': compressionRatio,
    };
  }

  /// Format bytes to human readable string
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }

  /// Simulate deferred loading delay
  static Future<void> simulateDeferredLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Performance optimization tips
  static List<Map<String, String>> getOptimizationTips() {
    return [
      {
        'title': 'Use Deferred Components',
        'description': 'Load non-critical components only when needed to reduce initial bundle size.',
        'impact': 'High',
        'difficulty': 'Medium',
      },
      {
        'title': 'Optimize Images',
        'description': 'Use WebP format and appropriate compression levels for faster loading.',
        'impact': 'High',
        'difficulty': 'Low',
      },
      {
        'title': 'Implement Lazy Loading',
        'description': 'Load content progressively as users scroll or interact.',
        'impact': 'Medium',
        'difficulty': 'Medium',
      },
      {
        'title': 'Choose Right Renderer',
        'description': 'Select CanvasKit for complex graphics, HTML for simple UIs.',
        'impact': 'Medium',
        'difficulty': 'Low',
      },
      {
        'title': 'Minimize Bundle Size',
        'description': 'Use tree shaking and code splitting to reduce JavaScript bundle size.',
        'impact': 'High',
        'difficulty': 'High',
      },
      {
        'title': 'Optimize Fonts',
        'description': 'Use web fonts efficiently and consider font loading strategies.',
        'impact': 'Low',
        'difficulty': 'Low',
      },
    ];
  }

  /// Get renderer comparison data
  static Map<String, Map<String, dynamic>> getRendererComparison() {
    return {
      'CanvasKit': {
        'description': 'Uses WebAssembly for consistent rendering across platforms',
        'pros': [
          'Pixel-perfect rendering',
          'Consistent across browsers',
          'Better for complex graphics',
          'Full Flutter widget support',
          'Better performance for animations',
        ],
        'cons': [
          'Larger bundle size (~2MB)',
          'Slower initial load',
          'Higher memory usage',
          'Less accessible to screen readers',
          'No native text selection',
        ],
        'bestFor': [
          'Complex UIs with custom graphics',
          'Games and interactive applications',
          'Apps requiring pixel-perfect rendering',
          'Heavy animation usage',
        ],
        'performance': {
          'bundleSize': '~2MB',
          'loadTime': 'Slower',
          'renderPerformance': 'Excellent',
          'memoryUsage': 'Higher',
          'accessibility': 'Limited',
        },
      },
      'HTML': {
        'description': 'Uses DOM elements for rendering Flutter widgets',
        'pros': [
          'Smaller bundle size (~1MB)',
          'Faster initial load',
          'Better accessibility',
          'Native text selection',
          'SEO friendly',
        ],
        'cons': [
          'Potential rendering differences',
          'Limited custom painting',
          'Performance varies by browser',
          'Some widgets not supported',
          'Complex layouts may be slower',
        ],
        'bestFor': [
          'Content-heavy applications',
          'Forms and text-based UIs',
          'SEO-critical applications',
          'Accessibility-first apps',
        ],
        'performance': {
          'bundleSize': '~1MB',
          'loadTime': 'Faster',
          'renderPerformance': 'Good',
          'memoryUsage': 'Lower',
          'accessibility': 'Excellent',
        },
      },
    };
  }
}

/// Lazy loading controller for managing deferred content
class LazyLoadingController {
  final Map<String, bool> _loadedComponents = {};
  final Map<String, Completer<void>> _loadingCompleters = {};

  /// Check if a component is loaded
  bool isComponentLoaded(String componentId) {
    return _loadedComponents[componentId] ?? false;
  }

  /// Load a component with simulated delay
  Future<void> loadComponent(String componentId) async {
    if (_loadedComponents[componentId] == true) {
      return; // Already loaded
    }

    if (_loadingCompleters.containsKey(componentId)) {
      return _loadingCompleters[componentId]!.future;
    }

    final completer = Completer<void>();
    _loadingCompleters[componentId] = completer;

    try {
      // Simulate loading time
      await Future.delayed(const Duration(milliseconds: 800));
      _loadedComponents[componentId] = true;
      completer.complete();
    } catch (e) {
      completer.completeError(e);
    } finally {
      _loadingCompleters.remove(componentId);
    }
  }

  /// Reset all loaded components
  void reset() {
    _loadedComponents.clear();
    _loadingCompleters.clear();
  }

  /// Get loading progress (0.0 to 1.0)
  double getLoadingProgress(List<String> componentIds) {
    if (componentIds.isEmpty) return 1.0;
    
    int loadedCount = 0;
    for (final id in componentIds) {
      if (isComponentLoaded(id)) {
        loadedCount++;
      }
    }
    
    return loadedCount / componentIds.length;
  }
}
