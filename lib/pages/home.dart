import 'package:ebadah/components/prayer_screen.dart';
import 'package:ebadah/components/thumbnail.dart';
import 'package:ebadah/model/doa_model.dart';
import 'package:ebadah/model/doa_services.dart';
import 'package:ebadah/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  final Function(int) onNavigate;
  HomePage({super.key, required this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final date = DateTime.now();
  final PageController _controller = PageController();
  final List<String> itemsImagesPageView = ['P1', 'P2', 'P3', 'P4', 'P5'];

  DoaModel? randomDoa;

  @override
  void initState() {
    super.initState();
    _loadRandomDoa();
  }

  Future<void> _loadRandomDoa() async {
    final doaList = await DoaService().getAllDoa();

    // Filter hanya kategori "Doa Sehari-hari"
    final dailyDoa = doaList
        .where((d) => d.category == "Doa Sehari-hari")
        .toList();

    if (dailyDoa.isNotEmpty) {
      dailyDoa.shuffle(); // acak list
      setState(() {
        randomDoa = dailyDoa.first;
      });
    }
  }

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
                spacing: 10,
                children: [
                  PrayerTimesScreen(),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            widget.onNavigate(1);
                          },
                          borderRadius: BorderRadius.circular(16),
                          splashColor: AppColors.darkGreen,
                          splashFactory: InkSparkle.splashFactory,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            height: 80,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              border: Border.all(color: AppColors.darkGreen),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  child: SvgPicture.asset(
                                    'assets/mosque.svg',
                                    width: 80,
                                    fit: BoxFit.contain,
                                  ),
                                  bottom: -30,
                                  right: -10,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        LucideIcons.clock,
                                        size: 20,
                                        color: AppColors.offWhite,
                                      ),
                                      Text(
                                        "Waktu",

                                        style: GoogleFonts.ojuju(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 36,
                                          color: AppColors.offWhite,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            widget.onNavigate(3);
                          },
                          borderRadius: BorderRadius.circular(16),
                          splashColor: AppColors.darkGreen,
                          splashFactory: InkSparkle.splashFactory,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            height: 80,
                            decoration: BoxDecoration(
                              color: theme.scaffoldBackgroundColor,
                              border: Border.all(color: AppColors.darkGreen),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              alignment: AlignmentGeometry.centerEnd,
                              children: [
                                Positioned(
                                  child: SvgPicture.asset(
                                    'assets/kabah.svg',
                                    width: 80,
                                    fit: BoxFit.contain,
                                    color: theme.colorScheme.secondary,
                                  ),
                                  bottom: -30,
                                  left: -10,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        LucideIcons.compass,
                                        size: 20,
                                        color: theme.colorScheme.primary,
                                      ),
                                      Text(
                                        "Kiblat",

                                        style: GoogleFonts.ojuju(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 36,
                                          color: theme.colorScheme.primary,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 360,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: itemsImagesPageView.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          'assets/posters/${itemsImagesPageView[index]}.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: itemsImagesPageView.length,
                    effect: SwapEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      dotColor: theme.colorScheme.secondary,
                      activeDotColor: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Column(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Youtube Terbaru",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: PageView(
                    children: [
                      YoutubeThumbnail(
                        videoUrl:
                            'https://youtu.be/HePLLxVfn2Q?si=D-zRf3M4u1uJ2fqT',
                        thumbnailUrl:
                            'https://img.youtube.com/vi/HePLLxVfn2Q/maxresdefault.jpg',
                        title: 'Promo Kajian',
                      ),
                      YoutubeThumbnail(
                        videoUrl:
                            'https://youtu.be/0D-eC_mzH0k?si=2K5Z_IlnRsTFW24z',
                        thumbnailUrl:
                            'https://img.youtube.com/vi/0D-eC_mzH0k/maxresdefault.jpg',
                        title:
                            'Daurah Doa-doa Terindah Rasulullah ﷺ Sesi #2 - Ustadz DR Syafiq Riza Basalamah MA',
                      ),
                      YoutubeThumbnail(
                        videoUrl:
                            'https://www.youtube.com/live/eAbCTE0KsPY?si=UiSmr5dLLXqNr2VJ',
                        thumbnailUrl:
                            'https://img.youtube.com/vi/eAbCTE0KsPY/maxresdefault.jpg',
                        title: 'Riyadhush Shalihin 185 : Keutamaan Wudhu - Ustadz DR Syafiq Riza Basalamah MA',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              "Doa Pilihan Hari ini",
              style: GoogleFonts.inter(
                fontSize: 16,
                color: theme.colorScheme.primary,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    AppColors.darkGreen,
                    AppColors.darkGreen,
                    AppColors.darkGreen,
                  ],
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: randomDoa == null
                  ? CircularProgressIndicator(color: Colors.white)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        SizedBox(height: 8),

                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 18,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          child: Column(
                            spacing: 20,
                            children: [
                              Text(
                                "Doa ${randomDoa!.title}",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: theme.colorScheme.surface,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                randomDoa!.arabic,
                                style: GoogleFonts.tajawal(
                                  fontSize: 24,
                                  color: theme.colorScheme.surface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                randomDoa!.translation,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: theme.colorScheme.surface,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 120),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
