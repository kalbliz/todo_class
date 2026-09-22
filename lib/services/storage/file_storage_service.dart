import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// File-based storage helpers (path_provider).
/// Teach this after SharedPreferences — for larger / custom files.
class FileStorageService {
  FileStorageService._();

  static final FileStorageService instance = FileStorageService._();

  Future<Directory> get documentsDirectory async {
    return getApplicationDocumentsDirectory();
  }

  Future<File> fileFor(String fileName) async {
    final dir = await documentsDirectory;
    return File('${dir.path}/$fileName');
  }

  Future<void> writeString(String fileName, String content) async {
    final file = await fileFor(fileName);
    await file.writeAsString(content);
  }

  Future<String?> readString(String fileName) async {
    final file = await fileFor(fileName);
    if (!await file.exists()) return null;
    return file.readAsString();
  }

  Future<void> deleteFile(String fileName) async {
    final file = await fileFor(fileName);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
