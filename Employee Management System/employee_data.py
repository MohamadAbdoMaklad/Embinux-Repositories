'''
This module contains Functions to manage employee data.
______________________>>>> Functions to add, remove, and update employee details.
______________________>>>>Ensure the employee ID is unique for each entry.
__________________________>>>> ID (Unique): A unique identifier for each employee.
__________________________>>>> Name: The full name of the employee.
__________________________>>>> Department: The department in which the employee works.
__________________________>>>> Salary: The salary of the employee.
__________________________>>>> Password: Used for user authentication.
__________________________>>>> Days of Absence: The number of days the employee has been absent.
'''



KeyID           = "ID"
KeyName         = "Name"
KeyPassword     = "Password"
KeyDepartment   = "Department"
KeySalary       = "Salary"
KeyDaysAbs      = "Days of Absence"
LigalHolidays   = "21"
employee_DB = {"0000":{KeyName:"admin_0",KeyPassword:"0000",KeyDepartment:"IT",KeySalary:"15000",KeyDaysAbs:"8"},
               "0001":{KeyName:"admin_1",KeyPassword:"1111",KeyDepartment:"IT",KeySalary:"10000",KeyDaysAbs:"8"}
               }

def DisplayEmployeeInfo(*ID):
    LineFormate="-----------------------------------------------------------------------------"
    print(LineFormate)
    for i in ID:
        if i in employee_DB.keys():
            print("|ID:",i,
                  "|Name:",employee_DB[i][KeyName],
                  "|Department:",employee_DB[i][KeyDepartment],
                  "|Salary:",employee_DB[i][KeySalary],
                  "|Days of Absence:",employee_DB[i][KeyDaysAbs],
                  "|")
        else:
            print("|ID:",i,"----------------------------Not Found-----------------------------|")
        print(LineFormate)

def AddEmploee(ID,Name,Password,Department,Salary,DaysAbs):
    if ID not in employee_DB.keys():
        NewEmploeeData={KeyName:Name,KeyPassword:Password,KeyDepartment:Department,KeySalary:Salary,KeyDaysAbs:DaysAbs}
        employee_DB[ID] = NewEmploeeData
        print(">> ID:",ID, "Added Successfully")
        DisplayEmployeeInfo(ID)
    else:
        print(">> ID:",ID, "Exists")
        DisplayEmployeeInfo(ID)

def RemoveEmploee(ID):
    if ID in employee_DB.keys():
        employee_DB.pop(ID)
        print(">> ID:",ID, "Removed Successfully")
    else:
        print(">> ID:",ID, "Not Exists")

def UpdateEmploeeData(ID,Name,Password,Department,Salary,DaysAbs):
    if ID in employee_DB.keys():
        NewEmploeeData={KeyName:Name,KeyPassword:Password,KeyDepartment:Department,KeySalary:Salary,KeyDaysAbs:DaysAbs}
        employee_DB.update({ID:NewEmploeeData})
        print(">> ID:",ID, "Updated Successfully")
        DisplayEmployeeInfo(ID)
    else:
        print(">> ID:",ID, "Not Exists")
        DisplayEmployeeInfo(ID)




if __name__ == "__main__":
    #DisplayEmployeeInfo("0000","0001","0003")
    #AddEmploee("2030","Mohamed","02056","Mec","20000","0")
    #DisplayEmployeeInfo("0000","0001","2030")
    #AddEmploee("2030","Mohamed","02056","Mec","20000","0")
    #RemoveEmploee("2023")
    #DisplayEmployeeInfo("2023")

    DisplayEmployeeInfo("0000","0001","2020")
    AddEmploee("2020","Mohamed","02056","Mec","20000","0")
    UpdateEmploeeData("2020","Mohamed","02056","Mec","10000","0")
    DisplayEmployeeInfo("0000","0001","2020")
    RemoveEmploee("2020")
    RemoveEmploee("2020")
    DisplayEmployeeInfo("2020")
