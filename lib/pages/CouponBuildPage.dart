import 'dart:io';

import 'package:coupon_app/components/FlatBottomButton.dart';
import 'package:coupon_app/components/OneLineInputWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class CouponbuildPage extends StatefulWidget {
  CouponbuildPage({Key key}) : super(key: key);

  @override
  _CouponbuildPageState createState() => _CouponbuildPageState();
}

class _CouponbuildPageState extends State<CouponbuildPage> {
  double _screenHeight;
  double _screenWidth;
  BuildContext _context;
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;
  TextEditingController _couponTitleInputController;
  TextEditingController _couponDescriptionInputController;

  final ImagePicker _picker = ImagePicker();

  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    _context = context;
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: getAppBar(context),
      body: getBody(),
      bottomNavigationBar: getBottomButtons(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "Coupon Recipe",
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }

  Widget getBody() {
    return SafeArea(
        bottom: false,
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              getImageArea(),
              SizedBox(
                height: 40,
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
                  child: OneLineInputWidget(
                    width: _screenWidth,
                    height: 50.0,
                    hint: "Title",
                    fontSize: 20.0,
                    textEditingController: _couponTitleInputController,
                    maxLength: 10,
                  )),
              SizedBox(
                height: 40,
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: OneLineInputWidget(
                    width: _screenWidth,
                    height: 50.0,
                    hint: "Description",
                    fontSize: 20.0,
                    textEditingController: _couponDescriptionInputController,
                  ))
            ])));
  }

  Widget getImageArea() {
    return Container(
        width: _screenWidth,
        height: _screenHeight * 2 / 5,
        color: Theme.of(_context).primaryColor,
        child: InkWell(
            onTap: _pickImage,
            child: Stack(fit: StackFit.expand, children: [
              _previewImage(),
              _imageFile == null
                  ? Container()
                  : Positioned(
                      right: 0,
                      bottom: 0,
                      child: getEditIconButton(),
                    )
            ])));
  }

  Widget getEditIconButton() {
    return MaterialButton(
      onPressed: () {
        _cropImage();
      },
      color: Theme.of(context).primaryColor,
      child: Icon(
        Icons.crop,
        size: 25,
        color: Colors.white,
      ),
      padding: EdgeInsets.all(5),
      shape: CircleBorder(),
    );
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: File(_imageFile.path),
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    // _lastCropped?.delete();
    // _lastCropped = file;
    debugPrint('$file');
    setState(() {
      _imageFile = PickedFile(file.path);
    });
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      print("image file not null");
      // if (kIsWeb) {
      //   // Why network?
      //   // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
      //   return Image.network(_imageFile.path);
      // } else {
      // return Semantics(
      //     child: Image.file(File(_imageFile.path)),
      //     label: 'image_picker_example_picked_image');
      // }
      return Crop.file(File(_imageFile.path), key: cropKey);
    } else {
      print("image file null");
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: IconButton(
                icon: Icon(
                  _pickImageError == null
                      ? Icons.add_photo_alternate
                      : Icons.error,
                  color: Colors.white,
                  size: 100.0,
                ),
                onPressed: () {
                  print("pick image button clicked");
                  _pickImage();
                }),
          ),
          Text(
            _pickImageError == null
                ? "Choose Coupon Image"
                : "Choose Coupon Image Error $_pickImageError",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      );
    }
  }

  Future<Null> _pickImage() async {
    try {
      PickedFile imageFile =
          await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = imageFile;
      });
    } catch (e) {
      _pickImageError = e;
    }
  }

  Widget getBottomButtons() {
    return FlatBottomButton(
      width: _screenWidth,
      text: "SAVE",
      onPressed: () {
        print("Save button pressed");
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => QRScanPage()));
      },
    );
  }
}
