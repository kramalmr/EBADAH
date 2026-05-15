import 'dart:convert';
import 'package:ebadah/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  String hijriDate = "Loading...";
  String prayerMessage = "Loading...";
  String nextPrayerTime = "Loading...";
  String nextPrayer = "Loading..";
  String estimationTime = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchHijriDate();
    fetchPrayerTimes();
  }

  Future<void> fetchHijriDate() async {
    final response = await http.get(
      Uri.parse("https://api.aladhan.com/v1/gToH"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final hijriDay = data['data']['hijri']['day'];
      final hijriMonth = data['data']['hijri']['month']['en'];
      final hijriYear = data['data']['hijri']['year'];

      setState(() {
        hijriDate = "$hijriDay $hijriMonth $hijriYear";
      });
    } else {
      setState(() {
        hijriDate = "Failed to load date";
      });
    }
  }

  Future<void> fetchPrayerTimes() async {
    final response = await http.get(
      Uri.parse(
        "https://api.aladhan.com/v1/timingsByCity?city=Jakarta&country=Indonesia&method=2",
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final timings = data['data']['timings'];

      Map<String, String> prayers = {
        "Subuh": timings["Fajr"],
        "Zuhur": timings["Dhuhr"],
        "Ashar": timings["Asr"],
        "Maghrib": timings["Maghrib"],
        "Isya'": timings["Isha"],
      };

      DateTime now = DateTime.now();
      String? upcoming;

      for (var entry in prayers.entries) {
        final parts = entry.value.split(":");
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);

        var hourDecrease = hour - now.hour;
        var minuteDecrease = minute - now.minute;
        if (hourDecrease <= 0) {
          estimationTime = '$minuteDecrease Menit lagi!';
          if (minuteDecrease == 0)
            estimationTime = 'Sudah waktu $nextPrayer Segera!';
        } else {
          estimationTime = '$hourDecrease Jam lagi!';
        }

        DateTime prayerTime = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          minute,
        );

        if (prayerTime.isAfter(now)) {
          upcoming = "Menjelang waktu ${entry.key}";
          nextPrayerTime = entry.value;
          nextPrayer = entry.key;
          break;
        }
      }

      setState(() {
        prayerMessage = upcoming ?? "No more prayers today";
      });
    } else {
      setState(() {
        prayerMessage = "Failed to load prayer times";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          hijriDate,
          style: GoogleFonts.inter(color: AppColors.darkGreen, fontSize: 12),
        ),
        Text(
          prayerMessage,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.secondary),
          ),
          child: Row(
            children: [
              Text(
                nextPrayerTime,
                style: GoogleFonts.inter(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    estimationTime,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
                  Text(
                    'Adzan $nextPrayer',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
