import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../data/prayersData.dart';
import '../components/prayer_screen.dart';

class PrayersPage extends StatefulWidget {
  PrayersPage({super.key});

  @override
  State<PrayersPage> createState() => _PrayersPageState();
}

class _PrayersPageState extends State<PrayersPage> {
  final date = DateTime.now();
  final List<String> itemsImagesPageView = ['P1', 'P2', 'P3', 'P4', 'P5'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                spacing: 18,
                children: [
                  PrayerTimesScreen(),
                  Column(
                    spacing: 12,
                    children: prayers.entries.map((e) {
                      Color textColor;
                      FontWeight customWeight;
                      if (nextPrayerData == e.key) {
                        textColor = theme.colorScheme.primary;
                        customWeight = FontWeight.w800;
                      } else {
                        textColor = theme.colorScheme.tertiary;
                        customWeight = FontWeight.w500;
                      }
                      return Container(
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.key,
                                    style: GoogleFonts.inter(color: textColor),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    e.value,
                                    style: GoogleFonts.inter(
                                      fontWeight: customWeight,
                                      fontSize: 18,
                                      color: textColor,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(LucideIcons.bell),
                              color: theme.colorScheme.primary,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  PrayerLocation(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
