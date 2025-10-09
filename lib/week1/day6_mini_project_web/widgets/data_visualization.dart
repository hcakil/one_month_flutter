import 'package:flutter/material.dart';

class DataVisualization extends StatefulWidget {
  const DataVisualization({super.key});

  @override
  State<DataVisualization> createState() => _DataVisualizationState();
}

class _DataVisualizationState extends State<DataVisualization>
    with TickerProviderStateMixin {
  late AnimationController _chartAnimationController;
  late Animation<double> _chartAnimation;
  
  String _selectedTimeRange = '7d';
  String _selectedMetric = 'users';

  @override
  void initState() {
    super.initState();
    _chartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _chartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _chartAnimationController, curve: Curves.easeInOut),
    );
    _chartAnimationController.forward();
  }

  @override
  void dispose() {
    _chartAnimationController.dispose();
    super.dispose();
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
          _buildControls(),
          const SizedBox(height: 24),
          _buildCharts(),
          const SizedBox(height: 24),
          _buildDataTable(),
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
            Colors.green.withValues(alpha: 0.8),
            Colors.teal.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Visualization',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Interactive charts and analytics dashboard',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time Range',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: '7d', label: Text('7 Days')),
                      ButtonSegment(value: '30d', label: Text('30 Days')),
                      ButtonSegment(value: '90d', label: Text('90 Days')),
                    ],
                    selected: {_selectedTimeRange},
                    onSelectionChanged: (Set<String> selection) {
                      setState(() {
                        _selectedTimeRange = selection.first;
                        _chartAnimationController.reset();
                        _chartAnimationController.forward();
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Metric',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: _selectedMetric,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'users', child: Text('Users')),
                      DropdownMenuItem(value: 'revenue', child: Text('Revenue')),
                      DropdownMenuItem(value: 'orders', child: Text('Orders')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedMetric = value!;
                        _chartAnimationController.reset();
                        _chartAnimationController.forward();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharts() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Column(
          children: [
            if (isMobile) ...[
              _buildLineChart(),
              const SizedBox(height: 16),
              _buildPieChart(),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildLineChart(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildPieChart(),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            _buildBarChart(),
          ],
        );
      },
    );
  }

  Widget _buildLineChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trend Analysis',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _chartAnimation,
              builder: (context, child) {
                return Container(
                  height: 200,
                  child: CustomPaint(
                    painter: LineChartPainter(_chartAnimation.value),
                    size: const Size(double.infinity, 200),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Distribution',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _chartAnimation,
              builder: (context, child) {
                return Container(
                  height: 200,
                  child: CustomPaint(
                    painter: PieChartPainter(_chartAnimation.value),
                    size: const Size(double.infinity, 200),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _chartAnimation,
              builder: (context, child) {
                return Container(
                  height: 200,
                  child: CustomPaint(
                    painter: BarChartPainter(_chartAnimation.value),
                    size: const Size(double.infinity, 200),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detailed Data',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Users')),
                  DataColumn(label: Text('Revenue')),
                  DataColumn(label: Text('Orders')),
                  DataColumn(label: Text('Conversion')),
                ],
                rows: List.generate(10, (index) {
                  return DataRow(
                    cells: [
                      DataCell(Text('2024-01-${index + 1}')),
                      DataCell(Text('${1000 + index * 100}')),
                      DataCell(Text('\$${5000 + index * 500}')),
                      DataCell(Text('${50 + index * 5}')),
                      DataCell(Text('${2.5 + index * 0.1}%')),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final double animationValue;

  LineChartPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width, size.height * 0.1),
    ];

    for (int i = 0; i < points.length; i++) {
      final animatedPoint = Offset(
        points[i].dx,
        points[i].dy + (size.height * 0.5 * (1 - animationValue)),
      );
      
      if (i == 0) {
        path.moveTo(animatedPoint.dx, animatedPoint.dy);
      } else {
        path.lineTo(animatedPoint.dx, animatedPoint.dy);
      }
    }

    canvas.drawPath(path, paint);

    // Draw points
    for (int i = 0; i < points.length; i++) {
      final animatedPoint = Offset(
        points[i].dx,
        points[i].dy + (size.height * 0.5 * (1 - animationValue)),
      );
      canvas.drawCircle(animatedPoint, 4, Paint()..color = Colors.blue);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PieChartPainter extends CustomPainter {
  final double animationValue;

  PieChartPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    final data = [
      {'value': 40, 'color': Colors.blue},
      {'value': 30, 'color': Colors.green},
      {'value': 20, 'color': Colors.orange},
      {'value': 10, 'color': Colors.red},
    ];

    double startAngle = -90 * 3.14159 / 180;
    
    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i]['value'] as int) * 3.14159 * 2 / 100 * animationValue;
      
      final paint = Paint()
        ..color = data[i]['color'] as Color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BarChartPainter extends CustomPainter {
  final double animationValue;

  BarChartPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final data = [60, 80, 45, 90, 70, 55, 85];
    final barWidth = size.width / data.length * 0.6;
    final barSpacing = size.width / data.length * 0.4;

    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i] / 100) * size.height * animationValue;
      final x = i * (barWidth + barSpacing) + barSpacing / 2;
      final y = size.height - barHeight;

      final paint = Paint()
        ..color = Colors.blue.withOpacity(0.8)
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
