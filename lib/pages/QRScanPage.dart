import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class QRScanPage extends StatefulWidget {
  QRScanPage({Key key}) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  _qrCallback(String code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
      print("scan callback: " + _qrInfo);
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: getAppBar(context),
        body: Stack(
      fit: StackFit.expand,
      children: [
        _camState
            ? Center(
                child: SizedBox(
                  height: 1000,
                  width: 500,
                  child: QRBarScannerCamera(
                    onError: (context, error) => Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                    qrCodeCallback: (code) {
                      _qrCallback(code);
                    },
                  ),
                ),
              )
            : Center(
                child: Text(_qrInfo),
              ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QRScanPage()));
            },
          ),
        )
      ],
    ));
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('Notifications'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
