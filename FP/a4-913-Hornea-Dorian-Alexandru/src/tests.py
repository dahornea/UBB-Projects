from functions import *

def test_create_apartment():
    assert create_apartment(3) == [3, {"water": 0, "gas": 0, "electricity": 0, "heating": 0, "other": 0}]



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


def test_create_expenses():
    assert create_expenses() == {"water": 0, "gas": 0, "electricity": 0, "heating": 0, "other": 0}

def test_get_utilities_amount():
    complex[1] = [1, {'water': 0, 'gas': 50, 'electricity': 0, 'heating': 0, 'other': 0}]
    assert get_utilities_amount(complex[1], 1) == {'water': 0, 'gas': 50, 'electricity': 0, 'heating': 0, 'other': 0}

def test_total_expenses():
    complex[1] = [1, {'water': 0, 'gas': 50, 'electricity': 0, 'heating': 0, 'other': 0}]
    assert total_expenses(complex, 1) == 50

def test_create_utilities():
    assert create_utilities() == ['water', 'gas', 'electricity', 'heating', 'other']

def test_set_id():
    set_id(complex, 1, 5)
    assert complex[1][0] == 5

def test_get_expense_amount():
    complex[1] = [1, {'water': 0, 'gas': 50, 'electricity': 0, 'heating': 0, 'other': 0}]
    assert get_expense_amount(complex[1], "gas") == 50

def test_get_max_amount():
    complex[1] = [1, {'water': 25, 'gas': 50, 'electricity': 30, 'heating': 0, 'other': 0}]
    assert get_max_amount(complex[1]) == 50

def test_create_apartment_and_amount():
    assert create_apartment_and_amount(complex[1], 50) == [complex[1], 50]

def test_get_total_amount():
    complex[1] = [1, {'water': 25, 'gas': 50, 'electricity': 30, 'heating': 0, 'other': 0}]
    assert get_total_amount(complex[1]) == {'water': 25, 'gas': 50, 'electricity': 30, 'heating': 0, 'other': 0}

def test_get_apartment_and_expense():
    complex[1] = [1, {'water': 25, 'gas': 50, 'electricity': 30, 'heating': 0, 'other': 0}]
    complex[3] = [3, {'water': 20, 'gas': 50, 'electricity': 30, 'heating': 0, 'other': 0}]
    assert get_apartment_and_expense(complex) == [[[1, {'water': 25, 'gas': 50, 'electricity': 30, 'heating': 0, 'other': 0}], 105], [[2, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}], 0], [[3, {'water': 20, 'gas': 50, 'electricity': 30, 'heating': 0, 'other': 0}], 100], [[4, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}], 0], [[5, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}], 0], [[6, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}], 0], [[7, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}], 0], [[8, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}], 0], [[9, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}], 0], [[10, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}], 0]]

def test_set_expense_amount():
    complex[1] = [1, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}]
    set_expense_amount(complex[1], "gas", 25)
    if complex[1] != [1, {'water': 0, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError

def test_remove_expense_from_apartment():
    complex[1] = [1, {'water': 0, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    remove_expense_from_apartment(complex[1], "gas")
    if complex[1] != [1, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError

def test_total_amount_for_expense():
    complex[1] = [1, {'water': 25, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}]
    complex[3] = [3, {'water': 0, 'gas': 50, 'electricity': 0, 'heating': 0, 'other': 0}]
    assert total_amount_for_expense(complex) == [25, 50, 0, 0, 0]

def test_add_expense_amount():
    complex[1] = [1, {'water': 0, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    add_expense_amount(complex[1], "gas", 50)
    if complex[1] != [1, {'water': 0, 'gas': 75, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError

def test_filter_expenses_from_complex():
    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    complex[3] = [3, {'water': 0, 'gas': 50, 'electricity': 35, 'heating': 0, 'other': 0}]
    filter_expenses_from_complex(complex, "gas")
    if complex[1] != [1, {'water': 0, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}] and complex[3] != [3, {'water': 0, 'gas': 50, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError

def test_remove_all_expenses_apartment():
    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    remove_all_expenses_apartment(complex[1])
    if complex[1] != [1, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError

def test_add_amount_for_expense():
    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    complex[3] = [3, {'water': 0, 'gas': 50, 'electricity': 35, 'heating': 0, 'other': 0}]
    assert add_amount_for_expense(complex, "gas") == 75

def test_add_command_run():
    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    add_command_run(complex, "1", "electricity", "75")
    if complex[1] != [1, {'water': 25, 'gas': 25, 'electricity': 75, 'heating': 0, 'other': 0}]:
        raise AssertionError

def test_remove_command_run():
    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    remove_command_run(complex, "gas", None)
    if complex[1] != [1, {'water': 25, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError

    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    complex[2] = [2, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    remove_command_run(complex, "1", "2")
    if complex[1] != [1, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}] and complex[2] != [2, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError

def test_replace_command_run():
    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    replace_command_run(complex, "1", "gas", "50")
    if complex[1] != [1, {'water': 25, 'gas': 50, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError

def test_filter_command_run():
    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    filter_command_run(complex, "25")
    if complex[1] != [1, {'water': 0, 'gas': 0, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError
    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    complex[2] = [2, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    filter_command_run(complex, "gas")
    if complex[1] != [1, {'water': 0, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}] and complex[2] != [2, {'water': 0, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError

def test_undo_command_run():
    complex[1] = [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]
    replace_command_run(complex, "1", "gas", "50")
    undo_command_run(complex, save)
    if complex[1] != [1, {'water': 25, 'gas': 25, 'electricity': 0, 'heating': 0, 'other': 0}]:
        raise AssertionError


def test_everything():
    test_create_apartment()
    test_total_expenses()
    test_split_command_params()
    test_create_expenses()
    test_get_utilities_amount()
    test_create_utilities()
    test_set_id()
    test_get_expense_amount()
    test_get_max_amount()
    test_create_apartment_and_amount()
    test_get_total_amount()
    test_get_apartment_and_expense()
    test_set_expense_amount()
    test_remove_expense_from_apartment()
    test_total_amount_for_expense()
    test_add_expense_amount()
    test_filter_expenses_from_complex()
    test_remove_all_expenses_apartment()
    test_add_amount_for_expense()
    test_add_command_run()
    test_remove_command_run()
    test_replace_command_run()
    test_filter_command_run()
    test_undo_command_run()