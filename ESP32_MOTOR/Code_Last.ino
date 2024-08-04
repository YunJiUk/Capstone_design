#include <LiquidCrystal.h>

#include <LiquidCrystal_I2C.h>

#define LCD_ADDRESS 0x27 // I2C 주소
#define LCD_COLUMNS 16   // LCD의 열 수
#define LCD_ROWS 2       // LCD의 행 수



#include <LiquidCrystal_I2C.h> 
#include <Wire.h>
#include <DHT11.h>        // DHT11 디지털 온습도 센서와 인터페이스하기 위한 기능 제공
#include "BluetoothSerial.h"

int pin_temp = 4;          // 온습도 센서 
DHT11 dht11(pin_temp);


LiquidCrystal_I2C lcd(LCD_ADDRESS, LCD_COLUMNS, LCD_ROWS);



//#define USE_PIN // Uncomment this to use PIN during pairing. The pin is specified on the line below
const char *pin = "1234"; // Change this to more secure PIN.

String device_name = "esp1";

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

#if !defined(CONFIG_BT_SPP_ENABLED)
#error Serial Bluetooth not available or not enabled. It is only available for the ESP32 chip.
#endif

BluetoothSerial SerialBT;
String s1;
String s2;
int receivedCount = 0;

int trigpin_1_1 = 14;
int echopin_1_1 = 27;
int trigpin_1_2 = 26;
int echopin_1_2 = 25;
int trigpin_1_3 = 33;
int echopin_1_3 = 32;

int trigpin_2_1 = 5;
int echopin_2_1 = 23;
int trigpin_2_2 = 13;
int echopin_2_2 = 12;

int trigpin_3_1 = 15;
int echopin_3_1 = 2;
int trigpin_3_2 = 18;
int echopin_3_2 = 19;

char distance_trig1[] = "000";
char distance_trig2[] = "00";
char distance_trig3[] = "00";
char distance_trig[] = "0000000";

long duration;
long distance1[3];
long distance2[2];
long distance3[2];

float humidity;
float temperature;

int count = 0;
int wafer_count = 0;
int temp_count = 0;
int try_count = 0;
int off_count = 1;

String str1, str2;
String str3, str4;
String temp_result;


void setup() {
  Serial.begin(115200); // Start the serial port.
  SerialBT.begin(device_name); //Bluetooth device name
  Serial2.begin(115200, SERIAL_8N1, 16, 17);

  Wire.begin();

  lcd.begin(LCD_COLUMNS, LCD_ROWS);
  lcd.clear();

  lcd.setCursor(0, 0);
  lcd.backlight();

  Serial.printf("The device with name \"%s\" is started.\nNow you can pair it with Bluetooth!\n", device_name.c_str());
  //Serial.printf("The device with name \"%s\" and MAC address %s is started.\nNow you can pair it with Bluetooth!\n", device_name.c_str(), SerialBT.getMacString()); // Use this after the MAC method is implemented
  #ifdef USE_PIN
    SerialBT.setPin(pin);
    Serial.println("Using PIN");
  #endif
  pinMode(trigpin_1_1, OUTPUT); // trigPin as output
  pinMode(echopin_1_1, INPUT); // Input echoPin.
  pinMode(trigpin_1_2, OUTPUT); // trigPin as output
  pinMode(echopin_1_2, INPUT); // Input echoPin.
  pinMode(trigpin_1_3, OUTPUT); // trigPin as output
  pinMode(echopin_1_3, INPUT); // Input echoPin.

  pinMode(trigpin_2_1, OUTPUT); // trigPin as output
  pinMode(echopin_2_1, INPUT); // Input echoPin.
  pinMode(trigpin_2_2, OUTPUT); // trigPin as output
  pinMode(echopin_2_2, INPUT); // Input echoPin.

  pinMode(trigpin_3_1, OUTPUT); // trigPin as output
  pinMode(echopin_3_1, INPUT); // Input echoPin.
  pinMode(trigpin_3_2, OUTPUT); // trigPin as output
  pinMode(echopin_3_2, INPUT); // Input echoPin.
}



