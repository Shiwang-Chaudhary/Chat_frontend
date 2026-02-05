import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String? fileUrl;
  const ImageContainer({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      fileUrl!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          padding: const EdgeInsets.all(8),
          color: Colors.grey,
          child: const CustomText(
            text: "Could not load file preview",
            color: Colors.white,
            size: 14,
          ),
        );
      },
    );
  }
}
