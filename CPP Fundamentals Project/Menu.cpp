#include "Menu.hpp"
#include "WiFiControl.hpp"
#include "BluetoothControl.hpp"
#include <iostream>

void Menu::showMainMenu() {
    int choice;
    do {
        std::cout << "1. WiFi Control\n2. Bluetooth Control\n3. Exit\nEnter your choice: ";
        std::cin >> choice;

        switch (choice) {
        case 1:
            handleWiFiControl();
            break;
        case 2:
            handleBluetoothControl();
            break;
        case 3:
            std::cout << "Exiting...\n";
            break;
        default:
            std::cout << "Invalid choice. Try again.\n";
        }
    } while (choice != 3);
}

void Menu::handleWiFiControl() {
    WiFiControl wifi;
    int option;
    std::cout << "1. Display WiFi Status\n2. Turn WiFi On\n3. Turn WiFi Off\n4. Connect to WiFi Network\n";
    std::cin >> option;

    switch (option) {
    case 1:
        wifi.displayWiFiStatus();
        break;
    case 2:
        wifi.turnWiFiOn();
        break;
    case 3:
        wifi.turnWiFiOff();
        break;
    case 4:
        int connectOption;
        std::cout << "1. Connect to saved network\n2. Connect to new network\n";
        std::cin >> connectOption;
        if (connectOption == 1) {
            wifi.connectToSavedNetwork();
        } else {
            wifi.connectToNewNetwork();
        }
        break;
    default:
        std::cout << "Invalid option.\n";
    }
}

void Menu::handleBluetoothControl() {
    BluetoothControl bluetooth;
    int option;
    std::cout << "1. Display Bluetooth Status\n2. Turn Bluetooth On\n3. Turn Bluetooth Off\n4. Connect to Bluetooth Device\n";
    std::cin >> option;

    switch (option) {
    case 1:
        bluetooth.displayBluetoothStatus();
        break;
    case 2:
        bluetooth.turnBluetoothOn();
        break;
    case 3:
        bluetooth.turnBluetoothOff();
        break;
    case 4:
        bluetooth.connectToBluetoothDevice();
        break;
    default:
        std::cout << "Invalid option.\n";
    }
}
