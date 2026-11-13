import 'package:chatbot_app/screens/chat_page.dart';
import 'package:chatbot_app/utils/app_constant.dart';
import 'package:chatbot_app/utils/util_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget{
  @override
  State<InitialPage> createState() => _InitialPageState();
}


class _InitialPageState extends State<InitialPage>{
  var queryController = TextEditingController();
  int selectedIndex = 0;

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
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.greyBlack,
                      shape: BoxShape.circle
                    ),
                      child: Icon(Icons.account_circle_outlined, color: Colors.white, size: 25,))
                ],
              ),
              SizedBox(height: 20,),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.chat_bubble_outline, color: AppColors.greyBlack, size: 20,),
                  SizedBox(width: 3,),
                  Text("New chat", style: mTextStyle16(mColor: AppColors.greyBlack),),
                  Spacer(),
                  Icon(Icons.history, color: AppColors.greyBlack, size: 20,),
                  SizedBox(width: 3,),
                  Text("History", style: mTextStyle16(mColor: AppColors.greyBlack),),
                ],
              ),
              SizedBox(height: 11,),
              TextField(
                style: mTextStyle20(mColor: Colors.white),
                maxLines: 6,
                minLines: 6,
                controller: queryController,
                onEditingComplete: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(query: queryController.text)));
                },
                onSubmitted: (value){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(query: value)));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(query: queryController.text)));
                    },
                      child: Icon(Icons.send, color: AppColors.greyBlack,)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none
                  )
                ),
              ),
              SizedBox(height: 11,),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: AppConstant.defaultQues.length,
                    itemBuilder: (_, index){
                  return InkWell(
                    onTap: (){
                      selectedIndex = index;
                      setState(() {

                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.5),
                      padding: EdgeInsets.symmetric(horizontal: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: index == selectedIndex ? Border.all(
                            color: Colors.amber
                        ) : null
                      ),
                      child: Center(child: Text(AppConstant.defaultQues[index]["title"], style: mTextStyle20(mColor: index == selectedIndex ? Colors.amber : AppColors.greyBlack, mFontWeight: FontWeight.bold),)),
                    ),
                  );
                }),
              ),
              SizedBox(height: 11,),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      //mainAxisExtent: 3
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8
                    ),
                    itemCount: AppConstant.defaultQues[selectedIndex]["ques"].length,
                    itemBuilder: (_, index){

                      Map<String, dynamic> currItem = AppConstant.defaultQues[selectedIndex]["ques"][index];

                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(query: currItem["question"])));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 11),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryBlack,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: currItem["color"],
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(currItem["icon"], color: Colors.white, size: 25,)),
                              ),
                              Expanded(child: Text(currItem["question"], style: mTextStyle16(mColor: Colors.white, mFontWeight: FontWeight.bold),))
                            ],
                          ),
                        ),
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}