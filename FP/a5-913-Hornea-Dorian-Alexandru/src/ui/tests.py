from services.services import Services
from domain.domain import Expense

def test_add_expense(serv=Services()):
    serv.expenses = []
    serv.add_expense(Expense(20, 75, "Phone bill"))
    assert len(serv.expenses) == 1

test_add_expense()