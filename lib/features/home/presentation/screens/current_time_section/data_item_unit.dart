import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DataItemUnit extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  
  const DataItemUnit({
    super.key, required this.icon, required this.title, required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        const SizedBox(width: 3),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                title,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: const TextStyle(fontSize: 14),
                minFontSize: 9,
                maxFontSize: 14,                
              ),
              Flexible(child: 
                AutoSizeText(
                subtitle,
                style: const TextStyle(height: 1, fontSize: 14),
                overflow: TextOverflow.visible,
                minFontSize: 2,
              ),
              )
            ],
          ),
        ),
      ],
    );
  }
}