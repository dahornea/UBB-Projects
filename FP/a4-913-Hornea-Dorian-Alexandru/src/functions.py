"""
  Program functionalities module
"""
import copy


def create_expenses():
    """

    :return: The utilities found in every apartment and their value as a dictionary
    """
    expenses = {"water": 0, "gas": 0, "electricity": 0, "heating": 0, "other": 0}
    return expenses


def create_apartment(id):
    """

    :param id: Id of the apartment we want to create
    :return: A list that represents the apartment (id_apartment) and it's utilities (expenses)
    """
    expenses = create_expenses()
    id_apartment = id
    return [id_apartment, expenses]

complex = ["\tApartment complex:", create_apartment(1), create_apartment(2), create_apartment(3),
               create_apartment(4), create_apartment(5),
               create_apartment(6), create_apartment(7), create_apartment(8), create_apartment(9), create_apartment(10)]


save = []


def get_utilities_amount(apartment, type):
    """

    :param apartment: The desired apartment
    :param type: The utility
    :return: The value of the utility
    """
    return apartment[type]


def total_expenses(complex, id):
    """

    :param complex: apartment complex
    :param id: The id of the apartment
    :return: The total value of that apartment's utilities
    """
    utilities = get_total_amount(complex[id])
    expenses = create_expenses()
    total = 0
    for i in expenses:
        amount = get_utilities_amount(utilities, i)
        total = total + amount
    return total

def create_utilities():
    """

    :return: The utilities found in every apartment
    """
    utilities = ['water', 'gas', 'electricity', 'heating', 'other']
    return utilities


def split_command_params(user_cmd):
    """

    :param user_cmd: Command entered by user
    :return: A tuple of <command_word> and the parameters in lowercase
    """

    user_cmd = user_cmd.strip()
    tokens = user_cmd.split(maxsplit=5)
    cmd_word = tokens[0].lower() if len(tokens) > 0 else None
    cmd_param1 = tokens[1].lower() if len(tokens) > 1 else None
    cmd_param2 = tokens[2].lower() if len(tokens) > 2 else None
    cmd_param3 = tokens[3].lower() if len(tokens) > 3 else None

    if (cmd_param2 == 'to' or cmd_param2 == 'with') and len(tokens) != 3:
        cmd_param2 = tokens[3].lower()
        tokens[2] = None
        if len(tokens) > 4:
            cmd_param3 = tokens[4].lower()
    if cmd_param3 == 'with' or cmd_param3 == 'to':
        tokens[3] = None
        cmd_param3 = tokens[4].lower()
    return cmd_word, cmd_param1, cmd_param2, cmd_param3


def set_id(complex, id, newid):
    """

    :param complex: Apartment complex
    :param id: The apartment's current id
    :param newid: The id we want to assign
    :return:
    """
    complex[id] = complex[newid]


def get_expense_amount(apart, expense):
    """

    :param apart: The apartment
    :param expense: the utility
    :return: the value of the utility
    """
    x = apart[1].get(expense)
    return x



def get_max_amount(apart):
    """

    :param apart: The apartment
    :return: The total amount of expenses for that apartment
    """
    utilities = create_utilities()
    max_amount = 0
    for i in utilities:
        amount = get_expense_amount(apart, i)
        if max_amount < amount:
            max_amount = amount
    return max_amount


def create_apartment_and_amount(apartment, amount):
    """

    :param apartment: The apartment
    :param amount: The total amount of expenses
    :return: a list containing both
    """
    return [apartment, amount]


def get_total_amount(apartment):
    """

    :param apartment: The apartment
    :return: List of utilities
    """
    return apartment[1]


def get_apartment_and_expense(complex):
    """

    :param complex: Apartment complex
    :return: A list of apartments and their respective expenses
    """
    apartments = []
    for i in range(1, len(complex)):
        max_amount = total_expenses(complex,i)
        apartment_and_expense = create_apartment_and_amount(complex[i], max_amount)
        apartments.append(apartment_and_expense)
    return apartments


def set_expense_amount(apart, type, amount):
    """

    :param apart: The apartment
    :param type: The utility which value we want to modify
    :param amount: The value we want to set
    :return:
    """
    apart[1][type] = amount


def remove_expense_from_apartment(apart, type):
    """

    :param apart: The desired apartment
    :param type:The utility which value we want to erase
    :return:
    """
    apart[1][type] = 0


