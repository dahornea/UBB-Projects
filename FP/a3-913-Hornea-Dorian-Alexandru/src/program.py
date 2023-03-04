#5. Apartment Building Administrator

"""
  Write non-UI functions below
"""

def get_utilities(apartment):
    """

    :param apartment: Apartment which utilities we want to receive
    :return: The utilities and the amounts attributed to each one
    """
    return apartment[1]

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

def test_create_apartment():
    assert create_apartment(3) == [3, {"water": 0, "gas": 0, "electricity": 0, "heating": 0, "other": 0}]

test_create_apartment()


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
    utilities = get_utilities(complex[id])
    expenses = create_expenses()
    total = 0
    for i in expenses:
        amount = get_utilities_amount(utilities, i)
        total = total + amount
    return total


def test_total_expenses():
    complex = [create_apartment(0)]
    assert total_expenses(complex, 0) == 0

test_total_expenses()



def create_utilities():
    """

    :return: The utilities found in every apartment
    """
    utilites = ['water', 'gas', 'electricity', 'heating', 'other']
    return utilites


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

def test_split_command_params():

    assert split_command_params('eXiT') == ('exit', None, None, None)
    assert split_command_params('        ADD   3    GAS  50  ') == ('add', '3', 'gas', '50')
    assert split_command_params('  ADd 5 WATer    75') == ('add', '5', 'water', '75')
    assert split_command_params('  adD 7 ElectriCitY   233') == ('add', '7', 'electricity', '233')
    assert split_command_params('      LIST') == ('list', None, None, None)
    assert split_command_params(' list     <    50') == ('list', '<', '50', None)
    assert split_command_params('  liSt   =   30  ') == ('list', '=', '30', None)
    assert split_command_params('  LisT    >   40  5') ==('list', '>', '40', '5')
    assert split_command_params('replace 3 gas with 200 5') == ('replace', '3', 'gas', '200')
    assert split_command_params('   REPLACE  3  GAS WIth 500') == ('replace', '3', 'gas', '500')
    assert split_command_params('reMOve       5') == ('remove', '5', None, None)
    assert split_command_params('remove 5 to 10') == ('remove', '5', '10', '10')

test_split_command_params()



def set_id(complex, id, newid):
    """

    :param complex: Apartment complex
    :param id: The apartment's current id
    :param newid: The id we want to assign
    :return:
    """
    complex[id] = complex[newid]


def set_expense_amount(apart, type, amount):
    """

    :param apart: The desired apartment
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


def add_expense_amount(apart, type, amount):
    """

    :param apart: The desired apartment
    :param type: The utility which value we want to erase
    :param amount: The amount we want to add to the utility
    :return:
    """
    apart[1][type] += amount


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

"""
  Write the command-driven UI below
"""


def add_command_run(complex, param1, param2, param3):
    """

    :param complex: Apartment complex
    :param param1: The apartment's id
    :param param2: The utility that we want to modify
    :param param3: The value that we want to add
    :return:
    """
    try:
        id = int(param1)
        type = param2
        amount = int(param3)
        add_expense_amount(complex[id], type, amount)
    except ValueError:
        print("Invalid input")
    except KeyError:
        print("Invalid input")
    except IndexError:
        print("Apartment doesn't exist")
    except TypeError:
        print("Invalid input")

def remove_command_run(complex, param1, param2):
    """

    :param complex: Apartment complex
    :param param1: The utility that we want to erase for everyone or the first apartment whose utilities we want to remove
    :param param2: The last apartment whose utilities we want to remove or None if param1 is a utility
    :return:
    """
    utilities = create_utilities()

    try:
        if param1 in utilities and param2 == None:
            utility = param1
            for i in range(1, len(complex)):
                remove_expense_from_apartment(complex[i], utility)

        elif (int(param1) > 0  and int(param1) < len(complex)) and param2 == None:
                remove_all_expenses_apartment(complex[int(param1)])

        elif (int(param1) > 0 and int(param1) < len(complex)) and (int(param2) > 0 and int(param2) < len(complex)):
            first_apartment = int(param1)
            last_apartment = int(param2)
            for i in range(first_apartment, last_apartment+1):
                remove_all_expenses_apartment(complex[i])
    except (ValueError, KeyError):
        print("Invalid input")
    except (NameError, TypeError):
        print("Wrong command parameters")
    except IndexError:
        print("Apartment doesn't exist")


def replace_command_run(complex, param1, param2, param3):
    """

    :param complex: Apartment complex
    :param param1: Number of apartment
    :param param2: The utility which value we want to replace
    :param param3: The new value that is added to the utility
    :return:
    """
    try:
        id = int(param1)
        type = param2
        amount = int(param3)
        utilities = create_utilities()
        if type not in utilities:
            raise ValueError("Invalid utility")
        set_expense_amount(complex[id], type, amount)
    except (NameError, TypeError):
        print("Wrong command parameters")
    except (ValueError, KeyError):
        print("Invalid input")
    except IndexError:
        print("Apartment doesn't exist")


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
    except (NameError, TypeError):
        print("Wrong command parameters")
    except (ValueError, KeyError):
        print("Invalid input")
    except IndexError:
        print("Apartment doesn't exist")


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
    print("\t `list [ < | = | > ] <amount> - display all expenses with the desired property")
    print("'exit' to stop the program")


def start_command_ui():
    cmd_dict = {'add':add_command_run, 'list':list_command_run, 'replace':replace_command_run, 'remove':remove_command_run}
    print_menu()

    while True:

        user_cmd = input(">>>")

        cmd_word, cmd_param1, cmd_param2, cmd_param3 = split_command_params(user_cmd)

        if cmd_word == 'exit':
            return
        if cmd_word not in cmd_dict:
            print("Invalid command!")
        if cmd_word == 'add':
            cmd_dict[cmd_word](complex, cmd_param1, cmd_param2, cmd_param3)
        if cmd_word == 'list':
            cmd_dict[cmd_word](complex, cmd_param1, cmd_param2)
        if cmd_word == 'replace':
            cmd_dict[cmd_word](complex, cmd_param1, cmd_param2, cmd_param3)
        if cmd_word == 'remove':
            cmd_dict[cmd_word](complex, cmd_param1, cmd_param2)


if __name__ == "__main__":
    complex = ["\tApartment complex:", create_apartment(1), create_apartment(2), create_apartment(3), create_apartment(4), create_apartment(5),
           create_apartment(6), create_apartment(7), create_apartment(8), create_apartment(9), create_apartment(10)]

    start_command_ui()
