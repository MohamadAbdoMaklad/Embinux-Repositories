#include "BluetoothControl.hpp"
#include <iostream>
#include <cstdlib>

void BluetoothControl::displayBluetoothStatus() {
    executeCommand("rfkill list bluetooth");
}

void BluetoothControl::turnBluetoothOn() {
    executeCommand("rfkill unblock bluetooth");
}

void BluetoothControl::turnBluetoothOff() {
    executeCommand("rfkill block bluetooth");
}

void BluetoothControl::connectToBluetoothDevice() {
    std::string macAddress;
    executeCommand("bluetoothctl devices");
    std::cout << "Enter the MAC address of the device to connect: ";
    std::cin >> macAddress;
    std::string command = "bluetoothctl connect " + macAddress;
    executeCommand(command);
}

void BluetoothControl::executeCommand(const std::string& command) {
    system(command.c_str());
}
