
class MessageModel{
  String content;
  String? reasoning;
  String role;

  MessageModel({
    required this.content,
    required this.reasoning,
    required this.role,
});

  // from json
  factory MessageModel.fromJson(Map<String, dynamic> json){
    return MessageModel(
        content: json["content"],
        reasoning: json["reasoning"],
        role: json["role"]
    );
  }

  // to json
  Map<String, dynamic> toJson(){
    return {
      "content" : content,
      "reasoning" : reasoning,
      "role" : role,
    };
  }

}

class ChoicesModel{
  String finish_reason;
  int index;
  dynamic logprobs;
  MessageModel message;

  ChoicesModel({
    required this.finish_reason,
    required this.index,
    required this.logprobs,
    required this.message,
  });

  // from json
factory ChoicesModel.fromJson(Map<String, dynamic> json){
  return ChoicesModel(
      finish_reason: json["finish_reason"],
      index: json["index"],
      logprobs: json["logprobs"],
      message: MessageModel.fromJson(json["message"])
  );
}

  // to json
Map<String, dynamic> toJson(){
  return {
    "finish_reason" : finish_reason,
    "index" : index,
    "logprobs" : logprobs,
    "message" : message.toJson(),
  };
}

}

class CompletionTokensDetailsModel{
  int reasoning_tokens;
  CompletionTokensDetailsModel({required this.reasoning_tokens});

  //from json
  factory CompletionTokensDetailsModel.fromJson(Map<String, dynamic> json){
    return CompletionTokensDetailsModel(
        reasoning_tokens: json["reasoning_tokens"]
    );
  }

  //to json
  Map<String, dynamic> toJson(){
    return {
      "reasoning_tokens" : reasoning_tokens
    };
  }
}

class UsageModel{
  double completion_time;
  int completion_tokens;
  CompletionTokensDetailsModel? completion_tokens_details;
  double prompt_time;
  int prompt_tokens;
  double queue_time;
  double total_time;
  int total_tokens;

  UsageModel({
    required this.completion_time,
    required this.completion_tokens,
    required this.completion_tokens_details,
    required this.prompt_time,
    required this.prompt_tokens,
    required this.queue_time,
    required this.total_time,
    required this.total_tokens,
});

  // from json
  factory UsageModel.fromJson(Map<String, dynamic>json){
    return UsageModel(
        completion_time: json["completion_time"],
        completion_tokens: json["completion_tokens"],
        completion_tokens_details: json["completion_tokens_details"] == null ? null : CompletionTokensDetailsModel.fromJson(json["completion_tokens_details"]),
        prompt_time: json["prompt_time"],
        prompt_tokens: json["prompt_tokens"],
        queue_time: json["queue_time"],
        total_time: json["total_time"],
        total_tokens: json["total_tokens"]
    );
  }

  // to json
  Map<String, dynamic> toJson(){
    return {
      "completion_time" : completion_time,
      "completion_tokens" : completion_tokens,
      "completion_tokens_details" : completion_tokens_details == null ? null : completion_tokens_details!.toJson(),
      "prompt_time" : prompt_time,
      "prompt_tokens" : prompt_tokens,
      "queue_time" : queue_time,
      "total_time" : total_time,
      "total_tokens" : total_tokens,
    };
  }

}

class XGroqModel{
  String id;
  int seed;

  XGroqModel({required this.id, required this.seed});

  //from json
  factory XGroqModel.fromJson(Map<String, dynamic> json){
    return XGroqModel(
        id: json["id"],
        seed: json["seed"]);
  }

  // to json
  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "seed" : seed,
    };
  }
}

class FinalGroqModel{
  List<ChoicesModel> choices;
  int created;
  String id;
  String model;
  String object;
  String service_tier;
  String system_fingerprint;
  UsageModel usage;
  dynamic usage_breakdown;
  XGroqModel x_groq;

  FinalGroqModel({
    required this.choices,
    required this.created,
    required this.id,
    required this.model,
    required this.object,
    required this.service_tier,
    required this.system_fingerprint,
    required this.usage,
    required this.usage_breakdown,
    required this.x_groq,
});

  // from json
  factory FinalGroqModel.fromJson(Map<String, dynamic> json){

    //choices list
    List<ChoicesModel> listChoices = [];

    for(Map<String, dynamic> choice in json["choices"]){
      listChoices.add(ChoicesModel.fromJson(choice));
    }

    return FinalGroqModel(
        choices: listChoices,
        created: json["created"],
        id: json["id"],
        model: json["model"],
        object: json["object"],
        service_tier: json["service_tier"],
        system_fingerprint: json["system_fingerprint"],
        usage: UsageModel.fromJson(json["usage"]),
        usage_breakdown: json["usage_breakdown"],
        x_groq: XGroqModel.fromJson(json["x_groq"])
    );
  }

  // to json
  Map<String, dynamic> toJson(){

    List<Map<String, dynamic>> listOfMapChoices = [];
    for(ChoicesModel eachChoice in choices){
      listOfMapChoices.add(eachChoice.toJson());
    }

    return {
      "choices" : listOfMapChoices,
      "created" : created,
      "id" : id,
      "model" : model,
      "object" : object,
      "service_tier" : service_tier,
      "system_fingerprint" : system_fingerprint,
      "usage" : usage.toJson(),
      "usage_breakdown" : usage_breakdown,
      "x_groq" : x_groq.toJson(),

    };
  }

}