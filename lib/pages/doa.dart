import 'package:ebadah/model/doa_model.dart';
import 'package:ebadah/model/doa_services.dart';
import 'package:flutter/material.dart';

class DoaPage extends StatefulWidget {
  const DoaPage({super.key});

  @override
  State<DoaPage> createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  final doaService = DoaService();

  List<DoaModel> doaList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await doaService.insertDummyData();

    final data = await doaService.getAllDoa();

    setState(() {
      doaList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doa Harian")),
      body: ListView.builder(
        itemCount: doaList.length,
        itemBuilder: (context, index) {
          final doa = doaList[index];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doa.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doa.arabic,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(doa.latin),
                  const SizedBox(height: 8),
                  Text(doa.translation),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
