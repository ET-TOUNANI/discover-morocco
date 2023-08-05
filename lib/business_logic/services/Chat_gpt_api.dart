import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:discover_morocco/business_logic/models/chat_model.dart';
import 'package:discover_morocco/business_logic/utils/logicConstants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatGptAPI {
  late Dio dio;

  ChatGptAPI() {
    BaseOptions options = BaseOptions(
        baseUrl: Constant.baseUrl,
        contentType: "application/json",
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${dotenv.get('API_KEY')}'
        });

    dio = Dio(options);
  }

  Future<ChatModel> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await dio.post("${Constant.baseUrl}/chat/completions",
          data: jsonEncode({
            "messages": [
              {"role": "user", "content": message}
            ],
            "key": dotenv.get('apiKey'),
            "model": modelId,
            "temperature": 0.7,
            "max_tokens": 4000
          }));
      log("response data: ${jsonEncode(response.data)}");
      return ChatModel.fromJson(response.data);
    } catch (error) {
      log("error here :  $error");
      rethrow;
    }
  }
}
