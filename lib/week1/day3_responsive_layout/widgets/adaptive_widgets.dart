import 'package:flutter/material.dart';

import '../utils/responsive_breakpoints.dart';

/// Adaptive widget that changes based on screen size
class AdaptiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final Color? mobileColor;
  final Color? tabletColor;
  final Color? desktopColor;

  const AdaptiveContainer({
    super.key,
    required this.child,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.mobileColor,
    this.tabletColor,
    this.desktopColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    EdgeInsets padding;
    Color? backgroundColor;

    if (ResponsiveBreakpoints.isMobile(screenWidth)) {
      padding = mobilePadding ?? const EdgeInsets.all(16);
      backgroundColor = mobileColor;
    } else if (ResponsiveBreakpoints.isTablet(screenWidth)) {
      padding = tabletPadding ?? const EdgeInsets.all(24);
      backgroundColor = tabletColor;
    } else {
      padding = desktopPadding ?? const EdgeInsets.all(32);
      backgroundColor = desktopColor;
    }

    return Container(
      padding: padding,
      color: backgroundColor,
      child: child,
    );
  }
}

/// Adaptive text that scales based on screen size
class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? baseStyle;
  final double? mobileScale;
  final double? tabletScale;
  final double? desktopScale;

  const AdaptiveText(
    this.text, {
    super.key,
    this.baseStyle,
    this.mobileScale = 1.0,
    this.tabletScale = 1.1,
    this.desktopScale = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double scale;
    if (ResponsiveBreakpoints.isMobile(screenWidth)) {
      scale = mobileScale ?? 1.0;
    } else if (ResponsiveBreakpoints.isTablet(screenWidth)) {
      scale = tabletScale ?? 1.1;
    } else {
      scale = desktopScale ?? 1.2;
    }

    final style = baseStyle ?? Theme.of(context).textTheme.bodyMedium!;

    return Text(
      text,
      style: style.copyWith(
        fontSize: (style.fontSize ?? 14) * scale,
      ),
    );
  }
}

/// Platform-aware adaptive button
class AdaptivePlatformButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const AdaptivePlatformButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _buildCupertinoButton(context);
    } else {
      return _buildMaterialButton(context);
    }
  }

  Widget _buildCupertinoButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: !isPrimary ? Border.all(color: Theme.of(context).colorScheme.outline) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: isPrimary ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialButton(BuildContext context) {
    return isPrimary
        ? ElevatedButton(
            onPressed: onPressed,
            child: Text(text),
          )
        : OutlinedButton(
            onPressed: onPressed,
            child: Text(text),
          );
  }
}

/// Improved responsive navigation using multiple approaches
class ImprovedResponsiveNavigationCard extends StatefulWidget {
  const ImprovedResponsiveNavigationCard({super.key});

  @override
  State<ImprovedResponsiveNavigationCard> createState() => _ImprovedResponsiveNavigationCardState();
}

class _ImprovedResponsiveNavigationCardState extends State<ImprovedResponsiveNavigationCard> {
  int selectedIndex = 0;
  
