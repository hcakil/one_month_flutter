import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Day5SeoMetadataScreen extends StatelessWidget {
  const Day5SeoMetadataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gün 5: SEO ve Web Metadata'),
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
            Icon(Icons.search, size: 64),
            SizedBox(height: 16),
            Text(
              'Gün 5: SEO ve Web Metadata',
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