import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class CardItemWidget extends StatelessWidget {
  final double? width, height;
  final String? backgroundImage, title, subtitle, infoText;
  final Uint8List? rawImage;
  static const titleMaxLines = 2;
  static const titleTextStyle =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0);

  CardItemWidget(
      {this.width = 100,
      this.height = 100,
      this.backgroundImage,
      this.title = "Title",
      this.rawImage,
      this.subtitle = "subtitle",
      this.infoText = "infotext"});

  @override
  Widget build(BuildContext context) {
    final hasRawImage = !(rawImage == null || rawImage!.isEmpty);
    final mainContainer = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: backgroundImage == null ? DecorationImage(
          image: hasRawImage
                  ? MemoryImage(rawImage!) as ImageProvider // Image.memory(rawImage)
                  : FileImage(File(backgroundImage!)),
          fit: BoxFit.cover,
          alignment: AlignmentDirectional.center,
        ) : null,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Container(
            color: Color.fromRGBO(0xff, 0xff, 0xff, 0.5),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                    child: Text(
                  title ?? '',
                  maxLines: titleMaxLines,
                  style: titleTextStyle,
                )),
                Flexible(child: Text(subtitle ?? '')),
                Flexible(child: Text(infoText ?? '')),
              ],
            ),
          ),
        ],
      ),
    );

    return Card(
      elevation: 4.0,
      child: mainContainer,
    );
  }
}
