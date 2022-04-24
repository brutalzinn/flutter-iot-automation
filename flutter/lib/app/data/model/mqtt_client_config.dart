
class MQTTConnection
{
  String mQTTHost;
  int mQTTPORT;
  String mQTTUSER;
  String mQTTPASSWORD;
  String mQTTID;
  String mqTTtopic;
  dynamic onEvent; //deveria ser um function()?

  MQTTConnection({required this.mQTTHost, required this.mQTTPORT, required this.mQTTUSER, required this.mQTTID, required this.mQTTPASSWORD, required this.mqTTtopic, this.onEvent});
  
  factory MQTTConnection.fromJson(Map<String, dynamic> json) => MQTTConnection(
      mQTTHost: json["mQTTHost"],
      mQTTPORT: json["mQTTPORT"],
      mQTTUSER: json["mQTTUSER"],
      mQTTPASSWORD: json["mQTTPASSWORD"],
      mQTTID: json["mQTTID"],
      mqTTtopic: json["mqTTtopic"]

  );

  Map<String, dynamic> toJson() => {
        "mQTTHost": mQTTHost,
        "mQTTPORT": mQTTPORT,
        "mQTTUSER": mQTTUSER,
        "mQTTPASSWORD": mQTTPASSWORD,
        "mQTTID": mQTTID,
        "mqTTtopic": mqTTtopic,
      };

}