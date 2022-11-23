import 'package:flutter/material.dart';

abstract class NewsHeaderParams {
  static const kHorizPadding = 11.0;
  static const kTopPadding = 2.0;
  static const kVertPadding = kHorizPadding + kTopPadding;
}

const clrLightGrey = 0xFFE0E0E0;
const clrLightPink = 0xFFFCE4EC;
const clrListTileSeparator = 0xFFCECECE;

const kPreviewImgSideSize = 64.0;

abstract class NewsListTileParams {
  static const kIconNewspaper = SizedBox(
    width: kPreviewImgSideSize,
    height: kPreviewImgSideSize,
    child: Center(
      child: Icon(
        Icons.newspaper,
        size: kPreviewImgSideSize,
        color: Color(clrLightGrey),
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
        color: Color(clrLightPink),
      ),
    ),
  );
}

const kTextFieldBorderRadius = 12.0;

const clrTextFieldBorder = 0xFF9FA8DA;

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal),
  isDense: true,
  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
  border: OutlineInputBorder(
    borderSide: BorderSide(width: 2),
    borderRadius: BorderRadius.all(Radius.circular(kTextFieldBorderRadius)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(kTextFieldBorderRadius)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(clrTextFieldBorder), width: 2),
    borderRadius: BorderRadius.all(Radius.circular(kTextFieldBorderRadius)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(clrTextFieldBorder), width: 2),
    borderRadius: BorderRadius.all(Radius.circular(kTextFieldBorderRadius)),
  ),
  filled: true,
  fillColor: Colors.white,
);