void loop() {
  
  dht11.read(humidity, temperature); 

  str1 = String(humidity, 1);
  str2 = String(temperature, 1);
  str1.replace(".", "");
  str2.replace(".", "");

  temp_result = 'T'+str1+str2 + '\n';

  str3 = String(humidity, 1);
  str4 = String(temperature, 1);
  lcd.setCursor(0,1);
  lcd.print(str3);
  lcd.setCursor(4,1);
  lcd.print("%");
  lcd.setCursor(10,1);

  lcd.print(str4);
  lcd.setCursor(15,1);
  lcd.print("C");

  digitalWrite(trigpin_1_1, LOW);
  delayMicroseconds(2);
  digitalWrite(trigpin_1_1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin_1_1, LOW);
  duration = pulseIn(echopin_1_1, HIGH);
  distance1[0] = duration * 0.034 / 2;

  Serial.print("Sensor1_1: ");
  Serial.print(distance1[0]);
  Serial.println("cm");

  delay(100);

  digitalWrite(trigpin_1_2, LOW);
  delayMicroseconds(2);
  digitalWrite(trigpin_1_2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin_1_2, LOW);
  duration = pulseIn(echopin_1_2, HIGH);
  distance1[1] = duration * 0.034 / 2;

  Serial.print("Sensor1_2: ");
  Serial.print(distance1[1]);
  Serial.println("cm");

  delay(100);

  digitalWrite(trigpin_1_3, LOW);
  delayMicroseconds(2);
  digitalWrite(trigpin_1_3, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin_1_3, LOW);
  duration = pulseIn(echopin_1_3, HIGH);
  distance1[2] = duration * 0.034 / 2;

  Serial.print("Sensor1_3: ");
  Serial.print(distance1[2]);
  Serial.println("cm");

  delay(100);

  //1풉 끝

  for (int n1 = 0; n1 < 3; n1++) {
    if (distance1[n1] > 4) {
      distance_trig2[n1] = '0';
    } else {
      distance_trig2[n1] = '1';
    }
    distance_trig[n1] = distance_trig2[n1];
  }

  delay(100);
  //2풉 시작

  digitalWrite(trigpin_2_2, LOW);
  delayMicroseconds(2);
  digitalWrite(trigpin_2_2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin_2_2, LOW);
  duration = pulseIn(echopin_2_2, HIGH);
  distance2[1] = duration * 0.034 / 2;

  Serial.print("Sensor2_2: ");
  Serial.print(distance2[0]);
  Serial.println("cm");

  delay(100);


  digitalWrite(trigpin_2_1, LOW);
  delayMicroseconds(2);
  digitalWrite(trigpin_2_1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin_2_1, LOW);
  duration = pulseIn(echopin_2_1, HIGH);
  distance2[0] = duration * 0.034 / 2;

  Serial.print("Sensor2_1: ");
  Serial.print(distance2[1]);
  Serial.println("cm");

  delay(100);

 

  //2풉 끝

  for (int n1 = 0; n1 < 2; n1++) {
    if (distance2[n1] > 4) {
      distance_trig2[n1] = '0';
    } else {
      distance_trig2[n1] = '1';
    }
    distance_trig[n1 + 3] = distance_trig2[n1];
  }

  //3풉시작
  delay(100);

  digitalWrite(trigpin_3_1, LOW);
  delayMicroseconds(2);
  digitalWrite(trigpin_3_1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin_3_1, LOW);
  duration = pulseIn(echopin_3_1, HIGH);
  distance3[0] = duration * 0.034 / 2;

  Serial.print("Sensor3_1: ");
  Serial.print(distance3[0]);
  Serial.println("cm");

  delay(100);

  digitalWrite(trigpin_3_2, LOW);
  delayMicroseconds(2);
  digitalWrite(trigpin_3_2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigpin_3_2, LOW);
  duration = pulseIn(echopin_3_2, HIGH);
  distance3[1] = duration * 0.034 / 2;

  Serial.print("Sensor3_2: ");
  Serial.print(distance3[1]);
  Serial.println("cm");

  delay(100);

  

  for (int n1 = 0; n1 < 2; n1++) {
    if (distance3[n1] > 4) {
      distance_trig3[n1] = '0';
    } else {
      distance_trig3[n1] = '1';
    }
    distance_trig[n1 + 5] = distance_trig3[n1];
  }

  while (SerialBT.available()) {
    char c = SerialBT.read();
    if(c=='\n'){
    s1.concat(c);   //  문자열을 잇는 함수
    break;
    }
    s1.concat(c);   //  문자열을 잇는 함수
    delay(10);    
  } 

  while(Serial2.available()){
    //들어온 데이터를 Serial로 그대로 전송
    char o = Serial2.read();
    if(o=='\n'){
    s2.concat(o);   //  문자열을 잇는 함수
    break;
    }
    s2.concat(o);   //  문자열을 잇는 함수
    delay(10);
  }

if(try_count == 0){
  if(s1 != ""){
    for(int n1=0; n1<=20; n1++){
      Serial2.write(s1[n1]);
      Serial.print(s1[n1]);
      if(s1[n1] == '\n'){
        s1 = "";
        break;
        Serial.print("\n");
        try_count = 1;
      }
    }
  }
}
else if(try_count == 1){
  try_count = 0;
  for(int n1 =0; n1<11; n1++){
    if(humidity<=40 || humidity>=50 || temperature>=27 || temperature<=27 ){
      Serial2.write(temp_result[n1]);
    }
  }
}

if(off_count == 1){
    off_count = 0;
    wafer_count = 1;
    temp_count = 0;
    for(int n1=0; n1<=10; n1++)
    {
     SerialBT.write(s2[n1]);
    }
  s2 = "";
}
else if(wafer_count == 1){
    Serial.println(distance_trig);
    Serial.print('\n');
    off_count = 0;
    wafer_count = 0;
    temp_count = 1;
    for(int n1=0; n1<=7; n1++)
    {
     SerialBT.write(distance_trig[n1]);
    }
  }
else if(temp_count == 1){
  Serial.println(temp_result);
    off_count = 1;
    wafer_count = 0;
    temp_count = 0;
  for(int n1 =0; n1<11; n1++){
    /*if(temp_result[n1] == '\n'){
      n1++;
    }*/
    SerialBT.write(temp_result[n1]);
    //Serial.println(temp_result[n1]);
  }
}

  
  delay(10);
}