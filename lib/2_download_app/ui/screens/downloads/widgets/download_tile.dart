import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  // TODO

  @override
  Widget build(BuildContext context) {
    // TODO
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        String subtitleText;
        Widget trailingWidget;

        switch (controller.status) {
          case DownloadStatus.notDownloaded:
            subtitleText = '';
            trailingWidget = IconButton(
              onPressed: controller.startDownload,
              icon: Icon(Icons.download),
            );
            break;
          case DownloadStatus.downloading:
            final downloadSize = controller.progress * controller.resource.size;
            final percentage = controller.progress * 100;

            subtitleText =
                '${percentage.toStringAsFixed(1)} % completed - ${downloadSize.toStringAsFixed(1)} of ${controller.resource.size} MB';

            trailingWidget = IconButton(
              onPressed: controller.startDownload,
              icon: Icon(Icons.stop_circle),
            );
            break;

          case DownloadStatus.downloaded:
            subtitleText = '100.0 % completed - ${controller.resource.size.toStringAsFixed(1)} of ${controller.resource.size} MB';
            trailingWidget = Icon(Icons.folder);
            break;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(controller.resource.name),
              subtitle: subtitleText.isEmpty ? null : Text(subtitleText),
              trailing: trailingWidget,
            ),
          ),
        );
      },
    );
  }
}
