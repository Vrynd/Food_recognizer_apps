import 'package:flutter/material.dart';
import 'package:food_recognizer_app/widget/scaffold_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWigdet(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        title: Text(
          'Food Recognizer',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: HomeBody(),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 52),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text(
                  'Identifikasi Gambar',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 52),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 0,
                ),
                onPressed: () {},
                label: Icon(Icons.upload_file_outlined, size: 30, color: Theme.of(context).colorScheme.onPrimary,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Food Recognizer',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Arahkan kamera ke makanan yang ingin diidentifikasi',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                height: 450,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Apabila kesulitan mengidentifikasi makanan dengan kamera. anda dapat menggunakan metode upload gambar dengan sebagai alternatif',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
