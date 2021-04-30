import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:candix/core/controllers/j.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:candix/core/services/_api.dart';

class FunctionService extends API {
  Future<NetworkResponse> upload(List<File> files) async {
    try {
      Get.snackbar('Running', 'Uploading file${files.length > 1? 's' : ''}');
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(uri('functions/upload')));
      request.headers
          .addAll({...J.authorization});

      for (File f in files) {
        request.files.add(await http.MultipartFile.fromPath(
            "uploads[${files.indexOf(f)}]", f.path));
      }

      http.StreamedResponse response = await request.send();
      Uint8List data = await response.stream.toBytes();
      String dataString = String.fromCharCodes(data);

      Map<String, Object?> verified = jsonDecode(dataString);

      return NetworkResponse(verified)
        ..log("File${files.length > 1 ? 's' : ''} Uploaded");
    } catch (e) {
      return NetworkResponse({
        "error": true,
        "errors": {
          "upload": [e.toString()]
        }
      })
        ..log();
    }
  }
}
