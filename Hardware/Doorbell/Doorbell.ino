#include <EEPROM.h>
#include <ESP8266WiFi.h>

#define RESERVED 10
#define SSID_FLASH_SPACE 50
#define PASS_FLASH_SPACE 50

typedef struct {
  String key;
  String value;
} httpData;

int total_flash_space = RESERVED + SSID_FLASH_SPACE + PASS_FLASH_SPACE;

WiFiServer server(80);

String header;

void setup() {
  Serial.begin(115200);
  EEPROM.begin(total_flash_space);
  
  Serial.println();
  Serial.println();

/*  RESERVED FLASH BYTES (0-9)
    0 - SETUP COMPLETED
*/
  
  Serial.println(EEPROM[0] ? "Setup completed" : "Setup in progress");

  if(EEPROM[0]) {    
    String ssid = read_String(RESERVED);
    String pass = read_String(RESERVED + SSID_FLASH_SPACE);

    WiFi.begin(ssid, pass);
    
    Serial.println();
    Serial.print("Connecting to network ");
    Serial.println(ssid);

    int counter = 0;
    while(WiFi.status() != WL_CONNECTED && tries <= 120) {
      delay(500);
      Serial.print(".");
      counter += 1;
    }

    if(WiFi.status() != WL_CONNECTED) {
      Serial.println("Failed to connect to network");
      Serial.println();
      
      Serial.print("Setting up soft-AP (Access Point)… ");
      Serial.println((WiFi.softAP("Doorbell Setup")) ? "DONE" : "FAILED");
    
      IPAddress IP = WiFi.softAPIP();
      Serial.print("AP IP address: ");
      Serial.println(IP);
      Serial.println();
    } else {
      Serial.println();
      Serial.print("Connected to " + ssid + " with IP address: ");
      Serial.println(WiFi.localIP());
    }
    
  } else {
    Serial.println();
    Serial.print("Setting up soft-AP (Access Point)… ");
    Serial.println((WiFi.softAP("Doorbell Setup")) ? "DONE" : "FAILED");
  
    IPAddress IP = WiFi.softAPIP();
    Serial.print("AP IP address: ");
    Serial.println(IP);
    Serial.println();
  }

  server.begin();
}

void loop(){
  
  
  API();
  
   
}
