class UrlList {
  UrlList._();

  static String baseurl =
      "http://demo1.greenmainfotech.com/nammafreshbasket/api/delivery/";

  ///[EndPoints List]
  static Map? endpoints = {
    'login': baseurl + 'login.php',
    'profile': baseurl + 'profile.php',
    'assignedOrders': baseurl + 'assignedOrders.php',
    'orders': baseurl + 'orderDetails.php',
    'updateOrder': baseurl + 'updateOrder.php',
    'orderHistory': baseurl + 'orderHistory.php',
    'notifications': baseurl + 'notifications.php',
  };

  String productsEndPoint = "products.php";

  static String _apikey = "randomkeyforsecretaccess";

  static get apikey => _apikey;

  static Map<String, String> requestType = {
    'namdeliverylogin': 'namdeliverylogin',
    'namdeliveryprofile': 'namdeliveryprofile',
    'namdeliveryassignedorders': 'namdeliveryassignedorders',
    'namdeliveryorderrequest': 'namdeliveryorderrequest',
    'namdeliveryupdateorder': 'namdeliveryupdateorder',
    'namdeliveryorderhistory': 'namdeliveryorderhistory',
    'namdeliverynotifications': 'namdeliverynotifications',
  };
}
