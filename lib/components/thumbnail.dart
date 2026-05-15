import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeThumbnail extends StatelessWidget {
  final String videoUrl;
  final String thumbnailUrl;

  const YoutubeThumbnail({
    super.key,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  Future<void> _launchYoutube() async {
    final Uri url = Uri.parse(videoUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: _launchYoutube,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Image.network(thumbnailUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
