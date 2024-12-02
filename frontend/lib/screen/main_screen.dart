import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wav2lip/constants/theme.dart';

import 'package:wav2lip/size_config.dart';
import 'package:wav2lip/widgets/background_container.dart';
import 'package:wav2lip/widgets/custom_button.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/main-screen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String wavFileName = "";
  String mp4FileName = "";
  File? wavFile, mp4File;
  bool isLoading = false;

  Future<void> uploadFiles() async {
    if (wavFile == null || mp4File == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please select both files"),
        duration: Duration(milliseconds: 300),
      ));
      return;
    }

    var request =
        http.MultipartRequest('POST', Uri.parse('$backendURL/upload'));
    request.files
        .add(await http.MultipartFile.fromPath('wavUpload', wavFile!.path));
    request.files
        .add(await http.MultipartFile.fromPath('mp4Upload', mp4File!.path));

    setState(() {
      isLoading = true;
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      final bytes = await response.stream.toBytes();
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/downloaded_file.mp4';
      final file = File(filePath);

      await file.writeAsBytes(bytes);
      setState(() {
        isLoading = false;
      });
      OpenFile.open(filePath);
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to upload files'),
        duration: Duration(milliseconds: 300),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        title: const Text(
          'Wav2Lip',
          style: TextStyle(color: Colors.white70),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: BackgroundContainer(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 96.0,
              bottom: 16.0,
            ),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomButton(
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(allowMultiple: true);

                            if (result != null) {
                              List<File> files = result.paths
                                  .map((path) => File(path!))
                                  .toList();
                              if (files.isNotEmpty) {
                                setState(() {
                                  wavFileName = files[0].path.split('/').last;
                                  wavFile = files[0];
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Please select a file'),
                                  duration: Duration(milliseconds: 300),
                                ));
                              }
                            }
                          },
                          child: const Text("Choose wav file"),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(allowMultiple: true);

                            if (result != null) {
                              List<File> files = result.paths
                                  .map((path) => File(path!))
                                  .toList();
                              if (files.isNotEmpty) {
                                setState(() {
                                  mp4FileName = files[0].path.split('/').last;
                                  mp4File = files[0];
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Please select a file'),
                                  duration: Duration(milliseconds: 300),
                                ));
                              }
                            }
                          },
                          child: const Text("Choose mp4 file"),
                        ),
                        const SizedBox(height: 50),
                        if (wavFile != null)
                          Text(
                            "WavFile: $wavFileName",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const SizedBox(height: 20),
                        if (mp4File != null)
                          Text(
                            "Mp4File: $mp4FileName",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        CustomButton(
                          onPressed: () {
                            uploadFiles();
                          },
                          child: const Text("Upload"),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
