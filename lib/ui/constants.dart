import 'package:flutter/material.dart';

abstract class NewsHeaderParams {
  static const kHorizPadding = 11.0;
  static const kTopPadding = 2.0;
  static const kVertPadding = kHorizPadding + kTopPadding;
}

const clrLightGrey = 0xFFE0E0E0;
const clrLightPink = 0xFFFCE4EC;
const clrListTileSeparator = 0xFFCECECE;

abstract class NewsListTileParams {
  static const kPreviewImgSideSize = 64.0;

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
