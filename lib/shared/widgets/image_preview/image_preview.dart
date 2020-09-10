import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:pos_app/core.dart';

class ImagePreview extends StatefulWidget {
  final String assetUrl;
  final dynamic imageBinary;
  ImagePreview({
    this.assetUrl,
    this.imageBinary,
  });

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  dynamic getImage() {
    if (widget.assetUrl != null) {
      return AssetImage(widget.assetUrl);
    }

    if (widget.imageBinary != null) {
      return MemoryImage(widget.imageBinary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExScaffold(
      hideAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PhotoView(
              initialScale: PhotoViewComputedScale.contained,
              imageProvider: getImage(),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(4.0),
                margin: EdgeInsets.only(
                  top: 60.0,
                  right: 10.0,
                ),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: Icon(
                  Icons.close,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
