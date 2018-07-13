///headers :)
#include <ESP8266WiFi.h>
#include <Wire.h>

///configuring the mpu6050
const int MPU_addr=0x68;  // I2C address of the MPU-6050
int16_t AcX,AcY,AcZ,Tmp,GyX,GyY,GyZ;

///how many clients should be able to telnet to this ESP8266
#define MAX_SRV_CLIENTS 1
const char* ssid = "AndroidAP";
const char* password = "diehard1";

WiFiServer server(23);
WiFiClient serverClients[MAX_SRV_CLIENTS];

int imp, count = 0;


void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  //pinMode(12,INPUT);
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  Serial.print("\nConnecting to "); Serial.println(ssid);
  uint8_t i = 0;
  while (WiFi.status() != WL_CONNECTED && i++ < 20) delay(500);
  if(i == 21){
    Serial.print("Could not connect to "); Serial.println(ssid);
    while(1) delay(500);
  }
  ///start UART and the server and the MPU
  Serial.begin(115200);
  digitalWrite(LED_BUILTIN, LOW);
  //MPU
  //while (!Serial);
  Wire.begin();
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x6B);  // PWR_MGMT_1 register
  Wire.write(0);     //  wakeup the MPU-6050
  Wire.endTransmission(true);
  
  //ESP
  server.begin();
  server.setNoDelay(true);
  
  Serial.print("Ready! Use 'telnet ");
  Serial.print(WiFi.localIP());
  Serial.println(" 23' to connect");
  digitalWrite(LED_BUILTIN, LOW);
  
}

int connectflag = 0;

