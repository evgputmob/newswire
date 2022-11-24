import 'package:flutter/material.dart';

abstract class NewsHeaderParams {
  static const kHorizPadding = 11.0;
  static const kTopPadding = 2.0;
  static const kVertPadding = kHorizPadding + kTopPadding;
}

const kLightGreyColor = 0xFFE0E0E0;
const kLightPinkColor = 0xFFFCE4EC;
const kListTileSeparatorColor = 0xFFCECECE;

const kPreviewImgSideSize = 64.0;

abstract class NewsListTileParams {
  static const kIconNewspaper = SizedBox(
    width: kPreviewImgSideSize,
    height: kPreviewImgSideSize,
    child: Center(
      child: Icon(
        Icons.newspaper,
        size: kPreviewImgSideSize,
        color: Color(kLightGreyColor),
      ),
    ),
  );

  static const kIconError = SizedBox(
    width: kPreviewImgSideSize,
    height: kPreviewImgSideSize,
    child: Center(
      child: Icon(
        Icons.error,
        size: kPreviewImgSideSize,
        color: Color(kLightPinkColor),
      ),
    ),
  );
}

const kSearchFieldBorderRadius = 12.0;
const kSearchFieldBorderColor = Color.fromARGB(255, 178, 185, 225);
const kSearchFieldFillColor = Color.fromARGB(204, 255, 255, 255);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Type here...',
  hintStyle: TextStyle(
    color: Colors.black26,
    fontWeight: FontWeight.normal,
    fontSize: 13,
  ),
  isDense: true,
  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
  filled: true,
  fillColor: kSearchFieldFillColor,
  border: OutlineInputBorder(
    borderSide: BorderSide(width: 2),
    borderRadius: BorderRadius.all(Radius.circular(kSearchFieldBorderRadius)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(kSearchFieldBorderRadius)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: (kSearchFieldBorderColor), width: 2),
    borderRadius: BorderRadius.all(Radius.circular(kSearchFieldBorderRadius)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: (kSearchFieldBorderColor), width: 2),
    borderRadius: BorderRadius.all(Radius.circular(kSearchFieldBorderRadius)),
  ),
);
