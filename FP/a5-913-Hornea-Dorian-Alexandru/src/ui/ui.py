from services.services import Services
from domain.domain import Expense
from tests import test_add_expense
from copy import deepcopy

class UI:
    def __init__(self, service):
        self._service = service
        self._history = [Expense.sample_expenses()]

    @staticmethod
    def print_menu():
        print("\tMenu:")
        print("Enter '1' to add new expense")
        print("Enter '2' to list the expenses")
        print("Enter '3' to filter the list so that it contains only expenses above a certain value")
        print("Enter '4' to undo the last operation that modified program data. This step can be repeated")
        print("Or enter 'exit' to exit the program!")

    def ui_add_expense(self):
        day = input("Enter the day in which you made the expense:")
        try:
            day = int(day)
        except ValueError:
            print("Invalid day")
            return
        if day < 1 or day > 30:
            print("Day must be greater than 1 or less than 30!")
            return
        amount = input("Enter the amount you spent that day:")
        try:
            amount = int(amount)
        except ValueError:
            print("Invalid amount")
            return
        type = input("Enter the expense:")
        try:
            self._service.add_expense(Expense(day, amount, type))
            self._history.append(self._service.expenses)
            print("Expense added successfully")
        except Exception as e:
            print(e)

    def ui_list_expenses(self):
        print("So far you have " + str(len(self._service.expenses)) + " expenses registered")
        for expense in self._service.expenses:
            print(expense)

    def ui_filter_expenses(self):
        value = input("Enter the desired value:")
        try:
            value = int(value)
        except ValueError:
            print("Invalid value")
        self._service.filter_expense(value)
        self._history.append(self._service.expenses)
        print("Expenses have been filtered successfully")

    def start_menu(self):
        UI.print_menu()
        while True:
            Input = input(">>>")
            self._service.expenses = deepcopy(self._history[-1])
            if Input == "1":
                self.ui_add_expense()
            elif Input == "2":
                self.ui_list_expenses()
            elif Input == "3":
                self.ui_filter_expenses()
            elif Input == "4":
                if len(self._history) == 1:
                    print("You cannot undo anymore")
                else:
                    self._history.pop()
                    print("You have undone the operation")
            elif Input == "exit":
                return
            else:
                print("Invalid command")

serv = Services()
test_add_expense(serv)
ui = UI(serv)
ui.start_menu()