import 'dart:convert';
import 'dart:io';

import 'package:chatbot_app/data/remote/urls.dart';
import 'package:chatbot_app/secrets.dart';
import 'package:http/http.dart' as http;

class ApiHelper {

  Future<dynamic> sendMsgApi({required String msg}) async {
    try{
      var res = await http.post(
          Uri.parse(Urls.chatAIUrl),
          body: json.encode({
            "model": "openai/gpt-oss-120b",
            "messages": [{
              "role": "user",
              "content": msg
            }]
          }),
          headers: {
            "Authorization" : "Bearer ${Secrets.GROQ_API_KEY}",
            "Content-Type" : "application/json"
          }
      );

      print(res.body);

      if(res.statusCode == 200){
        var data = jsonDecode(res.body);

        if(data['error'] != null){
          throw(HttpException(data['error']['message']));
        }

        return data;

      }

    } catch (e){
      throw HttpException(e.toString());

    }

  }



}