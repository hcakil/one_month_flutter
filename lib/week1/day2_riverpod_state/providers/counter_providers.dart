import 'package:flutter_riverpod/flutter_riverpod.dart';

// Counter state notifier
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
  void incrementBy(int value) => state += value;
}

// Counter provider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

// Computed provider example
final doubledCounterProvider = Provider<int>((ref) {
  final count = ref.watch(counterProvider);
  return count * 2;
});

// Advanced counter with async operations
class AsyncCounterNotifier extends StateNotifier<AsyncValue<int>> {
  AsyncCounterNotifier() : super(const AsyncValue.data(0));

  Future<void> incrementAsync() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncValue.data((state.value ?? 0) + 1);
  }

  Future<void> fetchRemoteCounter() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 2));
      // Simulate API call
      final remoteValue = DateTime.now().millisecond % 100;
      state = AsyncValue.data(remoteValue);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  void reset() => state = const AsyncValue.data(0);
}

// Async counter provider
final asyncCounterProvider = StateNotifierProvider<AsyncCounterNotifier, AsyncValue<int>>((ref) {
  return AsyncCounterNotifier();
}); 