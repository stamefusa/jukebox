#include <Servo.h>

#define SERVO_PIN 7 // サーボモーターをつなぐ端子
#define BUTTON_PIN 10 // ボタンスイッチをつなぐ端子
#define SEC 3 // サーボモーターが動いてもとに戻るまでの時間（秒数）

Servo s;

int button = 0;
int button_pre = 0;

void setup() {
  Serial.begin(9600);
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  s.attach(SERVO_PIN);
}

void loop() {
  button = digitalRead(BUTTON_PIN);
  if (button == 0 && button_pre == 1) {
    Serial.println("push button.");
    s.write(180);
    delay(SEC * 1000);
  }

  s.write(90);

  button_pre = button;
  delay(100);
}