  final List<NavItem> destinations = [
    NavItem(icon: Icons.dashboard, label: 'Dashboard'),
    NavItem(icon: Icons.analytics, label: 'Analytics'),
    NavItem(icon: Icons.people, label: 'Users'),
    NavItem(icon: Icons.settings, label: 'Settings'),
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
              '🚀 Improved Responsive Navigation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Better practice: Multiple breakpoints with graceful degradation',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ResponsiveBuilder(
                mobile: (context) => _buildMobileNavigation(),
                tablet: (context) => _buildTabletNavigation(),
                desktop: (context) => _buildDesktopNavigation(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavigation() {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Mobile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(destinations[selectedIndex].icon),
            const SizedBox(height: 8),
            Text('${destinations[selectedIndex].label} Content'),
            const SizedBox(height: 8),
            Text(
              'Mobile: Bottom navigation',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        destinations: destinations.map((dest) => NavigationDestination(
          icon: Icon(dest.icon),
          label: dest.label,
        )).toList(),
      ),
    );
  }

  Widget _buildTabletNavigation() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) => setState(() => selectedIndex = index),
          labelType: NavigationRailLabelType.selected,
          destinations: destinations.map((dest) => NavigationRailDestination(
            icon: Icon(dest.icon),
            label: Text(dest.label),
          )).toList(),
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 56,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Text(
                    'Tablet Navigation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(destinations[selectedIndex].icon),
                      const SizedBox(height: 8),
                      Text('${destinations[selectedIndex].label} Content'),
                      const SizedBox(height: 8),
                      Text(
                        'Tablet: Navigation rail',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopNavigation() {
    return Row(
      children: [
        Container(
          width: 240,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Column(
            children: [
              Container(
                height: 56,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Text(
                    'Desktop Navigation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              ...destinations.asMap().entries.map((entry) {
                final index = entry.key;
                final destination = entry.value;
                final isSelected = selectedIndex == index;
                
                return ListTile(
                  leading: Icon(destination.icon),
                  title: Text(destination.label),
                  selected: isSelected,
                  onTap: () => setState(() => selectedIndex = index),
                );
              }),
              const Spacer(),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help'),
                onTap: () {},
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(destinations[selectedIndex].icon),
                const SizedBox(height: 8),
                Text('${destinations[selectedIndex].label} Content'),
                const SizedBox(height: 8),
                Text(
                  'Desktop: Full sidebar with additional options',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Navigation item helper class
class NavItem {
  final IconData icon;
  final String label;

  const NavItem({required this.icon, required this.label});
}

/// Responsive builder widget - Better practice for responsive layouts
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        
        // Desktop breakpoint
        if (ResponsiveBreakpoints.isDesktop(width) && desktop != null) {
          return desktop!(context);
        }
        
        // Tablet breakpoint
        if (ResponsiveBreakpoints.isTablet(width) && tablet != null) {
          return tablet!(context);
        }
        
        // Mobile fallback (always provided)
        return mobile(context);
      },
    );
  }
}

/// Demo card showing adaptive widgets in action
class AdaptiveWidgetsCard extends StatelessWidget {
  const AdaptiveWidgetsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔄 Adaptive Widgets',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // Adaptive Container Demo
            AdaptiveContainer(
                             mobileColor: Colors.blue.withValues(alpha: 0.1),
               tabletColor: Colors.green.withValues(alpha: 0.1),
               desktopColor: Colors.orange.withValues(alpha: 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdaptiveText(
                    'Adaptive Container & Text',
                    baseStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  AdaptiveText(
                    'This container and text adapt their padding and font size based on screen size. Mobile gets blue background, tablet gets green, desktop gets orange.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Platform Button Demo
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Platform-Aware Buttons',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AdaptivePlatformButton(
                          text: 'Primary Action',
                          onPressed: () => _showSnackBar(context, 'Primary button pressed'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AdaptivePlatformButton(
                          text: 'Secondary',
                          isPrimary: false,
                          onPressed: () => _showSnackBar(context, 'Secondary button pressed'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'These buttons adapt to the platform: Material style on Android/Web, Cupertino style on iOS.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

/// Adaptive navigation rail that becomes a drawer on mobile
class AdaptiveNavigationCard extends StatefulWidget {
  const AdaptiveNavigationCard({super.key});

  @override
  State<AdaptiveNavigationCard> createState() => _AdaptiveNavigationCardState();
}

class _AdaptiveNavigationCardState extends State<AdaptiveNavigationCard> {
  int selectedIndex = 0;

  final List<NavItem> destinations = [
    NavItem(icon: Icons.home, label: 'Home'),
    NavItem(icon: Icons.search, label: 'Search'),
    NavItem(icon: Icons.favorite, label: 'Favorites'),
    NavItem(icon: Icons.settings, label: 'Settings'),
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
              '📱 Adaptive Navigation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
                            child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  
                  // More sophisticated responsive logic
                  if (ResponsiveBreakpoints.isMobile(width)) {
                    return _buildMobileLayout();
                  } else if (ResponsiveBreakpoints.isTablet(width)) {
                    return _buildTabletLayout();
                  } else {
                    return _buildDesktopLayout();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // App Bar with drawer button
        Container(
          height: 56,
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: () => _showMobileDrawer(),
              ),
              Text(
                'Mobile Layout',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ],
          ),
        ),
        // Content
        Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(destinations[selectedIndex].icon),
                  const SizedBox(height: 8),
                  Text(
                    '${destinations[selectedIndex].label} Content',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap menu button to see navigation drawer',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Compact Side Navigation (smaller than desktop)
        Container(
          width: 160,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Column(
            children: [
              Container(
                height: 56,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Text(
                    'Tablet Layout',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              ...destinations.asMap().entries.map((entry) {
                final index = entry.key;
                final destination = entry.value;
                final isSelected = selectedIndex == index;
                
                return ListTile(
                  leading: Icon(destination.icon, size: 20),
                  title: Text(
                    destination.label,
                    style: const TextStyle(fontSize: 13),
                  ),
                  selected: isSelected,
                  dense: true,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(destinations[selectedIndex].icon),
                  const SizedBox(height: 8),
                  Text(
                    '${destinations[selectedIndex].label} Content',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Compact navigation for tablet screens',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Navigation Rail
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
              ...destinations.asMap().entries.map((entry) {
                final index = entry.key;
                final destination = entry.value;
                final isSelected = selectedIndex == index;

                return ListTile(
                  leading: Icon(destination.icon),
                  title: Text(destination.label),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(destinations[selectedIndex].icon),
                  const SizedBox(height: 8),
                  Text(
                    '${destinations[selectedIndex].label} Content',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Navigation rail visible on larger screens',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMobileDrawer() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Navigation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...destinations.asMap().entries.map((entry) {
              final index = entry.key;
              final destination = entry.value;
              final isSelected = selectedIndex == index;

              return ListTile(
                leading: Icon(destination.icon),
                title: Text(destination.label),
                selected: isSelected,
                onTap: () {
                  setState(() => selectedIndex = index);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// Adaptive grid that changes column count based on screen size
class AdaptiveGridCard extends StatelessWidget {
  const AdaptiveGridCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔲 Adaptive Grid',
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
                        childAspectRatio: 1.0,
                      ),
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.widgets,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${index + 1}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
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
