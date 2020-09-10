import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ExImagePicker extends StatefulWidget {
  final String id;
  final String value;

  ExImagePicker({
    @required this.id,
    this.value,
  });

  @override
  ExImagePickerState createState() => ExImagePickerState();
}

class ExImagePickerState extends State<ExImagePicker> {
  String imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.value;

    if (imageUrl == null) {
      imageUrl = "";
    }
    Input.set(widget.id, imageUrl);
  }

  uploadImage(File image) async {
    if (image == null) {
      print("Image can't be null");
      return;
    }

    print("image_upload.dart ~~~~~~~~~~~~~ #1");

    String base64Image = base64Encode(image.readAsBytesSync());

    print(base64Image);
  }

  Future browseCamera() async {
    var image = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
    );
    setState(() {
      uploadImage(File(image.path));
    });
  }

  Future browseGallery() async {
    var image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
    );
    setState(() {
      uploadImage(File(image.path));
    });
  }

  Future showBottomSheet(context) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Camera'),
                    onTap: () {
                      browseCamera();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Gallery'),
                  onTap: () {
                    browseGallery();
                  },
                ),
              ],
            ),
          );
        });
  }

  getImagePreview() {
    // if (imageUrl != "" && imageUrl != null && imageUrl != "null") {
    //   return FadeInImage(
    //     placeholder: AssetImage("assets/gif/saji_logo_only_black.gif"),
    //     image: NetworkImage(Session.getAssetUrl(imageUrl)),
    //   );
    // }

    return Image.asset("assets/images/no_photo.png");
  }

  @override
  Widget build(BuildContext context) {
    // if (imageUrl != "") {
    //   print("Loading Image From:");
    //   print(Session.getAssetUrl(imageUrl));
    // }

    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            showBottomSheet(context);
          },
          child: Container(
            width: 120.0,
            height: 120.0,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: getImagePreview(),
          ),
        ),
        Expanded(
          child: Container(
            height: 140.0,
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 10.0,
                ),
                Text(
                  "Maximum file size:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                Text(
                  "10 MB",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Container(
                  height: 6.0,
                ),
                Text(
                  "Format file allowed:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                Text(
                  ".JPG .JPEG .PNG",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Container(
                  height: 6.0,
                ),
                Container(
                  height: 25.0,
                  child: ExButton(
                    label: "Delete",
                    icon: Icons.delete,
                    onPressed: () {
                      setState(() {
                        imageUrl = "";
                        Input.set(widget.id, imageUrl);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