void loop() {
  ///ESP PART:
  if(connectflag!=1){
    digitalWrite(LED_BUILTIN, HIGH);
    delay(300);
    digitalWrite(LED_BUILTIN, LOW);
    delay(300);
  }
  uint8_t i;
  //check if there are any new clients
  
  if (server.hasClient()){
    for(i = 0; i < MAX_SRV_CLIENTS; i++){
      //find free/disconnected spot
      if (!serverClients[i] || !serverClients[i].connected()){
        if(serverClients[i]) serverClients[i].stop();
        serverClients[i] = server.available();
        Serial.print("New client: "); Serial.print(i);
        digitalWrite(LED_BUILTIN, LOW);
        delay(300);
        digitalWrite(LED_BUILTIN, HIGH);
        delay(300);
        digitalWrite(LED_BUILTIN, LOW);
        connectflag = 1;
        continue;
      }
    }
    //no free/disconnected spot so reject
    WiFiClient serverClient = server.available();
    serverClient.stop();
  }
  
  //check clients for data
  for(i = 0; i < MAX_SRV_CLIENTS; i++){
    if (serverClients[i] && serverClients[i].connected()){
      if(serverClients[i].available()){
        //get data from the telnet client and push it to the UART
        while(serverClients[i].available()) Serial.write(serverClients[i].read());
      }
    }
  }

  ///MPU Part:
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x3B);  // starting with register 0x3B (ACCEL_XOUT_H)
  Wire.endTransmission(false);
  Wire.requestFrom(MPU_addr,14,true);  // request a total of 14 registers
  
  /*AcX=Wire.read()<<8|Wire.read();  // 0x3B (ACCEL_XOUT_H) & 0x3C (ACCEL_XOUT_L)    
  AcY=Wire.read()<<8|Wire.read();  // 0x3D (ACCEL_YOUT_H) & 0x3E (ACCEL_YOUT_L)
  AcZ=Wire.read()<<8|Wire.read();  // 0x3F (ACCEL_ZOUT_H) & 0x40 (ACCEL_ZOUT_L)
  Tmp=Wire.read()<<8|Wire.read();  // 0x41 (TEMP_OUT_H) & 0x42 (TEMP_OUT_L)*/
  
  
  
  //check UART for data and flush the acc data through it
  //if(Serial.available()){
  
    size_t len = 3;
    Serial.print(len);
    //byte sbuf[len];
    //Serial.readBytes(sbuf, len);
    //push UART data to all connected telnet clients
    for(i = 0; i < MAX_SRV_CLIENTS; i++){
      if (serverClients[i] && serverClients[i].connected()){
          
                if(count>=100){

                  AcX=Wire.read()<<8|Wire.read(); AcY=Wire.read()<<8|Wire.read(); AcZ=Wire.read()<<8|Wire.read();
                  
                  
                  //Serial.print(" | AcX = "); Serial.println(AcX);
                  
                  if(AcX < -4000&&AcY>-5000&&AcY < 5000){
                    serverClients[i].write("S", len);
                    //serverClients[i].write("A", len);                     //checked
                    Serial.println("passed S");
                    imp = 1;
                  }
                  else if(AcX<-4000&&AcY<-5000&&AcY>-13000)
                  {
                    serverClients[i].write("a", len);
                    //serverClients[i].write("A", len);                     //checked
                    Serial.println("passed SA");
                    imp = 1;
                  }
                  else if(AcX<-4000&&AcY>5000&&AcY<13000)
                  {
                    serverClients[i].write("d", len);
                    //serverClients[i].write("D", len);                     //checked
                    Serial.println("passed SD");
                    imp = 1;
                  }
                  else if(AcX > -4000&&AcX<3000&&AcY<-5000&&AcY>-13000){
                    //serverClients[i].write("S", len);
                    serverClients[i].write("A", len);                         //checked      
                    Serial.println("passed A");
                    imp = 1;
                  }
                  else if(AcX > -4000&&AcX<3000&&AcY > 5000&&AcY<13000){
                    //serverClients[i].write("W", len);                     //checked
                    serverClients[i].write("D", len);
                    Serial.println("passed D");
                    imp = 2;
                  }
                  ///////////////////////////////////////////::::::::::::::::::::::handbrake and without handbrake            :::::::::: NOT AVAILABLE FOR NITROUS <- YOU CAN ENABLE IT


                  else if(AcX<-4000&&AcY<-13000)                            // for s and a
                  {
                    serverClients[i].write("l", len);
                    //serverClients[i].write("A", len);                     // !checked
                    Serial.println("passed SA");
                    imp = 1;
                  }
                  
                  else if(AcX<-4000&&AcY>13000)                               // for d and s
                  {
                    serverClients[i].write("k", len);
                    //serverClients[i].write("D", len);                     // !checked
                    Serial.println("passed SD");
                    imp = 1;
                  }

                  else if(AcX > -4000&&AcX<3000&&AcY<-10000){                // for just a
                    //serverClients[i].write("S", len);
                    serverClients[i].write("j", len);                         // !checked      
                    Serial.println("passed    A");
                    imp = 1;
                  }
                  else if(AcX > -4000&&AcX<3000&&AcY > 10000){                   // for just d
                    //serverClients[i].write("W", len);                     // !checked
                    serverClients[i].write("h", len);
                    Serial.println("passed     D");
                    imp = 2;
                  }

                  else if(AcX>3000&&AcX<13000&&AcY<-10000)
                  {                                                                       //// for w a
                    serverClients[i].write("i", len);                                   //without n2o
                    //serverClients[i].write("A", len);                     //checked
                    Serial.println("passed WA");
                    imp = 1;
                  }

                  else if(AcX>3000&&AcX<13000&&AcY>10000)                                  //// for w d
                  {
                    serverClients[i].write("u", len);                             //without n2o
                    //serverClients[i].write("D", len);                     //checked
                    Serial.println("passed WD");
                    imp = 1;
                  }


                  ///////////////////////////////////////////::::::::::::::::::::::nitrous and without nitrous *************for W only********


                  
                  else if(AcX > 3000&&AcX<13000&&AcY>-5000&&AcY < 5000){
                    serverClients[i].write("W", len);                                     //without n2o
                    //serverClients[i].write("D", len);
                    Serial.println("passed W");                                       //checked
                    imp = 6;
                  }
                  else if(AcX>3000&&AcX<13000&&AcY<-4000&&AcY>-10000)
                  {
                    serverClients[i].write("w", len);                                   //without n2o
                    //serverClients[i].write("A", len);                     //checked
                    Serial.println("passed WA");
                    imp = 1;
                  }
                  else if(AcX>3000&&AcX<13000&&AcY>4000&&AcY<10000)
                  {
                    serverClients[i].write("q", len);                             //without n2o
                    //serverClients[i].write("D", len);                     //checked
                    Serial.println("passed WD");
                    imp = 1;
                  }
                  else if(AcX > 13000&&AcY>-5000&&AcY < 5000){
                    serverClients[i].write("m", len);                                     //with n2o just 'w'
                    //serverClients[i].write("D", len);
                    Serial.println("passed W");                                       //checked
                    imp = 6;
                  }
                   else if(AcX>13000&&AcY<-4000)
                  {
                    serverClients[i].write("n", len);                                   //with n2o and 'a'
                    //serverClients[i].write("A", len);                     //checked
                    Serial.println("passed WA");
                    imp = 1;
                  }

                  else if(AcX>13000&&AcY>4000)
                  {
                    serverClients[i].write("o", len);                                   //with n2o and 'd'
                    //serverClients[i].write("D", len);                     //checked
                    Serial.println("passed WD");
                    imp = 1;
                  }
                  /*else if(AcX < 3000&&AcX > -4000&&AcY > 6000){
                    //serverClients[i].write("W", len);
                    serverClients[i].write("D", len);
                    Serial.println("passed6");
                    imp = 5;
                  }
                  else if(AcX < 3000&&AcX > -4000&&AcY < -5500){
                    //serverClients[i].write("W", len);
                    serverClients[i].write("A", len);
                    Serial.println("passed A");
                    imp = 4;
                  }*/
                  
                  else{
                    Serial.println("passed Nothing");
                    serverClients[i].write("0", len);
                  }

                  /////////////////////////////////////////
                  
                  
                //serverClients[i].write("A", len);
                
                }
                else{
                  Serial.print(count);
                  count++;
                //serverClients[i].write("D", len);
                }
                
                delay(1);
      //}
    }
  }
}