def total_amount_for_expense(complex):
    total_expense = []
    utilities = create_utilities()
    for i in utilities:
        total = 0
        for j in range (1, len(complex)):
            amount = get_expense_amount(complex[j], i)
            total = total + amount
        total_expense.append(total)
    return total_expense


def add_expense_amount(apart, type, amount):
    """

    :param apart: The desired apartment
    :param type: The utility which value we want to erase
    :param amount: The amount we want to add to the utility
    :return:
    """
    apart[1][type] += amount


def filter_expenses_from_complex(complex, type):
    """

    :param complex: Apartment complex
    :param type: The type we want to keep
    :return:
    """
    utilities = create_utilities()
    for i in range(1, len(complex)):
        for j in utilities:
            if j == type:
                continue
            else:
                remove_expense_from_apartment(complex[i], j)


def remove_all_expenses_apartment(apart):
    """

    :param apart: The desired apartment
    :return:
    We set all of the apartments' utilities at 0
    """
    expenses = create_expenses()
    amount = expenses.keys()
    for i in amount:
        set_expense_amount(apart, i, 0)


def add_amount_for_expense(complex, type):
    """

    :param complex: Apartment complex
    :param type: The type we add for every apartment
    :return:
    """
    total = 0
    for i in range(1, len(complex)):
        amount = get_expense_amount(complex[i], type)
        total = total + amount
    return total


def update_copy(complex, save):
    """
    Function to update the list for undo
    :param complex: Apartment complex
    :param save: The list where we keep the changes for undo
    :return:
    """
    save_step = copy.deepcopy(complex)
    save.append(save_step)




def add_command_run(complex, param1, param2, param3):
    """

    :param complex: Apartment complex
    :param param1: The apartment's id
    :param param2: The utility that we want to modify
    :param param3: The value that we want to add
    :return:
    """

    if not param1.isnumeric():
        raise ValueError("Not an apartment")
    elif int(param1) > 10:
        raise IndexError("Invalid apartment")
    else:
        id = int(param1)
    type = param2
    amount = int(param3)
    add_expense_amount(complex[id], type, amount)
    update_copy(complex, save)


def remove_command_run(complex, param1, param2):
    """

    :param complex: Apartment complex
    :param param1: The utility that we want to erase for everyone or the first apartment whose utilities we want to remove
    :param param2: The last apartment whose utilities we want to remove or None if param1 is a utility
    :return:
    """
    utilities = create_utilities()


    if param1 in utilities and param2 == None:
        utility = param1
        for i in range(1, len(complex)):
            update_copy(complex, save)
            remove_expense_from_apartment(complex[i], utility)

    elif (int(param1) > 0  and int(param1) < len(complex)) and param2 == None:
        update_copy(complex, save)
        remove_all_expenses_apartment(complex[int(param1)])

    elif (int(param1) > 0 and int(param1) < len(complex)) and (int(param2) > 0 and int(param2) < len(complex)):
        update_copy(complex, save)
        first_apartment = int(param1)
        last_apartment = int(param2)
        for i in range(first_apartment, last_apartment+1):
            remove_all_expenses_apartment(complex[i])



def replace_command_run(complex, param1, param2, param3):
    """

    :param complex: Apartment complex
    :param param1: Number of apartment
    :param param2: The utility which value we want to replace
    :param param3: The new value that is added to the utility
    :return:
    """
    id = int(param1)
    type = param2
    amount = int(param3)
    utilities = create_utilities()
    if type not in utilities:
        raise ValueError("Invalid utility")
    set_expense_amount(complex[id], type, amount)
    update_copy(complex, save)


def filter_command_run(complex, param1):
    """

    :param complex: Apartment complex
    :param param1: A type or amount of money
    :return:
    """
    utilities = create_utilities()
    if param1 in utilities:
        update_copy(complex, save)
        filter_expenses_from_complex(complex, param1)
    elif param1.isnumeric():
        for i in range(1, len(complex)):
            expenses_for_apartment = total_expenses(complex, i)
            if expenses_for_apartment >= int(param1):
                update_copy(complex, save)
                remove_all_expenses_apartment(complex[i])
    elif param1 == None:
        raise AttributeError("Invalid parameter")

update_copy(complex, save)

def undo_command_run(complex, save):
    """

    :param complex: Apartment complex
    :param save: The list where we keep the changes for undo
    :return:
    """
    if len(save) > 1:
        save.pop()
        complex.clear()
        complex.extend(save[-1])
    pass









