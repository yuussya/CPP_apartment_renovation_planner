import 'package:flutter/material.dart';

/// Розташовує дочірні віджети в рядок на широких екранах
/// і в колонку — на вузьких (за шириною доступного місця).
class ResponsiveRow extends StatelessWidget {
  const ResponsiveRow({
    super.key,
    required this.children,
    this.flexes,
    this.breakpoint = 700,
    this.spacing = 16,
  });

  final List<Widget> children;
  final List<int>? flexes;
  final double breakpoint;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) SizedBox(height: spacing),
                children[i],
              ],
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) SizedBox(width: spacing),
              Expanded(
                flex: flexes != null ? flexes![i] : 1,
                child: children[i],
              ),
            ],
          ],
        );
      },
    );
  }
}
