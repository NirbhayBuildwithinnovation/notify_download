import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:notify_download/calculate_provider.dart';
import 'package:notify_download/download_provider.dart';
import 'package:provider/provider.dart';

class BadgePageExample extends StatelessWidget {
  const BadgePageExample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final downloadProgress =
        context.select((DownloadProvider p) => p.downloadProgress);
    // int numberOfClick = context.select((Calculate counter) => counter.value);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                context.read<DownloadProvider>().createEnqueue();
                context.read<DownloadProvider>().registerIsolate();
              },
              icon: const Icon(Icons.download_for_offline),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     //context.read<DownloadProvider>().reset();
            //     context.read<Calculate>().click = numberOfClick++;
            //     context.read<Calculate>().calculate();
            //   },
            //   child: const Text('Reset'),
            // ),
            Text(
              '$downloadProgress',
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
