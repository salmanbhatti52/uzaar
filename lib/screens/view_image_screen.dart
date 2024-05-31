import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoImageView extends StatefulWidget {
  final String? imagePath;
  final File? fileImagePath;
  const PhotoImageView({Key? key, this.imagePath, this.fileImagePath})
      : super(key: key);

  @override
  State<PhotoImageView> createState() => _PhotoImageViewState();
}

class _PhotoImageViewState extends State<PhotoImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: widget.fileImagePath == null? PhotoView(
              imageProvider: NetworkImage(widget.imagePath!),
            ):PhotoView(
              imageProvider: FileImage(widget.fileImagePath!),
            ),
          ),
        ],
      ),
    );
  }
}