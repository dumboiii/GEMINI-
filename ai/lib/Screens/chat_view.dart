// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai/Models/ai_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatView extends StatelessWidget {
  final AiModel aimodels;
  const ChatView({
    Key? key,
    required this.aimodels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (aimodels.isUser == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/pic.png'),
              radius: 24,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image carousel for user's uploaded images
                    if (aimodels.images?.isNotEmpty ?? false)
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(aimodels.images![index]),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, i) => const SizedBox(width: 10),
                          itemCount: aimodels.images?.length ?? 0,
                        ),
                      ),
                    // User's text message
                    Text(
                      aimodels.text ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/ai.png'),
              radius: 24,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Markdown(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  styleSheet: MarkdownStyleSheet(
                    h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    h2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    p: const TextStyle(fontSize: 16, color: Colors.black87),
                    strong: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    em: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  data: aimodels.text ?? "",
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
