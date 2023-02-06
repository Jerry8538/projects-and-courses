#include <RDV_GY521.h>
GY_521 gyro = GY_521();
int threshold = 25;

void setup() {
  Serial.begin(9600);
  gyro.sensor_init();
}

void loop() {
  int x = gyro.get_gyro_x();
  int y = gyro.get_gyro_y();
  int z = gyro.get_gyro_z();
  if (x>threshold || y>threshold || z>threshold) {
    Serial.print("buzz");
  }
}
