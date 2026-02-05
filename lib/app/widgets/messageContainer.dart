import 'package:chat_backend/app/routes/app_routes.dart';
import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:readmore/readmore.dart';

class MessageContainer extends StatelessWidget {
  final bool isMe;
  final String message;
  final String dateTime;
  final String? otherName;
  final bool isFile;
  final String? fileType;
  final String? fileUrl;
  final String? videoThumbnailUrl;

  const MessageContainer({
    super.key,
    required this.isMe,
    required this.message,
    required this.dateTime,
    this.otherName,
    this.fileType,
    this.fileUrl,
    this.videoThumbnailUrl,
    required this.isFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 260),
      decoration: BoxDecoration(
        color: isMe
            ? fileType != "text"
                  ? const Color.fromRGBO(43, 43, 73, 1)
                  : Colors.blueAccent
            : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          isMe
              ? SizedBox()
              : CustomText(
                  text: "~${CapitalizeService.capitalizeEachWord(otherName!)}",
                  size: 15,
                  color: Colors.cyan,
                ),
          message == "" || !isFile
              ? GestureDetector(
                  onTap: () {
                    if (fileType == "file") {
                      Get.toNamed(Routes.VIDEO_OPEN_SCREEN);
                    } else {
                      Get.toNamed(
                        Routes.IMAGE_OPEN_SCREEN,
                        arguments: {"fileUrl": fileUrl},
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          fileType == "file" ? videoThumbnailUrl! : fileUrl!,
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
                        ),
                      ),
                      if (fileType == "file")
                        Positioned.fill(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : ReadMoreText(
                  message,
                  trimLines: 5,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Read more',
                  trimExpandedText: ' Read less',
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                  moreStyle: const TextStyle(
                    color: Color.fromRGBO(0, 213, 255, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  lessStyle: const TextStyle(
                    color: Color.fromRGBO(0, 213, 255, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          const SizedBox(height: 4),
          CustomText(text: dateTime, color: Colors.white70, size: 11),
        ],
      ),
    );
  }
}
