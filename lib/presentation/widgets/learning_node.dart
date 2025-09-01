import 'package:flutter/material.dart';

class LearningNode extends StatelessWidget {
  final String title;
  final bool isUnlocked;
  final bool isCompleted;
  final VoidCallback onTap;

  const LearningNode({
    super.key,
    required this.title,
    required this.isUnlocked,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUnlocked ? onTap : null,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? Colors.green
                  : isUnlocked
                  ? Colors.blue
                  : Colors.grey,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 24)
                  : isUnlocked
                  ? const Icon(Icons.lock_open, color: Colors.white, size: 24)
                  : const Icon(Icons.lock, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isCompleted || isUnlocked ? Colors.white : Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
