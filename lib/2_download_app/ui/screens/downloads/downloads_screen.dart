import 'package:flutter/material.dart';
import 'package:someth_w4_pratice/2_download_app/ui/screens/downloads/widgets/download_tile.dart';
import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widgets/download_controler.dart';


class DownloadsScreen extends StatelessWidget {
  // Create the list of fake resources
  final List<Resource> resources = [
    Resource(name: "image1.png", size: 120),
    Resource(name: "image2.png", size: 500),
    Resource(name: "image3.png", size: 12000),
  ];

  final List<DownloadController> controllers = [];

  DownloadsScreen({super.key}) {
    // Create a controllers for each resource
    for (Resource resource in resources) {
      controllers.add(DownloadController(resource));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: themeColorProvider.currentThemeColor.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            "Downloads",
            style: AppTextStyles.heading.copyWith(
              color: themeColorProvider.currentThemeColor.color,
            ),
          ),

          SizedBox(height: 50),

          // TODO - Add the Download tiles
          Column(
            children: controllers
              .map((controller) => DownloadTile(controller: controller))
              .toList(),
          )
        ],
      ),
    );
  }
}
