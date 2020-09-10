import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';

File pickedImage;
File compressedImageFile;

class CameraCapture extends StatefulWidget {
  @override
  _CameraCaptureState createState() => _CameraCaptureState();
}

class _CameraCaptureState extends State<CameraCapture> {
  CameraController controller;
  List<CameraDescription> cameras;
  File imageFile;

  bool loading = true;

  saveCapturedImageToGallery() async {
    await ImageGallerySaver.saveFile(compressedImageFile.path);
  }

  initData() async {
    cameras = await availableCameras();

    CameraDescription frontCamera;

    cameras.forEach((camera) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
      }
    });

    controller = CameraController(frontCamera, ResolutionPreset.ultraHigh);

    await controller.initialize();
    if (this.mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  bool frontCameraEnabled = true;
  CameraLensDirection currentCameraDirection = CameraLensDirection.front;

  updateCameraDirection() async {
    if (frontCameraEnabled) {
      currentCameraDirection = CameraLensDirection.back;
      frontCameraEnabled = false;
    } else {
      currentCameraDirection = CameraLensDirection.front;
      frontCameraEnabled = true;
    }

    CameraDescription selectedCameraOrientation;
    cameras.forEach((camera) {
      if (camera.lensDirection == currentCameraDirection) {
        selectedCameraOrientation = camera;
      }
    });

    controller =
        CameraController(selectedCameraOrientation, ResolutionPreset.high);

    await controller.initialize();
    if (this.mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    pickedImage = null;
    initData();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  getCameraPreview() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (imageFile == null)
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            if (imageFile != null)
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: PhotoView(
                  imageProvider: FileImage(imageFile),
                ),
              ),
            
            
            
            
            
            
          ],
        ),
      ),
    );
  }

  takePictureAndSave() async {
    var temporaryPath = await getTemporaryDirectory();
    var path = '${temporaryPath.path}${DateTime.now()}.png';

    await controller.takePicture(path);
    imageFile = File(path);

    
    compressedImageFile = await FlutterNativeImage.compressImage(
      imageFile.path,
      quality: 70,
      percentage: 100,
    );

    setState(() {});
  }

  getCaptureButton() {
    return Container(
      height: 80.0,
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: takePictureAndSave,
            child: Container(
              width: 60.0,
              height: 60.0,
              padding: EdgeInsets.only(
                top: 2.0,
                bottom: 2.0,
              ),
              margin: EdgeInsets.only(
                left: 64.0,
                right: 40.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: updateCameraDirection,
            child: Container(
              padding: EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.switch_camera,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getSaveButton() {
    return Container(
      padding: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () async {
              setState(() {
                imageFile = null;
              });
            },
            child: Container(
              padding: EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 120.0,
          ),
          InkWell(
            onTap: () async {
              pickedImage = imageFile;
              saveCapturedImageToGallery();
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getBottomView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120.0,
        color: Colors.black,
        padding: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
        ),
        width: MediaQuery.of(context).size.width,
        child: imageFile == null ? getCaptureButton() : getSaveButton(),
      ),
    );
  }

  doActionBack() {
    if (compressedImageFile != null) {
      setState(() {
        imageFile = null;
        compressedImageFile = null;
      });
    } else {
      setState(() {
        compressedImageFile = null;
        Navigator.of(context).pop();
      });
    }
  }

  getBackButton() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: InkWell(
          onTap: doActionBack,
          child: Container(
            padding: EdgeInsets.all(4.0),
            margin: EdgeInsets.only(
              top: 10.0,
              left: 10.0,
            ),
            decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            child: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  getCameraView() {
    return Stack(
      children: <Widget>[
        getCameraPreview(),
        getBottomView(),
        getBackButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Capture"),
        ),
        body: Center(
          child: Image.asset(
            "assets/gif/loading.gif",
            width: 60.0,
            height: 60.0,
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () {
        doActionBack();
        return Future.value(false);
      },
      child: ExScaffold(
        hideAppBar: true,
        title: "Capture",
        backgroundColor: Colors.black,
        body: controller == null ? Container() : getCameraView(),
      ),
    );
  }
}
