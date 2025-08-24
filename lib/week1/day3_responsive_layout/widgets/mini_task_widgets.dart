import 'package:flutter/material.dart';

/// Mini Task: Complete responsive design that adapts to different screen sizes
class ResponsiveMiniTaskCard extends StatefulWidget {
  const ResponsiveMiniTaskCard({super.key});

  @override
  State<ResponsiveMiniTaskCard> createState() => _ResponsiveMiniTaskCardState();
}

class _ResponsiveMiniTaskCardState extends State<ResponsiveMiniTaskCard> {
  int selectedTab = 0;
  bool showSidebar = true;
  
  final List<TaskItem> tasks = [
    TaskItem(
      title: 'Design System Updates',
      description: 'Update the design system with new color palette and typography',
      priority: TaskPriority.high,
      category: 'Design',
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    TaskItem(
      title: 'Mobile App Optimization',
      description: 'Optimize the mobile app performance and fix responsive issues',
      priority: TaskPriority.medium,
      category: 'Development',
      dueDate: DateTime.now().add(const Duration(days: 5)),
    ),
    TaskItem(
      title: 'User Research Analysis',
      description: 'Analyze user research data and create actionable insights',
      priority: TaskPriority.low,
      category: 'Research',
      dueDate: DateTime.now().add(const Duration(days: 7)),
    ),
    TaskItem(
      title: 'API Documentation',
      description: 'Write comprehensive API documentation for the new endpoints',
      priority: TaskPriority.medium,
      category: 'Documentation',
      dueDate: DateTime.now().add(const Duration(days: 3)),
    ),
    TaskItem(
      title: 'Security Audit',
      description: 'Conduct a thorough security audit of the application',
      priority: TaskPriority.high,
      category: 'Security',
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
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
              '🎯 Mini Task: Responsive Dashboard',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'A complete responsive design that adapts layout based on screen width',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return _buildResponsiveLayout(constraints);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    
    // More granular breakpoints for better responsive behavior
    if (width < 600) {
      return _buildMobileLayout();
    } else if (width < 900) {
      // Improved tablet layout for medium screens
      return _buildTabletLayout();
    } else {
      return _buildDesktopLayout();
    }
  }

  // Mobile Layout: Stack navigation with bottom tabs
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Header
        _buildHeader('📱 Mobile Dashboard'),
        // Content
        Expanded(
          child: IndexedStack(
            index: selectedTab,
            children: [
              _buildTaskList(crossAxisCount: 1),
              _buildStatsView(isCompact: true),
              _buildSettingsView(isCompact: true),
            ],
          ),
        ),
        // Bottom Navigation
        _buildBottomNavigation(),
      ],
    );
  }

  // Tablet Layout: Side navigation with adaptive content
  Widget _buildTabletLayout() {
    return Column(
      children: [
        // Header
        _buildHeader('💻 Tablet Dashboard'),
        // Content
        Expanded(
          child: Row(
            children: [
              // Sidebar
              Container(
                width: 200,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: _buildSideNavigation(),
              ),
              // Main content
              Expanded(
                child: IndexedStack(
                  index: selectedTab,
                  children: [
                    _buildTaskList(crossAxisCount: 2),
                    _buildStatsView(isCompact: false),
                    _buildSettingsView(isCompact: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Desktop Layout: Full layout with optional sidebar
  Widget _buildDesktopLayout() {
    return Column(
      children: [
        // Header with sidebar toggle
        _buildDesktopHeader(),
        // Content
        Expanded(
          child: Row(
            children: [
              // Collapsible Sidebar
              if (showSidebar)
                Container(
                  width: 250,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: _buildSideNavigation(isDesktop: true),
                ),
              // Main content
              Expanded(
                child: IndexedStack(
                  index: selectedTab,
                  children: [
                    _buildTaskList(crossAxisCount: 3),
                    _buildStatsView(isCompact: false),
                    _buildSettingsView(isCompact: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      height: 60,
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Container(
      height: 60,
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        children: [
          IconButton(
            icon: Icon(showSidebar ? Icons.menu_open : Icons.menu),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => setState(() => showSidebar = !showSidebar),
          ),
          Text(
            '🖥️ Desktop Dashboard',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          _buildNavItem(0, Icons.task, 'Tasks'),
          _buildNavItem(1, Icons.analytics, 'Stats'),
          _buildNavItem(2, Icons.settings, 'Settings'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedTab = index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected 
                ? Theme.of(context).colorScheme.primary 
                : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            Text(
              label,
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
  }

  Widget _buildSideNavigation({bool isDesktop = false}) {
    return Column(
      children: [
        if (isDesktop) const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.task),
          title: const Text('Tasks'),
          selected: selectedTab == 0,
          onTap: () => setState(() => selectedTab = 0),
        ),
        ListTile(
          leading: const Icon(Icons.analytics),
          title: const Text('Analytics'),
          selected: selectedTab == 1,
          onTap: () => setState(() => selectedTab = 1),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          selected: selectedTab == 2,
          onTap: () => setState(() => selectedTab = 2),
        ),
        if (isDesktop) ...[
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () {},
          ),
        ],
      ],
    );
  }

  Widget _buildTaskList({required int crossAxisCount}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Tasks',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: _getAspectRatio(crossAxisCount),
              ),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return _buildTaskCard(tasks[index], isCompact: crossAxisCount == 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(TaskItem task, {required bool isCompact}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: isCompact ? _buildCompactTaskCard(task) : _buildFullTaskCard(task),
      ),
    );
  }

  Widget _buildCompactTaskCard(TaskItem task) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: _getPriorityColor(task.priority),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                task.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                task.category,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }

  Widget _buildFullTaskCard(TaskItem task) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.priority.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: _getPriorityColor(task.priority),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              task.description,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.category,
                size: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  task.category,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.schedule,
                size: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                _formatDate(task.dueDate),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsView({required bool isCompact}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: isCompact ? 2 : 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildStatCard('Total Tasks', '23', Icons.task, Colors.blue),
                _buildStatCard('Completed', '18', Icons.check_circle, Colors.green),
                _buildStatCard('In Progress', '3', Icons.schedule, Colors.orange),
                _buildStatCard('Overdue', '2', Icons.warning, Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsView({required bool isCompact}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildSettingItem('Notifications', Icons.notifications, true),
                _buildSettingItem('Dark Mode', Icons.dark_mode, false),
                _buildSettingItem('Auto Sync', Icons.sync, true),
                _buildSettingItem('Offline Mode', Icons.offline_bolt, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon, bool value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: (newValue) {},
      ),
    );
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  double _getAspectRatio(int crossAxisCount) {
    switch (crossAxisCount) {
      case 1:
        return 4.0; // Wider for single column
      case 2:
        return 2.8; // Balanced for two columns
      case 3:
        return 2.2; // Taller for three columns
      default:
        return 2.0;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 0) return 'Overdue';
    return '${difference}d';
  }
}

/// Task item model
class TaskItem {
  final String title;
  final String description;
  final TaskPriority priority;
  final String category;
  final DateTime dueDate;

  TaskItem({
    required this.title,
    required this.description,
    required this.priority,
    required this.category,
    required this.dueDate,
  });
}

/// Task priority enumeration
enum TaskPriority {
  high,
  medium,
  low,
}
