class Services:
    def __init__(self):
        self._expenses = []

    @property
    def expenses(self):
        return self._expenses

    @expenses.setter
    def expenses(self, list):
        self._expenses = list

    def add_expense(self, new_expense):
        """
        Function that adds new objects (expenses)
        :param new_expense: Made of the day, amount and type
        :return:
        """
        for expense in self._expenses:
            if expense.day == new_expense.day and expense.amount == new_expense.amount and expense.type == new_expense.type:
                raise ValueError("This expense is already in the list")
        self._expenses.append(new_expense)

    def filter_expense(self, amount):
        """
        Function that filters the objects based on the value entered by the user using lambda
        :param amount: The amount entered by the user
        :return:
        """
        self._expenses = list(filter(lambda x: x.amount > amount, self._expenses))