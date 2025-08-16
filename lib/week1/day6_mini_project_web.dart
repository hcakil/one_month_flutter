import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Day6MiniProjectWebScreen extends StatelessWidget {
  const Day6MiniProjectWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gün 6: Mini Proje (Responsive Web App)'),
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
            Icon(Icons.web, size: 64),
            SizedBox(height: 16),
            Text(
              'Gün 6: Mini Proje (Responsive Web App)',
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