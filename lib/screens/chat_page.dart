import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatbot_app/data/remote/api_helper.dart';
import 'package:chatbot_app/models/message_model.dart';
import 'package:chatbot_app/provider/msg_Provider.dart';
import 'package:chatbot_app/utils/util_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget{
  String query;
  ChatPage({required this.query});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{
  var queryController = TextEditingController();
  List<OfflineMessageModel> listMsg = [];
  DateFormat df = DateFormat.jm();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      Provider.of<MsgProvider>(context, listen: false).sendMessages(message: widget.query);

    });


  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainBlack,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(text: TextSpan(
                      text: "Zippy",
                      style: mTextStyle20(mColor: Colors.white, mFontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: "Chat",
                          style: mTextStyle25(mColor: Colors.amber),
                        )
                      ]
                  )),
                  Row(
                    children: [
                      Text("Bot ", style: mTextStyle20(mColor: AppColors.greyBlack, mFontWeight: FontWeight.bold),),
                      SizedBox(
                          height: 40,
                          child: Image.asset("assets/images/chat_reply_.png")),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: AppColors.greyBlack,
                          shape: BoxShape.circle
                      ),
                      child: Icon(Icons.account_circle_outlined, color: Colors.white, size: 25,))
                ],
              ),
              Divider(),
              Expanded(
                  child: Consumer<MsgProvider>(builder: (context, provider, child){

                    listMsg = provider.fetchAllMessages();

                    return ListView.builder(
                        reverse: true,
                        itemCount: listMsg.length,
                        itemBuilder: (_, index) {
                          return listMsg[index].sendId == 0 ? userChatBox(
                              listMsg[index]) : botChatBox(listMsg[index]);
                        });
                  })
              ),
              TextField(
                style: mTextStyle20(mColor: Colors.white),
                controller: queryController,
                onEditingComplete: (){
                  Provider.of<MsgProvider>(context, listen: false).sendMessages(message: queryController.text);
                },
                onSubmitted: (value){
                  Provider.of<MsgProvider>(context, listen: false).sendMessages(message: value);
                },
                decoration: InputDecoration(
                  //alignLabelWithHint: true,
                  //contentPadding: EdgeInsets.all(20),
                    filled: true,
                    fillColor: AppColors.secondaryBlack,
                    hintText: "Write a question!",
                    hintStyle: mTextStyle20(mColor: AppColors.greyBlack),
                    prefix: Icon(CupertinoIcons.mic, color: AppColors.greyBlack,),
                    suffix: InkWell(
                        onTap: (){
                          Provider.of<MsgProvider>(context, listen: false).sendMessages(message: queryController.text);
                        },
                        child: Icon(Icons.send, color: AppColors.greyBlack,)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///...right side
  Widget userChatBox(OfflineMessageModel msgModel){

    var time = df.format(DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sentAt)));

    return Row(
      children: [
        Container(width: MediaQuery.of(context).size.width*.2,),
        Flexible(
          child: Container(
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: AppColors.greyBlack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: Text(msgModel.msg, style: mTextStyle16(mColor: Colors.white),)),
                Align(
                  alignment: Alignment.bottomRight,
                    child: Text(time, style: mTextStyle10(mColor: Colors.white),)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///...left side
  Widget botChatBox(OfflineMessageModel msgModel){

    var time = df.format(DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sentAt)));

    return Row(
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                    child: !msgModel.isRead ? DefaultTextStyle(
                      style: mTextStyle16(),
                      child: AnimatedTextKit(
                          repeatForever: false,
                          displayFullTextOnTap: true,
                          isRepeatingAnimation: false,
                          onFinished: (){
                            context.read<MsgProvider>().updateMsgRead(msgModel);
                          },


                          animatedTexts: [
                            TyperAnimatedText(msgModel.msg)
                          ]
                      ),
                    ) : Text(msgModel.msg, style: mTextStyle16(),),

                ),
                Text(time, style: mTextStyle10(),),
              ],
            ),
          ),
        ),
        Container(width: MediaQuery.of(context).size.width*.2,),
      ],
    );
  }
}