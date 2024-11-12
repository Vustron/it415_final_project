import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'dart:io';

class FilePreview extends StatelessWidget {
  const FilePreview({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    print('Preview file path: $filePath');

    final String extension = path.extension(filePath).toLowerCase();
    const double previewSize = 100.0;

    // Handle network/storage images
    if (filePath.startsWith('http') || filePath.startsWith('gs://')) {
      return Container(
        width: previewSize,
        height: previewSize,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: FutureBuilder<void>(
          future: precacheImage(NetworkImage(filePath), context),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.error),
                    SizedBox(height: 4),
                    Text(
                      'Failed to load image',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(filePath),
                  fit: BoxFit.cover,
                  onError: (Object exception, StackTrace? stackTrace) {
                    print('Network image error: $exception');
                  },
                ),
              ),
            );
          },
        ),
      );
    }

    // Handle local image files
    if (<String>['.png', '.jpg', '.jpeg'].contains(extension)) {
      return Container(
        width: previewSize,
        height: previewSize,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: FileImage(File(filePath)),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // For non-image files
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
          Icon(Icons.insert_drive_file, size: 40, color: Colors.grey[600]),
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
