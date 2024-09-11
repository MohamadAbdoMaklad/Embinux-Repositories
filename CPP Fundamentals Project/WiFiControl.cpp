#include "WiFiControl.hpp"
#include <iostream>
#include <cstdlib>

void WiFiControl::displayWiFiStatus() {
    executeCommand("nmcli radio wifi");
}

void WiFiControl::turnWiFiOn() {
    executeCommand("nmcli radio wifi on");
}

void WiFiControl::turnWiFiOff() {
    executeCommand("nmcli radio wifi off");
}

void WiFiControl::connectToSavedNetwork() {
    displaySavedNetworks();
    std::string ssid;
    std::cout << "Enter the SSID of the saved network you want to connect to: ";
    std::cin >> ssid;
    auto it = savedNetworks.find(ssid);
    if (it != savedNetworks.end()) {
        std::string command = "nmcli dev wifi connect " + ssid + " password " + it->second;
        executeCommand(command);
    } else {
        std::cout << "Network not found.\n";
    }
}

void WiFiControl::connectToNewNetwork() {
    std::string ssid, password;
    std::cout << "Enter SSID: ";
    std::cin >> ssid;
    std::cout << "Enter Password: ";
    std::cin >> password;

    std::string command = "nmcli dev wifi connect " + ssid + " password " + password;
    executeCommand(command);
    saveNetwork(ssid, password);
}

void WiFiControl::saveNetwork(const std::string& ssid, const std::string& password) {
    savedNetworks[ssid] = password;
}

void WiFiControl::displaySavedNetworks() {
    std::cout << "Saved Networks:\n";
    for (const auto& network : savedNetworks) {
        std::cout << "SSID: " << network.first << std::endl;
    }
}

void WiFiControl::deleteSavedNetwork(const std::string& ssid) {
    savedNetworks.erase(ssid);
    std::cout << "Network " << ssid << " deleted.\n";
}

void WiFiControl::executeCommand(const std::string& command) {
    system(command.c_str());
}
