import 'package:chatbot_app/data/remote/api_helper.dart';
import 'package:chatbot_app/models/ai_res_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/message_model.dart';

class MsgProvider extends ChangeNotifier{

  List<OfflineMessageModel> _listMsg = [];

  sendMessages({required String message}) async {


    //await Future.delayed(Duration(seconds: 1));

    _listMsg.insert(0, OfflineMessageModel(
        msg: message,
        sendId: 0,
        sentAt: DateTime.now().millisecondsSinceEpoch.toString()
    ));

    notifyListeners();

    try{
      var mData = await ApiHelper().sendMsgApi(msg: message);

      FinalGroqModel finalGroqModel = FinalGroqModel.fromJson(mData);

      _listMsg.insert(0, OfflineMessageModel(
          msg: finalGroqModel.choices[0].message.content,
          sendId: 1,
          sentAt: DateTime.now().millisecondsSinceEpoch.toString()
      ));

      notifyListeners();

    } catch (e){
      _listMsg.insert(0, OfflineMessageModel(
          msg: e.toString(),
          sendId: 1,
          sentAt: DateTime.now().millisecondsSinceEpoch.toString()
      ));

      notifyListeners();
    }

  }

  fetchAllMessages(){
    return _listMsg;
  }

  void updateMsgRead(OfflineMessageModel msg){
    msg.isRead = true;
    notifyListeners();
  }

}