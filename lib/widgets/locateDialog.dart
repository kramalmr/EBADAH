import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import '../data/userLocation.dart';

Future<String?> showLocateDialog(BuildContext context) async {
  String? city;
  return await showDialog<String>(
    context: context,
    builder: (context) {
      return SimpleDialog(
        contentPadding: EdgeInsetsGeometry.all(10),
        title: Center(
          child: Text('Ubah Kota', style: GoogleFonts.plusJakartaSans()),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: cityData,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                city = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context), // returns null
                    child: Text('Cancel', style: GoogleFonts.inter()),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pop(context, city), // returns String
                    child: Text(
                      'Simpan',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
