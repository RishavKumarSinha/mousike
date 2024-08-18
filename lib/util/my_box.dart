import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  final List<String> imagePaths; // List to accept multiple image paths

  const MyBox({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          children: List.generate(
            imagePaths.length > 4 ? 4 : imagePaths.length,
            (index) {
              final imagePath = imagePaths[index];
              return Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.broken_image,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
