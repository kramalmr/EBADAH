import 'package:ebadah/model/qibla_servides.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  double? qiblaDirection;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchQibla();
  }

  Future<void> _fetchQibla() async {
    try {
      // Minta izin lokasi
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          loading = false;
        });
        return;
      }

      // Ambil posisi real-time
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final service = QiblaService();
      final direction = await service.getQiblaDirection(
        position.latitude,
        position.longitude,
      );

      setState(() {
        qiblaDirection = direction;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : qiblaDirection != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: qiblaDirection! * math.pi / 180,
                    child: Icon(
                      Icons.explore,
                      size: 200,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${qiblaDirection!.toStringAsFixed(2)}°",
                    style: GoogleFonts.plusJakartaSans(fontSize: 24),
                  ),
                ],
              )
            : const Text("Tidak bisa memuat arah kiblat"),
      ),
    );
  }
}
