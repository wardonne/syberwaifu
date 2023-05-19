import 'dart:io';

import 'package:path/path.dart';

Future<File> rename(String oldPath, String newPath) async {
  final oldFile = File(oldPath);
  final dirpath = dirname(newPath);
  final newDirpath = Directory(dirpath);
  if (!await newDirpath.exists()) {
    newDirpath.create(recursive: true);
  }
  final newFile = File(newPath);
  if (await newFile.exists()) {
    await newFile.delete();
  }
  final copyedFile = await oldFile.copy(newPath);
  await oldFile.delete();
  return copyedFile;
}

Future<File?> tryRename(String oldPath, String newPath) async {
  try {
    return await rename(oldPath, newPath);
  } catch (error) {
    return null;
  }
}
