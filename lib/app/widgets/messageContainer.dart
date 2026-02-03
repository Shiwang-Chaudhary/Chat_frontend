
import 'package:chat_backend/app/services/capitalize_service.dart';
import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class MessageContainer extends StatelessWidget {
  final bool isMe;
  final String message;
  final String dateTime;
  final String? otherName;

  const MessageContainer({
    super.key,
    required this.isMe,
    required this.message,
    required this.dateTime,
    this.otherName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 260),
      decoration: BoxDecoration(
        color: isMe ? Colors.blueAccent : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isMe?SizedBox() : CustomText(text: "~${CapitalizeService.capitalizeEachWord(otherName!)}",size: 15,color: Colors.cyan,),
          ReadMoreText(
            message,
            trimLines: 5,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Read more',
            trimExpandedText: ' Read less',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
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

          /// ⏱ Time
          CustomText(
            text: dateTime,
            color: Colors.white70,
            size: 11,
          ),
        ],
      ),
    );
  }
}
