#include <stdio.h>
#include <stdint.h>
#include "Arduino.h"
#include "CPrjTemplate/version.h"

void setup()
{
    // Initialize built-in LED pin and Serial communication
    pinMode(LED_BUILTIN, OUTPUT);
    Serial.begin(9600);

    // Print welcome message
    Serial.println("Hello, World!");
}

void loop()
{
    // Blink the built-in LED
    digitalWrite(LED_BUILTIN, HIGH);
    delay(2000);
    digitalWrite(LED_BUILTIN, LOW);
    delay(1500);

    // Print keep alive message
    Serial.println("[INFO] Loop");
}
