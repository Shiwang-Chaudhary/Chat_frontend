import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';

class CloudinaryService {
  Future uploadFile(File file) async {
    try {
      final String cloudName = "dqsltl9ge";
      final String uploadPreset = "chat_uploads";
      final dio = Dio();
      final url =
          "https://api.cloudinary.com/v1_1/$cloudName/image/upload"; //"auto" detects the resource type automatically
      final FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path),
        "upload_preset": uploadPreset,
      });
      final response = await dio.post(
        url,
        data: formData,
        onSendProgress: (sent, total) {
          double progress = sent / total;
          log("Uploading: ${(progress * 100).toStringAsFixed(0)}%");
        },
      );
      return response.data["secure_url"];
    } catch (e) {
      log("Cloudinary upload error: ${e.toString()}");
      rethrow;
    }
  }

  Future uploadMultipleFiles(List<File> files) async {
    try {
      List<String> uploadedUrls = [];
      for (var file in files) {
        String url = await uploadFile(file);
        uploadedUrls.add(url);
      }
      return uploadedUrls;
    } catch (e) {
      log("Cloudinary multiple upload error: ${e.toString()}");
      rethrow;
    }
  }
}
