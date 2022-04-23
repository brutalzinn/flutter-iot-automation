
#define WIFI_SSID "paes"
#define WIFI_PASS "garfield laranja"
const char* mqttserver = "192.168.0.35";
const int mqttserverport = 1883;
const char* mqttuser = "teste";
const char* mqttpass = "teste";
const char* MQTTQUEUEINPUT = "topic/ventilador/entrada";
const char* MQTTQUEUEOUTPUT = "topic/ventilador/saida";
long interval = 5000;
IPAddress ip(192,168,0,98);
IPAddress gateway(192,168,0,1);
IPAddress subnet(255,255,255,0);
IPAddress dns(192,168,0,1);
