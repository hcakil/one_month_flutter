import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:js' as js;

/// Widget for switching between HTML and CanvasKit renderers
class RendererSwitcherWidget extends StatefulWidget {
  const RendererSwitcherWidget({super.key});

  @override
  State<RendererSwitcherWidget> createState() => _RendererSwitcherWidgetState();
}

class _RendererSwitcherWidgetState extends State<RendererSwitcherWidget> {
  String _currentRenderer = 'html';
  bool _isSwitching = false;

  @override
  void initState() {
    super.initState();
    _detectCurrentRenderer();
  }

  void _detectCurrentRenderer() {
    try {
      if (js.context.hasProperty('flutterConfiguration') && 
          js.context['flutterConfiguration'].hasProperty('renderer')) {
        final renderer = js.context['flutterConfiguration']['renderer'] as String?;
        if (renderer != null) {
          setState(() {
            _currentRenderer = renderer;
          });
        }
      }
    } catch (e) {
      print('Error detecting renderer: $e');
    }
  }

  Future<void> _switchRenderer(String newRenderer) async {
    if (_currentRenderer == newRenderer) return;

    setState(() {
      _isSwitching = true;
    });

    try {
      // Update the Flutter configuration
      if (js.context.hasProperty('flutterConfiguration')) {
        js.context['flutterConfiguration']['renderer'] = newRenderer;
      }

      // Update URL parameter
      final currentUrl = Uri.parse(html.window.location.href);
      final newQueryParams = Map<String, String>.from(currentUrl.queryParameters);
      newQueryParams['renderer'] = newRenderer;
      
      final newUrl = currentUrl.replace(queryParameters: newQueryParams);
      
      // Reload the page with new renderer
      html.window.location.href = newUrl.toString();
    } catch (e) {
      print('Error switching renderer: $e');
      setState(() {
        _isSwitching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.swap_horiz,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  '🔄 Renderer Switcher',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Switch between HTML and CanvasKit renderers. Changes require a page reload.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            
            // Current renderer display
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getRendererColor(_currentRenderer),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _getRendererIcon(_currentRenderer),
                    color: _getRendererIconColor(_currentRenderer),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Renderer',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: _getRendererTextColor(_currentRenderer),
                          ),
                        ),
                        Text(
                          _getRendererDisplayName(_currentRenderer),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: _getRendererTextColor(_currentRenderer),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Renderer options
            Row(
              children: [
                Expanded(
                  child: _buildRendererOption(
                    'HTML',
                    'html',
                    'Fast loading, better accessibility',
                    Icons.web,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRendererOption(
                    'CanvasKit',
                    'canvaskit',
                    'Better graphics, consistent rendering',
                    Icons.memory,
                    Colors.blue,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Instructions
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'How to Use',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Select your preferred renderer above\n'
                    '• The page will reload automatically\n'
                    '• Test performance in the Performance Test tab\n'
                    '• Compare results between renderers',
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

  Widget _buildRendererOption(
    String title,
    String rendererValue,
    String description,
    IconData icon,
    Color color,
  ) {
    final isSelected = _currentRenderer == rendererValue;
    final isDisabled = _isSwitching;
    
    return InkWell(
      onTap: isDisabled ? null : () => _switchRenderer(rendererValue),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected 
              ? color.withValues(alpha: 0.2)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? color.withValues(alpha: 0.5)
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? color : Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? color : null,
                  ),
                ),
                if (isSelected) ...[
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: color,
                    size: 16,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected 
                    ? color.withValues(alpha: 0.8)
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRendererColor(String renderer) {
    switch (renderer) {
      case 'html':
        return Colors.green.withValues(alpha: 0.1);
      case 'canvaskit':
        return Colors.blue.withValues(alpha: 0.1);
      default:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }

  IconData _getRendererIcon(String renderer) {
    switch (renderer) {
      case 'html':
        return Icons.web;
      case 'canvaskit':
        return Icons.memory;
      default:
        return Icons.info;
    }
  }

  Color _getRendererIconColor(String renderer) {
    switch (renderer) {
      case 'html':
        return Colors.green.shade700;
      case 'canvaskit':
        return Colors.blue.shade700;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Color _getRendererTextColor(String renderer) {
    switch (renderer) {
      case 'html':
        return Colors.green.shade800;
      case 'canvaskit':
        return Colors.blue.shade800;
      default:
        return Theme.of(context).colorScheme.onSurface;
    }
  }

  String _getRendererDisplayName(String renderer) {
    switch (renderer) {
      case 'html':
        return 'HTML (DOM)';
      case 'canvaskit':
        return 'CanvasKit (WebGL)';
      default:
        return 'Unknown';
    }
  }
}

