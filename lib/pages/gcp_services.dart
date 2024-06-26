import 'dart:convert';

// import 'package:googleapis/bigquery/v2.dart';
// import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class GcpService {
  GcpService();

  Future<void> main() async {
    const projectId = 'indigo-anchor-339414';
    const datasetId = 'testongDataset';
    const tableId = 'avocado';
    const apiKey =
        '-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDMU/vAz8HF8OUp\nreU+6eR86nWcI66xgVOmy1rPIe7uIly6tRFSC4ZkMqrm4zuou2jUAANx8GHpAejT\nfBuFofZbq+ZqUU228DIrsF61pVSnF+oKTCaz1CTGXHrl6DOIC0caZVaorN41hgRn\nwQ9v6PZxlJV1oGTsIc5F/aHeHFVq71SxnNwoQ0oaldwrNUxdcECg9IOpWHfyTf+s\n6/jcHZCdJU6CWUYfKgnNG2uYWZsqdldRsTmh7imHqCk3k44OvfjCmOU3lcQUz8BJ\nRJulrwo7lA7qry7NDUuW3Vs8DLxOutkjA96eppk9oKC8YeVrWun0e/DyjiWGXjFF\nv0Qvif37AgMBAAECggEAA5guOeTNvigwBKaVylOkaXTy1bWkL8sCu2pUMiGg/OWn\nQPRir7e0YqEOwM1Avuw94PQRG3K4BJ8I4M0lnmYZGeEkkzxthA+mQ+UWsKMnocet\nBKDBuFckJt/4nE1hHrF05XUT7BeCbAM41gRsIf/Bc7UPJG8XNDcFOtXGTUx6GjPy\n9+3Ny4zrTyNLrzUjOQsUAhFnH+EXSGo+gjixHPQfS4OP0g+fhKOiwlLnAksPjSC/\nRXozV0bdWBeSvCc9cMM0+bUW2USwuS91oT9lTu+GMFJPtpKasa+YDL2DtupXipxE\ns+TtFP5LQJubu9ZH4g6vXThJ+enneHeUV2lyWO8BNQKBgQDxfyDEE4LGGp7lzTV5\npYxQfV3RY9whpPoZEqwW0oIXBfY1gJ9NGQEMyQOHd2hSW9Sk7EBFkEFKe1OiY0um\n8kV9bIjvfulER2IlYqccZLJ4frM+VdSHf9eUindADnbAeEwDiuoXmcHnQPuk9Ruu\nCGR/f+M+2MbwfaqL1B6bIX42JwKBgQDYmWkU07ujt8w8ORcFPRjioNJczxBL7ln6\ny13aE/3JkIKJM/G2LG3po92vU5OMOUKBNP8VLnlI4t6t7RbahT6yPuNnh+GMa5M3\nfO/A83v/ZcS3yDt5YlROMH1dXTmZTY9W4RTreabjkeoTaqHfpYo06x1CeehLwYYl\nhgOooymSDQKBgQCdIn4cdyGJa3rmxh68d3aUTO6Ft3ddwO4m8FpfQzv4ZR2t9HIz\nBUkEm6sbMxwDMtNrOHodiV6iaxqhOADasRt8H+n+A9MeZWA8OTPJKtBhzPcuYUS3\nofyRH4O2f3LPi7bSO0pUbuyXX1YeIIqRM87Ik1s24nCXvP0CnNQJVsK70wKBgH8Q\nUBLFuzfp5MgXfae3FdgtG/sSBa9lnieAEgiS3bjXK5ytekiye7AqTyxBTTdfh+Ig\nYtvcLY5SeOtzQIrky8jpF6JuliQ4H17XzhZVQBKtct+VeT5WLrrHu2OAAwAp/cKr\nvAf/j6XEvZqyXU/D3vX4T2vl9B4s4zM0EQVm4kYpAoGBAIzPM/G4rB6a2PrT/FI9\n87fBoCuVy7KDuufZf8ppVD3j8SSd4sXP1osJ+a1rNl5inkeG0/xmW3+Z1vWOA0Bj\nx9Aa738Ld7j0sAKjK6Dtw4XQtWsMu8wl5DIkhCvfAaka60kbC4TkNAV9bdaZM7k0\nVh3QinuvpKCkDsr5lsE+7ft2\n-----END PRIVATE KEY-----\n'; // Replace with your API key

    // Construct your SQL query
    const query = """
    SELECT *
    FROM `$projectId.$datasetId.$tableId`
    LIMIT 10
  """;

    print(query);

    // // Make a GET request to BigQuery API
    // final url = Uri.parse(
    //     'https://bigquery.googleapis.com/bigquery/v2/projects/$projectId/queries'
    //     '?key=$apiKey'
    //     '&query=${Uri.encodeQueryComponent(query)}'
    //     '&useLegacySql=false');

    // final response = await http.get(url);

    // Make a POST request to BigQuery API
    final url = Uri.parse(
        'https://bigquery.googleapis.com/bigquery/v2/projects/$projectId/queries?key=$apiKey');
    final body = jsonEncode({
      'query': query,
      'useLegacySql': false,
    });

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      // Parse the response
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  }
}
