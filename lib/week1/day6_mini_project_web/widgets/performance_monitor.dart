import 'package:flutter/material.dart';
import 'dart:math' as math;

class PerformanceMonitor extends StatefulWidget {
  const PerformanceMonitor({super.key});

  @override
  State<PerformanceMonitor> createState() => _PerformanceMonitorState();
}

class _PerformanceMonitorState extends State<PerformanceMonitor>
    with TickerProviderStateMixin {
  late AnimationController _cpuAnimationController;
  late AnimationController _memoryAnimationController;
  late AnimationController _networkAnimationController;
  
  late Animation<double> _cpuAnimation;
  late Animation<double> _memoryAnimation;
  late Animation<double> _networkAnimation;

  double _cpuUsage = 0.0;
  double _memoryUsage = 0.0;
  double _networkSpeed = 0.0;
  bool _isMonitoring = false;

  @override
  void initState() {
    super.initState();
    _cpuAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _memoryAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _networkAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _cpuAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cpuAnimationController, curve: Curves.easeInOut),
    );
    _memoryAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _memoryAnimationController, curve: Curves.easeInOut),
    );
    _networkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _networkAnimationController, curve: Curves.easeInOut),
    );

    _startMonitoring();
  }

  @override
  void dispose() {
    _cpuAnimationController.dispose();
    _memoryAnimationController.dispose();
    _networkAnimationController.dispose();
    super.dispose();
  }

  void _startMonitoring() {
    setState(() {
      _isMonitoring = true;
    });

    _cpuAnimationController.repeat(reverse: true);
    _memoryAnimationController.repeat(reverse: true);
    _networkAnimationController.repeat(reverse: true);

    _updateMetrics();
  }

  void _stopMonitoring() {
    setState(() {
      _isMonitoring = false;
    });

    _cpuAnimationController.stop();
    _memoryAnimationController.stop();
    _networkAnimationController.stop();
  }

  void _updateMetrics() {
    if (!_isMonitoring) return;

    setState(() {
      _cpuUsage = 20 + math.Random().nextDouble() * 60;
      _memoryUsage = 30 + math.Random().nextDouble() * 50;
      _networkSpeed = 10 + math.Random().nextDouble() * 90;
    });

    Future.delayed(const Duration(seconds: 1), _updateMetrics);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildControlPanel(),
          const SizedBox(height: 24),
          _buildMetricsCards(),
          const SizedBox(height: 24),
          _buildPerformanceCharts(),
          const SizedBox(height: 24),
          _buildSystemInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(0.8),
            Colors.orange.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Monitor',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Real-time system performance monitoring',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              _isMonitoring ? Icons.stop : Icons.play_arrow,
              color: _isMonitoring ? Colors.red : Colors.green,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isMonitoring ? 'Monitoring Active' : 'Monitoring Stopped',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _isMonitoring 
                      ? 'Real-time performance data is being collected'
                      : 'Click to start monitoring system performance',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: _isMonitoring ? _stopMonitoring : _startMonitoring,
              icon: Icon(_isMonitoring ? Icons.stop : Icons.play_arrow),
              label: Text(_isMonitoring ? 'Stop' : 'Start'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isMonitoring ? Colors.red : Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isMobile ? 1 : 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMetricCard(
              'CPU Usage',
              '${_cpuUsage.toStringAsFixed(1)}%',
              Icons.memory,
              Colors.blue,
              _cpuUsage / 100,
            ),
            _buildMetricCard(
              'Memory Usage',
              '${_memoryUsage.toStringAsFixed(1)}%',
              Icons.storage,
              Colors.green,
              _memoryUsage / 100,
            ),
            _buildMetricCard(
              'Network Speed',
              '${_networkSpeed.toStringAsFixed(1)} Mbps',
              Icons.wifi,
              Colors.orange,
              _networkSpeed / 100,
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, double progress) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(progress).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(progress),
                    style: TextStyle(
                      color: _getStatusColor(progress),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(double progress) {
    if (progress < 0.5) return Colors.green;
    if (progress < 0.8) return Colors.orange;
    return Colors.red;
  }

  String _getStatusText(double progress) {
    if (progress < 0.5) return 'Good';
    if (progress < 0.8) return 'Warning';
    return 'Critical';
  }

  Widget _buildPerformanceCharts() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Column(
          children: [
            if (isMobile) ...[
              _buildCpuChart(),
              const SizedBox(height: 16),
              _buildMemoryChart(),
            ] else ...[
              Row(
                children: [
                  Expanded(child: _buildCpuChart()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildMemoryChart()),
                ],
              ),
            ],
            const SizedBox(height: 16),
            _buildNetworkChart(),
          ],
        );
      },
    );
  }

  Widget _buildCpuChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CPU Usage Over Time',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _cpuAnimation,
              builder: (context, child) {
                return Container(
                  height: 150,
                  child: CustomPaint(
                    painter: PerformanceChartPainter(
                      _cpuUsage / 100,
                      Colors.blue,
                      _cpuAnimation.value,
                    ),
                    size: const Size(double.infinity, 150),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Memory Usage Over Time',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _memoryAnimation,
              builder: (context, child) {
                return Container(
                  height: 150,
                  child: CustomPaint(
                    painter: PerformanceChartPainter(
                      _memoryUsage / 100,
                      Colors.green,
                      _memoryAnimation.value,
                    ),
                    size: const Size(double.infinity, 150),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Network Speed Over Time',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _networkAnimation,
              builder: (context, child) {
                return Container(
                  height: 150,
                  child: CustomPaint(
                    painter: PerformanceChartPainter(
                      _networkSpeed / 100,
                      Colors.orange,
                      _networkAnimation.value,
                    ),
                    size: const Size(double.infinity, 150),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Platform', 'Web (Flutter)'),
            _buildInfoRow('Framework', 'Flutter 3.27+'),
            _buildInfoRow('Renderer', 'HTML (CanvasKit)'),
            _buildInfoRow('Last Update', DateTime.now().toString().split(' ')[0]),
            _buildInfoRow('Status', _isMonitoring ? 'Active' : 'Inactive'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class PerformanceChartPainter extends CustomPainter {
  final double value;
  final Color color;
  final double animationValue;

  PerformanceChartPainter(this.value, this.color, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final animatedValue = value * animationValue;
    final barHeight = size.height * animatedValue;

    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height - barHeight,
        size.width,
        barHeight,
      ),
      paint,
    );

    // Draw animated line
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = List.generate(20, (i) {
      final x = (i / 19) * size.width;
      final y = size.height - (math.sin(i * 0.5) * 0.3 + 0.5) * barHeight;
      return Offset(x, y);
    });

    for (int i = 0; i < points.length; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      } else {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
