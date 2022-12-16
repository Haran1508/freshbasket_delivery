import 'package:freshbasket_delivery_partner/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';


class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      errorSnackBar("Error", "Map not loading");
    }
  }
}