import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Day2RiverpodStateScreen extends StatelessWidget {
  const Day2RiverpodStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gün 2: Riverpod State Management'),
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
            Icon(Icons.account_tree, size: 64), // Better icon for state management
            SizedBox(height: 16),
            Text(
              'Gün 2: Riverpod State Management',
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
