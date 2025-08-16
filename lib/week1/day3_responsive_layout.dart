import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Day3ResponsiveLayoutScreen extends StatelessWidget {
  const Day3ResponsiveLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gün 3: Responsive & Adaptive Layout'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.devices, size: 64), // Better icon for responsive layout
            SizedBox(height: 16),
            Text(
              'Gün 3: Responsive & Adaptive Layout',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Bu sayfa yakında tamamlanacak...'),
          ],
        ),
      ),
    );
  }
}
