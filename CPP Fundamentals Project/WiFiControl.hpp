#ifndef WIFICONTROL_HPP
#define WIFICONTROL_HPP

#include <string>
#include <map>

class WiFiControl {
public:
    void displayWiFiStatus();
    void turnWiFiOn();
    void turnWiFiOff();
    void connectToSavedNetwork();
    void connectToNewNetwork();
    void saveNetwork(const std::string& ssid, const std::string& password);
    void displaySavedNetworks();
    void deleteSavedNetwork(const std::string& ssid);

private:
    std::map<std::string, std::string> savedNetworks;
    void executeCommand(const std::string& command);
};

#endif
