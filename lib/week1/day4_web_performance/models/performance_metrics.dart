/// Performance metrics model for tracking web performance
class PerformanceMetrics {
  final String rendererType;
  final double loadTime;
  final double renderTime;
  final double memoryUsage;
  final int fps;
  final DateTime timestamp;
  final Map<String, dynamic> additionalMetrics;

  const PerformanceMetrics({
    required this.rendererType,
    required this.loadTime,
    required this.renderTime,
    required this.memoryUsage,
    required this.fps,
    required this.timestamp,
    this.additionalMetrics = const {},
  });

  /// Create metrics for CanvasKit renderer
  factory PerformanceMetrics.canvasKit({
    required double loadTime,
    required double renderTime,
    required double memoryUsage,
    required int fps,
    Map<String, dynamic> additionalMetrics = const {},
  }) {
    return PerformanceMetrics(
      rendererType: 'CanvasKit',
      loadTime: loadTime,
      renderTime: renderTime,
      memoryUsage: memoryUsage,
      fps: fps,
      timestamp: DateTime.now(),
      additionalMetrics: additionalMetrics,
    );
  }

  /// Create metrics for HTML renderer
  factory PerformanceMetrics.html({
    required double loadTime,
    required double renderTime,
    required double memoryUsage,
    required int fps,
    Map<String, dynamic> additionalMetrics = const {},
  }) {
    return PerformanceMetrics(
      rendererType: 'HTML',
      loadTime: loadTime,
      renderTime: renderTime,
      memoryUsage: memoryUsage,
      fps: fps,
      timestamp: DateTime.now(),
      additionalMetrics: additionalMetrics,
    );
  }

  /// Get formatted load time
  String get formattedLoadTime => '${loadTime.toStringAsFixed(2)}ms';

  /// Get formatted render time
  String get formattedRenderTime => '${renderTime.toStringAsFixed(2)}ms';

  /// Get formatted memory usage
  String get formattedMemoryUsage => '${memoryUsage.toStringAsFixed(2)}MB';

  /// Get performance score (0-100)
  int get performanceScore {
    // Simple scoring algorithm
    double score = 100.0;
    
    // Penalize slow load times
    if (loadTime > 1000) score -= 20;
    if (loadTime > 2000) score -= 30;
    
    // Penalize slow render times
    if (renderTime > 16.67) score -= 15; // 60fps threshold
    if (renderTime > 33.33) score -= 25; // 30fps threshold
    
    // Penalize high memory usage
    if (memoryUsage > 50) score -= 15;
    if (memoryUsage > 100) score -= 25;
    
    // Penalize low FPS
    if (fps < 60) score -= 10;
    if (fps < 30) score -= 20;
    
    return score.clamp(0, 100).round();
  }

  /// Get performance grade
  String get performanceGrade {
    final score = performanceScore;
    if (score >= 90) return 'A';
    if (score >= 80) return 'B';
    if (score >= 70) return 'C';
    if (score >= 60) return 'D';
    return 'F';
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'rendererType': rendererType,
      'loadTime': loadTime,
      'renderTime': renderTime,
      'memoryUsage': memoryUsage,
      'fps': fps,
      'timestamp': timestamp.toIso8601String(),
      'additionalMetrics': additionalMetrics,
      'performanceScore': performanceScore,
      'performanceGrade': performanceGrade,
    };
  }

  /// Create from JSON
  factory PerformanceMetrics.fromJson(Map<String, dynamic> json) {
    return PerformanceMetrics(
      rendererType: json['rendererType'] as String,
      loadTime: (json['loadTime'] as num).toDouble(),
      renderTime: (json['renderTime'] as num).toDouble(),
      memoryUsage: (json['memoryUsage'] as num).toDouble(),
      fps: json['fps'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      additionalMetrics: json['additionalMetrics'] as Map<String, dynamic>? ?? {},
    );
  }

  @override
  String toString() {
    return 'PerformanceMetrics(renderer: $rendererType, '
           'load: ${formattedLoadTime}, render: ${formattedRenderTime}, '
           'memory: ${formattedMemoryUsage}, fps: $fps, '
           'score: $performanceScore ($performanceGrade))';
  }
}

/// Image optimization information
class ImageOptimizationInfo {
  final String originalFormat;
  final String optimizedFormat;
  final int originalSize;
  final int optimizedSize;
  final double compressionRatio;
  final double qualityScore;

  const ImageOptimizationInfo({
    required this.originalFormat,
    required this.optimizedFormat,
    required this.originalSize,
    required this.optimizedSize,
    required this.compressionRatio,
    required this.qualityScore,
  });

  /// Calculate space saved in bytes
  int get spaceSaved => originalSize - optimizedSize;

  /// Calculate space saved percentage
  double get spaceSavedPercentage => 
      (spaceSaved / originalSize) * 100;

  /// Get formatted original size
  String get formattedOriginalSize => _formatBytes(originalSize);

  /// Get formatted optimized size
  String get formattedOptimizedSize => _formatBytes(optimizedSize);

  /// Get formatted space saved
  String get formattedSpaceSaved => _formatBytes(spaceSaved);

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

