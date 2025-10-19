// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_interpolation_to_compose_strings, file_names

import 'dart:io';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfViewerPage extends StatefulWidget {
  final File? file;
  final String url;

  const PdfViewerPage({
    super.key,
    this.file,
    required this.url,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  void initState() {
    print(widget.file!.path);
    print(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
       backgroundColor: Customcolors.DECORATION_WHITE,
        title: const Text('Invoice', style: CustomTextStyle.darkgrey),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back_ios,color: Customcolors.DECORATION_DARKGREY,)),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: PDFView(
          filePath: widget.file!.path,
        ),
      ),
    );
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<bool> saveFile(String url, String fileName) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        //final dir = await DownloadsPathProvider.downloadsDirectory;
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/Downloads";
        directory = Directory(newPath);
        print("nee $newPath");

        File saveFile = File(directory.path + "/$fileName");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'successfully saved to internal storage "${saveFile.toString()}" folder',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );

        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await Dio().download(
            url,
            saveFile.path,
          );
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
