import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppBarEbadah extends StatefulWidget {
  final VoidCallback onToggleTheme;
  AppBarEbadah({super.key, required this.onToggleTheme});

  @override
  State<AppBarEbadah> createState() => _AppBarEbadahState();
}

class _AppBarEbadahState extends State<AppBarEbadah> {
  bool isDarkLocal = false;

  void toggleTheme() {
    widget.onToggleTheme();
    toggleThemeLocal();
  }

  void toggleThemeLocal() {
    setState(() {
      isDarkLocal = !isDarkLocal;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void info() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "EBADAH APP",
                style: GoogleFonts.inter(fontWeight: FontWeight.w500),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Made solely for the final project",
                ),
                SizedBox(height: 10),
                const Text("made by akram with ❤️"),
                const Text("version 0.0.1"),
              ],
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ),
            ],
          );
        },
      );
    }

    return AppBar(
      
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Row(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icon.svg', width: 32, fit: BoxFit.contain),
          Text(
            "EBADAH",
            style: GoogleFonts.ojuju(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
              fontSize: 36,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: toggleTheme,
          icon: (isDarkLocal
              ? Icon(LucideIcons.sun, color: theme.colorScheme.tertiary)
              : Icon(LucideIcons.moon)),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: theme.colorScheme.surface,
            border: Border.all(color: theme.colorScheme.secondary),
          ),
          child: IconButton(
            onPressed: () {
              info();
            },
            icon: Icon(LucideIcons.info, color: theme.colorScheme.tertiary),
          ),
        ),
      ],
    );
  }
}
