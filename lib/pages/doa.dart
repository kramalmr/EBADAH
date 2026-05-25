import 'package:ebadah/model/doa_model.dart';
import 'package:ebadah/model/doa_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DoaPage extends StatefulWidget {
  const DoaPage({super.key});

  @override
  State<DoaPage> createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  final DoaService _doaService = DoaService();
  Map<String, List<DoaModel>> groupedDoa = {};

  @override
  void initState() {
    super.initState();
    _loadDoa();
  }

  Future<void> _loadDoa() async {
    await _doaService.seedDoaData();
    final doaList = await _doaService.getAllDoa();

    final Map<String, List<DoaModel>> temp = {};
    for (var doa in doaList) {
      temp.putIfAbsent(doa.category, () => []);
      temp[doa.category]!.add(doa);
    }

    setState(() {
      groupedDoa = temp;
    });
  }

  void _showDoaDetail(DoaModel doa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Center(
                    child: Text(
                      "Doa ${doa.title}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    doa.arabic,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(fontSize: 32),
                  ),

                  Text(
                    doa.latin,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 12),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Text(
                      doa.translation,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 60,
                    width: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: Icon(
                        LucideIcons.undo2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: ListView(
          children: groupedDoa.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul kategori
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: theme.colorScheme.secondary,
                        ),
                        onPressed: () async {
                          await _doaService.reloadDoaData();
                          await _loadDoa(); // load ulang data
                        },
                      ),
                    ],
                  ),
                ),
                // Grid Card untuk doa
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: entry.value.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 card per baris
                    childAspectRatio: 3, // rasio lebar vs tinggi card
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final doa = entry.value[index];
                    return GestureDetector(
                      onTap: () => _showDoaDetail(doa),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              doa.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
