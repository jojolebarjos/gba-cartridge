
// TODO use https://os.mbed.com/docs/mbed-os/v6.15/apis/spi.html instead

// Pins
#define MISO 2
#define MOSI 3
#define SCK 4
#define SS 5

void setup() {

  // Connect to USB serial port
  Serial.begin(9600);
  while (!Serial);

  // Configure pins
  pinMode(MISO, INPUT);
  pinMode(MOSI, OUTPUT);
  pinMode(SCK, OUTPUT);
  pinMode(SS, OUTPUT);
  digitalWrite(MOSI, LOW);
  digitalWrite(SCK, LOW);
  digitalWrite(SS, HIGH);
}

uint16_t transfer(uint16_t in) {

  // Set Slave Select to low, to start message
  digitalWrite(SCK, LOW);
  digitalWrite(LED_BUILTIN, LOW);
  digitalWrite(SS, LOW);

  // Exchange each bit, most significant bit first
  int out = 0;
  for (int b = 15; b >= 0; --b) {

    // Write bit at Serial Clock falling edge
    int b_in = (in >> b) & 1;
    digitalWrite(MOSI, b_in ? HIGH : LOW);

    // Wait half-cycle
    delay(1);

    // Rise Serial Clock
    digitalWrite(SCK, HIGH);
    digitalWrite(LED_BUILTIN, HIGH);

    // Read bit at rising edge
    int b_out = digitalRead(MISO) == HIGH ? 1 : 0;
    out = (out << 1) | b_out;

    // Wait half-cycle
    delay(1);

    // Fall Serial Clock
    digitalWrite(SCK, LOW);
    digitalWrite(LED_BUILTIN, LOW);
  }

  // Set Slave Select to high, to end message
  digitalWrite(SS, HIGH);
  return out;
}

void loop() {

  // Wait for message
  if (Serial.available() >= 2) {
    int high = Serial.read();
    int low = Serial.read();
    uint16_t in = high << 8 | low;
    uint16_t out = transfer(in);
    Serial.write(out >> 8);
    Serial.write(out & 0xff);
  }
}
