import 'package:chat_backend/app/services/byteToOtherConversion.dart';
import 'package:flutter/material.dart';

class PdfMessageBubble extends StatelessWidget {
  final String fileName;
  final String fileUrl;
  final int? fileSize; // optional

  const PdfMessageBubble({
    super.key,
    required this.fileName,
    required this.fileUrl,
    this.fileSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // ✅ PDF Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.picture_as_pdf,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 12),

          // ✅ File Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File Name
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                // File Size + Type
                Text(
                  "${BytesToOtherConversion.convertBytesToReadableFormat(fileSize ?? 0)} • PDF Document",
                  style: TextStyle(color: Colors.grey.shade300, fontSize: 12),
                ),
              ],
            ),
          ),

          // ✅ Download Icon
          const Icon(Icons.download, color: Colors.white70),
        ],
      ),
    );
  }
}
