import 'package:ebadah/pages/qibla.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ebadah/components/appbar_ebadah.dart';
import 'package:ebadah/model/doa_services.dart';
import 'package:ebadah/pages/doa.dart';
import 'package:ebadah/pages/home.dart';
import 'package:ebadah/pages/prayers.dart';
import 'package:ebadah/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DoaService().seedDoaData();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDark = false;
  int selectedIndex = 0;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        height: 50,
        width: 50,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.darkGreen.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                icon,
                color: isSelected ? AppColors.darkGreen : AppColors.gray,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.darkGreen
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = isDark ? AppTheme.dark : AppTheme.light;
    List<Widget> _pages = <Widget>[
      HomePage(onNavigate: _onItemTapped),
      PrayersPage(),
      DoaPage(),
      QiblaPage(),
    ];

    return MaterialApp(
      title: 'EBADAH',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: AppBarEbadah(onToggleTheme: toggleTheme),
          ),
        ),
        body: _pages[selectedIndex],
        bottomNavigationBar: Container(
          height: 87,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.7),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(LucideIcons.house, 0, "Home"),
              _buildNavItem(LucideIcons.clock, 1, "Waktu Sholat"),
              _buildNavItem(LucideIcons.book, 2, "Amalan"),
              _buildNavItem(LucideIcons.compass, 3, "Kiblat"),
            ],
          ),
        ),
      ),
    );
  }
}
