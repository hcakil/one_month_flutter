import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/counter_providers.dart';

class SimpleCounterCard extends ConsumerWidget {
  const SimpleCounterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔢 Simple Counter (StateNotifierProvider)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                final count = ref.watch(counterProvider);
                final doubledCount = ref.watch(doubledCounterProvider);

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Counter Value',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '$count',
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Doubled: $doubledCount',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () => ref.read(counterProvider.notifier).increment(),
                          icon: const Icon(Icons.add),
                          label: const Text('+1'),
                        ),
                        FilledButton.icon(
                          onPressed: () => ref.read(counterProvider.notifier).decrement(),
                          icon: const Icon(Icons.remove),
                          label: const Text('-1'),
                        ),
                        FilledButton.icon(
                          onPressed: () => ref.read(counterProvider.notifier).incrementBy(5),
                          icon: const Icon(Icons.add_circle),
                          label: const Text('+5'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => ref.read(counterProvider.notifier).reset(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AsyncCounterCard extends ConsumerWidget {
  const AsyncCounterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '⚡ Async Counter (AsyncValue)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                final asyncCount = ref.watch(asyncCounterProvider);

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: asyncCount.when(
                        data: (count) => Column(
                          children: [
                            Text(
                              'Async Counter',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '$count',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                                  ),
                            ),
                          ],
                        ),
                        loading: () => const Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 8),
                            Text('Loading...'),
                          ],
                        ),
                        error: (error, stack) => Column(
                          children: [
                            const Icon(Icons.error, color: Colors.red, size: 48),
                            const SizedBox(height: 8),
                            Text('Error: $error'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () => ref.read(asyncCounterProvider.notifier).incrementAsync(),
                          icon: const Icon(Icons.add),
                          label: const Text('Async +1'),
                        ),
                        FilledButton.icon(
                          onPressed: () => ref.read(asyncCounterProvider.notifier).fetchRemoteCounter(),
                          icon: const Icon(Icons.cloud_download),
                          label: const Text('Fetch Remote'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => ref.read(asyncCounterProvider.notifier).reset(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
