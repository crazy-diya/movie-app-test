import 'package:flutter/material.dart';
import 'package:mock_movies_app/utils/app_strings.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print("Shit init 2");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.downloadNavText),
      ),
    );
  }
}
