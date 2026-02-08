import 'package:chat_backend/app/services/byteToOtherConversion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AudioBubble extends StatelessWidget {
  final String? fileUrl;
  final String? fileName;
  final int? fileSize;
  const AudioBubble({
    super.key,
    required this.fileUrl,
    required this.fileSize,
    required this.fileName,
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.audio_file, color: Colors.white, size: 28),
          ),

          const SizedBox(width: 12),

          // ✅ File Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File Name
                Text(
                  fileName ?? "Unknown Audio",
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
                  "${BytesToOtherConversion.convertBytesToReadableFormat(fileSize ?? 0)} •  Audio",
                  style: TextStyle(color: Colors.grey.shade300, fontSize: 12),
                ),
              ],
            ),
          ),

          // ✅ Download Icon
          const Icon(Icons.play_arrow, color: Colors.white70),
        ],
      ),
    );
  }
}
