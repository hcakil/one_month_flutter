import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Day4WebPerformanceScreen extends StatelessWidget {
  const Day4WebPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gün 4: Web Performans İyileştirme'),
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
            Icon(Icons.speed, size: 64),
            SizedBox(height: 16),
            Text(
              'Gün 4: Web Performans İyileştirme',
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