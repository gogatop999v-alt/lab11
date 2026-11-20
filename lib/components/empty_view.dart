import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const EmptyView({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(message),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              TextButton(onPressed: onRetry, child: const Text('Обновить')),
            ],
          ],
        ),
      );
}
