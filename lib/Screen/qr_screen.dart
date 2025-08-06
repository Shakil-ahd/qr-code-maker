import 'dart:typed_data';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/rendering.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final TextEditingController urlController = TextEditingController();
  final GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    urlController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  Future<void> _saveQrImage() async {
    try {
      if (await Permission.storage.request().isGranted) {
        RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        var image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        final directory = await getExternalStorageDirectory();
        final file = File('${directory!.path}/qr_code.png');
        await file.writeAsBytes(pngBytes);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("QR Code saved successfully.")));
      }
    } catch (e) {
      print("Error saving image: $e");
    }
  }

  Future<void> _shareQrImage() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/qr_code.png');
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)], text: 'Scan this QR code!');
    } catch (e) {
      print("Error sharing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Generator"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: "Enter URL or Text",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (urlController.text.trim().isNotEmpty)
              Column(
                children: [
                  RepaintBoundary(
                    key: globalKey,
                    child: QrImageView(
                      data: urlController.text,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _saveQrImage,
                        icon: const Icon(Icons.download),
                        label: const Text("Download"),
                      ),
                      ElevatedButton.icon(
                        onPressed: _shareQrImage,
                        icon: const Icon(Icons.share),
                        label: const Text("Share"),
                      ),
                    ],
                  ),
                ],
              )
            else
              const Text("Please enter text to generate QR code."),
          ],
        ),
      ),
    );
  }
}
