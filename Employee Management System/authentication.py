'''
This module contains Functions for user authentication.
'''
from employee_data import *
import getpass
def authenticateUser():
    AvailableAttempts = 3
    ID = input("ID : ")
    while (AvailableAttempts > 0):
        if ID in employee_DB.keys():
            Password = getpass.getpass("Password : ")
            if employee_DB[ID][KeyPassword] == Password:
                return ID
            else:
                AvailableAttempts= AvailableAttempts - 1
                print("Tray Again Available Attempts :",AvailableAttempts)
        else:
            print(">> ID:",ID, "Not Exists")
            return "ERROR_In_ID"
    return "ERROR_In_PASSWORD"

if __name__ == "__main__":
    print(authenticateUser())