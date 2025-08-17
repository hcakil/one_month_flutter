import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_preferences_provider.dart';

class UserPreferencesCard extends ConsumerWidget {
  const UserPreferencesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '⚙️ User Preferences (Complex State)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                final preferences = ref.watch(userPreferencesProvider);

                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.palette),
                      title: const Text('Theme'),
                      subtitle: Text(preferences.theme),
                      trailing: SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: 'light', label: Text('Light')),
                          ButtonSegment(value: 'dark', label: Text('Dark')),
                        ],
                        selected: {preferences.theme},
                        onSelectionChanged: (Set<String> selection) {
                          ref.read(userPreferencesProvider.notifier).setTheme(selection.first);
                        },
                      ),
                    ),
                    SwitchListTile(
                      secondary: const Icon(Icons.notifications),
                      title: const Text('Notifications'),
                      value: preferences.notifications,
                      onChanged: (bool value) {
                        ref.read(userPreferencesProvider.notifier).toggleNotifications();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.text_fields),
                      title: const Text('Font Size'),
                      subtitle: Slider(
                        value: preferences.fontSize,
                        min: 12,
                        max: 24,
                        divisions: 12,
                        label: '${preferences.fontSize.round()}px',
                        onChanged: (double value) {
                          ref.read(userPreferencesProvider.notifier).setFontSize(value);
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Settings:',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8),
                          Text('Theme: ${preferences.theme}'),
                          Text('Notifications: ${preferences.notifications ? "On" : "Off"}'),
                          Text('Font Size: ${preferences.fontSize.round()}px'),
                        ],
                      ),
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