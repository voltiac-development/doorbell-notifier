void API() {
  WiFiClient client = server.available();

  if(client) {
    String currentLine = "";
    
    while(client.connected()) {
      if(client.available()){
        char c = client.read();
        header += c;

        if(c == '\n') {
          if(currentLine.length() == 0) {
            
            String httpResponse = endpoints();

            client.print(httpResponse);

            break;
          } else {
            currentLine = "";
          }
        } else if (c != '\r') {
          currentLine += c;
        }
      }
    }

    header = "";
    client.stop();

  }
}


boolean endpoint(String endpoint) {
  return header.indexOf("GET " + endpoint) >= 0;
}

String endpoints() {

  if(endpoint("/factory_reset")) {
    return factoryReset();
  } else if (endpoint("/ap_turnoff")) {
    return apTurnoff(); 
  } else if (endpoint("/finish_setup")) {
    return finishSetup(); 
  } else if (endpoint("/network/ssid")) {
    return setNetworkSSID();
  } else if (endpoint("/network/password")) {
    return setNetworkPassword();
  } else {
    return defaultResponse();
  }
  
}

String factoryReset() {
  int _size = 1;
  String httpResponse = "";
  httpResponse += HTTP_OK();

  wipeFlash();
  
  httpData pairs[_size];
  pairs[0] = { "msg", "Succesfully reset to factory settings." };

  httpResponse += HTTP_ADD_DATA(pairs, _size);
  return httpResponse;
}

String apTurnoff() {
  int _size = 1;
  String httpResponse = "";
  httpResponse += HTTP_OK();

  String apStatus = WiFi.softAPdisconnect(true) ? "Turned AP off succesfully" : "Failed to turn off AP";
  
  httpData pairs[_size];
  pairs[0] = { "msg", apStatus };

  httpResponse += HTTP_ADD_DATA(pairs, _size);
  return httpResponse;
}

String finishSetup() {
  int _size = 1;
  String httpResponse = "";

  if(WiFi.status() != WL_CONNECTED) {
    String ssid = read_String(RESERVED);
    String pass = read_String(RESERVED + SSID_FLASH_SPACE);
    
    WiFi.begin(ssid, pass);
    Serial.println("Connecting to " + ssid);
    int tries = 0;
    while(WiFi.status() != WL_CONNECTED && tries <= 120) {
      delay(500);
      Serial.print(".");
      tries += 1;
    }

    if(WiFi.status() != WL_CONNECTED) {
      
      httpResponse += HTTP_SERVER_ERROR();
      
      httpData pairs[_size];
      pairs[0] = { "msg", "Couldn't connect to network" };
      httpResponse += HTTP_ADD_DATA(pairs, _size);
      
    } else {
      
      httpResponse += HTTP_OK();
    
      // Mark true to indicate setup has finished;
      EEPROM.put(0, true);
      EEPROM.commit();

      _size = 2;
      httpData pairs[_size];
      pairs[0] = { "msg", "Setup finished succesfully" };
      pairs[1] = { "ip", IpAddress2String(WiFi.localIP()) };
      httpResponse += HTTP_ADD_DATA(pairs, _size);
      
    }
  } else {
    httpData pairs[_size];
    pairs[0] = { "msg", "Already setup succesfully" };
    httpResponse += HTTP_ADD_DATA(pairs, _size);
  }

  return httpResponse;
}

String setNetworkSSID() {
  int _size = 1;
  String httpResponse = "";
  httpResponse += HTTP_OK();

  String ssid = header.substring(((String)"GET /network/ssid/").length(), header.indexOf(" HTTP"));
  writeString(RESERVED, ssid);
  
  httpData pairs[_size];
  pairs[0] = { "msg", "Network SSID set to " + ssid };

  httpResponse += HTTP_ADD_DATA(pairs, _size);
  return httpResponse;
}

String setNetworkPassword() {
  int _size = 1;
  String httpResponse = "";
  httpResponse += HTTP_OK();

  String password = header.substring(((String)"GET /network/password/").length(), header.indexOf(" HTTP"));
  writeString(RESERVED + SSID_FLASH_SPACE, password);
  
  httpData pairs[_size];
  pairs[0] = { "msg", "Network password set" };

  httpResponse += HTTP_ADD_DATA(pairs, _size);
  return httpResponse;
}

String defaultResponse() {
  int _size = 1;
  String httpResponse = "";
  httpResponse += HTTP_NOT_FOUND();

  httpData pairs[_size];
  pairs[0] = { "msg", "No function selected" };

  httpResponse += HTTP_ADD_DATA(pairs, _size);
  return httpResponse;
}
