
class MQTTConnection
{
  String mQTTHost;
  int mQTTPORT;
  String mQTTUSER;
  String mQTTPASSWORD;
  String mQTTID;
  dynamic onEvent; //deveria ser um function()?

  MQTTConnection(this.mQTTHost, this.mQTTPORT, this.mQTTUSER, this.mQTTID, this.mQTTPASSWORD, this.onEvent);


}