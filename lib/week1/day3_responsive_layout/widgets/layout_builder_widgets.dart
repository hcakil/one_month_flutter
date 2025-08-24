import 'package:flutter/material.dart';
import '../utils/responsive_breakpoints.dart';

/// Widget demonstrating LayoutBuilder basic usage
class BasicLayoutBuilderCard extends StatelessWidget {
  const BasicLayoutBuilderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🏗️ Basic LayoutBuilder',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final deviceType = ResponsiveBreakpoints.getDeviceTypeName(width);
                
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Width: ${width.isFinite ? width.toInt() : "Unlimited"}px',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Device Type: $deviceType'),
                      Text('Max Height: ${constraints.maxHeight.isFinite ? constraints.maxHeight.toInt() : "Unlimited"}px'),
                      Text('Min Width: ${constraints.minWidth.isFinite ? constraints.minWidth.toInt() : "0"}px'),
                      Text('Min Height: ${constraints.minHeight.isFinite ? constraints.minHeight.toInt() : "0"}px'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget demonstrating responsive grid using LayoutBuilder
class ResponsiveGridCard extends StatelessWidget {
  const ResponsiveGridCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📱 Responsive Grid',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final columnCount = ResponsiveBreakpoints.getGridColumnCount(constraints.maxWidth);
                
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Columns: $columnCount (Width: ${constraints.maxWidth.toInt()}px)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columnCount,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
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

/// Widget demonstrating adaptive navigation using LayoutBuilder
class AdaptiveNavigationCard extends StatefulWidget {
  const AdaptiveNavigationCard({super.key});

  @override
  State<AdaptiveNavigationCard> createState() => _AdaptiveNavigationCardState();
}

class _AdaptiveNavigationCardState extends State<AdaptiveNavigationCard> {
  int selectedIndex = 0;
  
  final List<NavigationItem> items = [
    NavigationItem(icon: Icons.home, label: 'Home'),
    NavigationItem(icon: Icons.search, label: 'Search'),
    NavigationItem(icon: Icons.favorite, label: 'Favorites'),
    NavigationItem(icon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🧭 Adaptive Navigation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = ResponsiveBreakpoints.isMobile(constraints.maxWidth);
                
                return Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isMobile 
                    ? _buildMobileLayout() 
                    : _buildDesktopLayout(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // App Bar
        Container(
          height: 56,
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Text(
              'Mobile Layout',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        // Content
        Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                'Content Area\n${items[selectedIndex].label} selected',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
        // Bottom Navigation
        Container(
          height: 60,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = selectedIndex == index;
              
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        color: isSelected 
                          ? Theme.of(context).colorScheme.primary 
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected 
                            ? Theme.of(context).colorScheme.primary 
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Side Navigation
        Container(
          width: 200,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Column(
            children: [
              Container(
                height: 56,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Text(
                    'Desktop Layout',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              ...items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = selectedIndex == index;
                
                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.label),
                  selected: isSelected,
                  onTap: () => setState(() => selectedIndex = index),
                );
              }),
            ],
          ),
        ),
        // Content
        Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                'Content Area\n${items[selectedIndex].label} selected',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Navigation item model
class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem({required this.icon, required this.label});
}

/// Widget demonstrating responsive card layout
class ResponsiveCardLayoutCard extends StatelessWidget {
  const ResponsiveCardLayoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🃏 Responsive Card Layout',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final isVertical = ResponsiveBreakpoints.isMobile(width);
                
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isVertical ? _buildVerticalLayout() : _buildHorizontalLayout(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      children: [
        _buildImagePlaceholder(),
        const SizedBox(height: 16),
        _buildContentSection(),
        const SizedBox(height: 16),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildImagePlaceholder()),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContentSection(),
              const SizedBox(height: 16),
              _buildActionButtons(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 48),
      ),
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This is a responsive card that changes its layout based on available width. On mobile, content is stacked vertically. On larger screens, it uses a horizontal layout.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Action'),
        ),
      ],
    );
  }
}
