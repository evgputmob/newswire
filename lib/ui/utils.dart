import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlInApp(String url) async {
  Uri newsItemUrl = Uri.parse(url);
  if (await canLaunchUrl(newsItemUrl)) {
    await launchUrl(
      newsItemUrl,
      mode: LaunchMode.inAppWebView,
    );
  } else {
    throw 'Could not launch';
    // TODO: SnackBar
  }
}
