'''
This module contains Functions for :
                                    - Display info
                                    - Bonus calculation 
                                    - Discount calculation
                                    - Holiday reminders.
'''

from employee_data  import *

def Calc_Bonus(ID):
    if (ID in employee_DB.keys()):
        DisplayEmployeeInfo(ID)
        return (float(employee_DB[ID][KeySalary])*(10/100))
    else:
        print("-----------------------------------")
        print("|ID:",ID,"---------Not Found-------|")
        print("-----------------------------------")

def Calc_Discount(ID):
    if (ID in employee_DB.keys()):
        DisplayEmployeeInfo(ID)
        return (float(employee_DB[ID][KeySalary])*(5/100))
    else:
        print("-----------------------------------")
        print("|ID:",ID,"---------Not Found-------|")
        print("-----------------------------------")

def Calc_RemHolidays(ID):
    if (ID in employee_DB.keys()):
        DisplayEmployeeInfo(ID)
        return (int(LigalHolidays) - int(employee_DB[ID][KeyDaysAbs]))
    else:
        print("-----------------------------------")
        print("|ID:",ID,"---------Not Found-------|")
        print("-----------------------------------")


if __name__ == "__main__":
    DisplayEmployeeInfo("0000","0001")
    print("Bonus                    : ",Calc_Bonus("0000"))
    print("Discount                 : ",Calc_Discount("0000"))
    print("Remind Legal Holidays    : ",Calc_RemHolidays("0000"))
