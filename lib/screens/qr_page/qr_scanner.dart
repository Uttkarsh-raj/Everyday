import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:url_launcher/url_launcher.dart';

import '../home_page/home_page.dart';

class QrScan extends StatefulWidget {
  const QrScan({super.key, required this.amount});
  final String amount;
  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    await controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(children: [
            buildQrView(context),
            Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (() async {
                            await Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyHomePage()),
                                ModalRoute.withName('/Home'));
                          }),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 40,
                            color: Color.fromARGB(255, 237, 237, 237),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.63),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: buildResult(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildResult() {
    try {
      if (barcode!.code!.isNotEmpty) {
        controller?.pauseCamera();
        const Duration(seconds: 5);
      }
      controller?.resumeCamera();
    } catch (e) {}
    return Text(
      barcode != null ? '${barcode!.code}' : 'Scan a code!',
      maxLines: 3,
      style: TextStyle(
        color: Colors.blue[300],
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 8,
          borderRadius: 15,
          borderColor: Colors.blue,
        ),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode) => setState((() {
          this.barcode = barcode;
          launcherUrl();
        })));
    setState(
      () {
        controller.resumeCamera();
      },
    );
  }

  void launcherUrl() async {
    var url = '${barcode!.code}';
    if (await launchUrl(Uri.parse(url))) {
      await canLaunchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
