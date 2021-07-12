void writeString(char add,String data)
{
  int _size = data.length();
  int i;
  for(i=0;i<_size;i++)
  {
    EEPROM.write(add+i,data[i]);
  }
  EEPROM.write(add+_size,'\0');   //Add termination null character for String Data
  EEPROM.commit();
}


String read_String(char add)
{
  int i;
  char data[100]; //Max 100 Bytes
  int len=0;
  unsigned char k;
  k=EEPROM.read(add);
  while(k != '\0' && len<500)   //Read until null character
  {    
    k=EEPROM.read(add+len);
    data[len]=k;
    len++;
  }
  data[len]='\0';
  return String(data);
}

String IpAddress2String(const IPAddress& ipAddress)
{
  return String(ipAddress[0]) + String(".") +\
  String(ipAddress[1]) + String(".") +\
  String(ipAddress[2]) + String(".") +\
  String(ipAddress[3])  ; 
}

void wipeFlash() {
  for(int i = 0; i < total_flash_space; i++) {
    EEPROM.write(i, 0);
  }
  EEPROM.commit();
}

String HTTP_OK() {
  String httpResponse = "";
  httpResponse += "HTTP/1.1 200 OK \n";
  httpResponse += "Content-type:application/json \n";
  httpResponse += "Connection: close \n";
  httpResponse += "\n";
  return httpResponse;
}

String HTTP_NOT_FOUND() {
  String httpResponse = "";
  httpResponse += "HTTP/1.1 404 NOT FOUND \n";
  httpResponse += "Content-type:application/json \n";
  httpResponse += "Connection: close \n";
  httpResponse += "\n";
  return httpResponse;
}

String HTTP_SERVER_ERROR() {
  String httpResponse = "";
  httpResponse += "HTTP/1.1 500 INTERNAL SERVER ERROR \n";
  httpResponse += "Content-type:application/json \n";
  httpResponse += "Connection: close \n";
  httpResponse += "\n";
  return httpResponse;
}

String HTTP_ADD_DATA(httpData data[], int _size) {
  String httpResponse = "";
  httpResponse += "{ ";
  for(int i = 0; i < _size; i ++) {
    httpResponse += "\"" + data[i].key + "\": " + "\"" + data[i].value + "\"";
    httpResponse += (_size > 1 && (i + 1) != _size) ? ", " : "";
    Serial.println((_size > 1 && (i + 1) != _size));
  }
  httpResponse += "} \n";
  httpResponse += "\n";
  return httpResponse;
}
