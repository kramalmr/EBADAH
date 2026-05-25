import 'dart:convert';
import 'package:ebadah/data/cityList.dart';
import 'package:ebadah/model/location_model.dart';
import 'package:ebadah/model/location_service.dart';
import 'package:ebadah/theme/app_theme.dart';
import 'package:ebadah/widgets/locateDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../data/prayersData.dart';
import '../data/userLocation.dart';

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
  String nextPrayer = "...";
  String estimationTime = "...";

  @override
  void initState() {
    super.initState();
    fetchHijriDate();
    fetchPrayerTimes();
    // setLocationAndFetchPrayerTimes();
  }

  // Future<void> setLocationAndFetchPrayerTimes() async {
  //   try {
  //     final location = await getUserLocation();
  //     setState(() {
  //       city = location["city"]!;
  //       country = location["country"]!;
  //     });
  //     fetchPrayerTimes();
  //   } catch (e) {
  //     setState(() {
  //       prayerMessage = "...";
  //     });
  //   }
  // }

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
        "https://api.aladhan.com/v1/timingsByCity?city=${cityData}&country=${countryData}&method=2",
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final timings = data['data']['timings'];

      prayers["Subuh"] = timings["Fajr"];
      prayers["Zuhur"] = timings["Dhuhr"];
      prayers["Ashar"] = timings["Asr"];
      prayers["Maghrib"] = timings["Maghrib"];
      prayers["Isya'"] = timings["Isha"];

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
          nextPrayerData = entry.key;
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

class PrayerLocation extends StatefulWidget {
  const PrayerLocation({super.key});

  @override
  State<PrayerLocation> createState() => _PrayerLocationState();
}

class _PrayerLocationState extends State<PrayerLocation> {
  String currentCity = "Jakarta";
  String currentCountry = "Indonesia";
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _loadLastLocation();
  }

  Future<void> _loadLastLocation() async {
    final lastLoc = await _locationService.getLastLocation();
    if (lastLoc != null) {
      setState(() {
        currentCity = lastLoc.city;
        currentCountry = lastLoc.country;
        cityData = lastLoc.city;
        countryData = lastLoc.country;
      });
    }
  }

  Future<void> refreshLocation() async {
    final location = await getUserLocation();
    setState(() {
      currentCity = location["city"]!;
      currentCountry = location["country"]!;
      cityData = currentCity;
      countryData = currentCountry;
    });

    await _locationService.insertLocation(
      LocationModel(city: currentCity, country: currentCountry),
    );
  }

  void _openDialog() async {
    final result = await showLocateDialog(context);

    if (result != null && result.trim().isNotEmpty) {
      final normalizedCity =
          result.trim()[0].toUpperCase() + result.trim().substring(1);

      if (indonesianCities.contains(normalizedCity)) {
        setState(() {
          cityData = normalizedCity;
          currentCity = normalizedCity;
        });

        await _locationService.insertLocation(
          LocationModel(city: cityData, country: countryData),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Kota diubah ke $cityData",
              style: GoogleFonts.inter(),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Kota tidak ditemukan di Indonesia",
              style: GoogleFonts.inter(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 5,
      children: [
        Text("Waktu tidak sesuai? Ubah Lokasi!", style: GoogleFonts.inter()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: theme.colorScheme.surface,
                side: BorderSide(color: theme.colorScheme.primary),
              ),
              onPressed: _openDialog,
              child: Row(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.locate, color: theme.colorScheme.primary),
                  Text(
                    "$currentCity, $currentCountry",
                    style: GoogleFonts.inter(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                side: BorderSide(color: theme.colorScheme.primary),
                backgroundColor: theme.colorScheme.surface,
              ),
              icon: Icon(
                LucideIcons.refreshCcw,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              onPressed: refreshLocation,
            ),
          ],
        ),
      ],
    );
  }
}
