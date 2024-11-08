import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class FilePreview extends StatelessWidget {
  const FilePreview({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    final String extension = path.extension(filePath).toLowerCase();
    const double previewSize = 100.0;

    if (<String>['.png', '.jpg', '.jpeg'].contains(extension)) {
      return Container(
        width: previewSize,
        height: previewSize,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(filePath),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      width: previewSize,
      height: previewSize,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.insert_drive_file,
            size: 40,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 8),
          Text(
            path.basename(filePath),
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
