#ifndef BLUETOOTHCONTROL_HPP
#define BLUETOOTHCONTROL_HPP

#include <string>

class BluetoothControl {
public:
    void displayBluetoothStatus();
    void turnBluetoothOn();
    void turnBluetoothOff();
    void connectToBluetoothDevice();
    
private:
    void executeCommand(const std::string& command);
};

#endif
