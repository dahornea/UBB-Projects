"""
  User interface module
"""
from functions import *



def print_menu():
    print("\t Building Administration Program")
    print("(A) Add new transaction: 'add <apartment> <type> <amount>'")
    print("(B) Modify expenses:")
    print("\t `remove <apartment>`")
    print("\t `remove <start apartment> to <end apartment>`")
    print("\t `remove <type>`")
    print("\t `replace <apartment> <type> with <amount>`")
    print("(C) Display expenses having different properties:")
    print("\t `list` - display all expenses")
    print("\t `list <apartment>` - display all expenses for that apartment")
    print("\t `list [ < | = | > ] <amount>' - display all expenses with the desired property")
    print("(D) Obtain different characteristics of the expenses:")
    print("\t 'sum <type>' -  display the total amount for that expense")
    print("\t 'max <apartment>' - display the maximum amount per each expense type for that apartment")
    print("\t 'sort <apartment>' - display the list of apartments sorted ascending by total amount of expenses ")
    print("\t 'sort <type>' -  display the total amount of expenses for each type, sorted ascending by amount of money")
    print("(E) Filter:")
    print("\t 'filter <type>' - keep only expenses for that type")
    print("\t 'filter <value>' - keep only expenses having an amount of money smaller than that value")
    print("(F) Undo:")
    print("\t 'undo' - the last operation that modified program data is reversed")
    print("'exit' to stop the program")


def sum_command_run(complex, param1):
    """

    :param complex: Apartment complex
    :param param1: The type we want to add
    :return: The total amount we added for param1
    """
    try:
        type = param1
        total = add_amount_for_expense(complex, type)
        print("The total amount for type", type, "is:", total)
    except (TypeError, ValueError):
        print("Wrong type")


def list_command_run(complex, param1, param2):
    """

    :param complex: Apartment complex
    :param param1: if it's a number, it represents the number of the apartment. Otherwise it's a comparison operator
    :param param2: If param1 is a comparison operator, param2 is the value of the utility. Otherwise it's None
    :return:
    """
    try:
        if param1 == '>':
            for i in range(1, len(complex)):
                total = total_expenses(complex, i)
                if total > int(param2):
                    print(complex[i])
        elif param1 == '<':
            for i in range(1, len(complex)):
                total = total_expenses(complex, i)
                if total < int(param2):
                    print(complex[i])
        elif param1 == '=':
            for i in range(1, len(complex)):
                total = total_expenses(complex, i)
                if total == int(param2):
                    print(complex[i])
        elif param1 == None:
            for i in complex:
                print(i)
        elif int(param1) > 0:
            print(complex[int(param1)])
    except (ValueError, IndexError):
        print("Wrong input")

def max_command_run(complex, param1):
    """

    :param complex: Apartment complex
    :param param1: The apartment
    :return:
    """
    try:
        apartment = complex[int(param1)]
        amount = get_max_amount(apartment)
        print("The maximum amount for apartment", param1, "is:", amount)
    except (ValueError, IndexError):
        print("Wrong input")


def sort_command_run(complex, param1):
    """

    :param complex: Apartment complex
    :param param1: 'apartment' to sort the apartments or 'type' to sort based on the expense
    :return:
    """
    try:
        if param1 == 'type':
            total_amount = total_amount_for_expense(complex)
            total_amount.sort()
            print(total_amount)
        elif param1 == 'apartment':
            apartment_expenses = get_apartment_and_expense(complex)
            for i in apartment_expenses:
                apartment_expenses.sort(key=get_total_amount)
            print(apartment_expenses)
    except (IndexError, ValueError):
        print("Wrong input")



def start_command_ui():
    cmd_dict = {'add':add_command_run, 'list':list_command_run, 'replace':replace_command_run, 'remove':remove_command_run,
                'sum':sum_command_run, 'max':max_command_run, 'sort':sort_command_run, 'filter':filter_command_run,
                'undo':undo_command_run}
    print_menu()
    while True:

        user_cmd = input(">>>")

        cmd_word, cmd_param1, cmd_param2, cmd_param3 = split_command_params(user_cmd)

        if cmd_word == 'exit':
            return
        elif cmd_word not in cmd_dict:
            print("Invalid command!")
        else:
            try:
                if cmd_word == 'add':
                    cmd_dict[cmd_word](complex, cmd_param1, cmd_param2, cmd_param3)
                if cmd_word == 'list':
                    cmd_dict[cmd_word](complex, cmd_param1, cmd_param2)
                if cmd_word == 'replace':
                    cmd_dict[cmd_word](complex, cmd_param1, cmd_param2, cmd_param3)
                if cmd_word == 'remove':
                    cmd_dict[cmd_word](complex, cmd_param1, cmd_param2)
                if cmd_word == 'sum':
                    cmd_dict[cmd_word](complex, cmd_param1)
                if cmd_word == 'max':
                    cmd_dict[cmd_word](complex, cmd_param1)
                if cmd_word == 'sort':
                    cmd_dict[cmd_word](complex, cmd_param1)
                if cmd_word == 'filter':
                    cmd_dict[cmd_word](complex, cmd_param1)
                if cmd_word == 'undo':
                    cmd_dict[cmd_word](complex, save)
            except (IndexError, ValueError, TypeError, KeyError, AttributeError):
                print("Invalid input")