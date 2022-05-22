// import 'package:http/http.dart' as http;
// import 'package:http_auth/http_auth.dart';
// import 'dart:convert' as convert;

// class PaypalServices {
//   String domain = "https://api.sandbox.paypal.com";
//   String clientId = '';
//   String secret = '';

//   Future<String> getAccessToken() async {
//     try {
//       var client = BasicAuthClient(clientId, secret);
//       var response = await client.post(
//           Uri.parse("$domain/v1/oauth2/token?grant_type=client_credentials"));
//       if (response.statusCode == 200) {
//         final body = convert.jsonDecode(response.body);
//         return body["access_token"];
//       }
//       return "0";
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Map<String, String>> createPaypalPayment(
//       transactions, accessToken) async {
//     var reponse = await http.post(Uri.parse("$domain/v1/payments/payment"));
//   }
// }
