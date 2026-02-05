import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerService {
  Future<File?> pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<List<File>?> pickMultipleFiles() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null && result.files.isNotEmpty) {
      return result.files
          .where((file) => file.path != null)
          .map((file) => File(file.path!))
          .toList();
    }
    return null;
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  String getMessageType(String fileName) {
    final ext = fileName.split(".").last.toLowerCase();

    if (["jpg", "jpeg", "png"].contains(ext)) return "image";
    if (["mp4", "mov"].contains(ext)) return "video";
    if (["mp3", "wav"].contains(ext)) return "audio";
    if (["pdf", "docx"].contains(ext)) return "document";

    return "file";
  }
}
