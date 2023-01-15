import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wechat_redesign/blocs/scan_qr_bloc.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/widgets/loading_view.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScanQrBloc(),
      child: Consumer<ScanQrBloc>(builder: (context, bloc, child) {
        return Stack(
          children: [
            Scaffold(
              body: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: (controller) =>
                          _onQRViewCreated(context, controller),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/scan.png',
                        ),
                        SizedBox(
                          height: MARGIN_LARGE_3,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(MARGIN_MEDIUM),
                          child: (result != null)
                              ? Text('${result!.code}')
                              : const Text('Scan a code'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: bloc.isLoading,
              child: LoadingView(),
            ),
          ],
        );
      }),
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result?.code != null) {
        context
            .read<ScanQrBloc>()
            .addNewContant(result?.code ?? '')
            .then((value) {
          controller.dispose();
          if (mounted) {
            Navigator.pop(qrKey.currentContext ?? context);
          }
        }).onError((error, stackTrace) {});
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }
}
