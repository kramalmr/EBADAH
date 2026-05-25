import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeThumbnail extends StatelessWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final String title;

  const YoutubeThumbnail({
    super.key,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.title,
  });

  Future<void> _launchYoutube() async {
    final Uri url = Uri.parse(videoUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: _launchYoutube,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Stack(
            children: [
              // Background photo
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  thumbnailUrl, // replace with your image path
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.7),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              // Optional text on top
              Positioned(
                bottom: 16,
                left: 16,
                child: SizedBox(
                  width: 300,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
