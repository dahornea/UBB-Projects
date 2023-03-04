import random

class Expense:
    def __init__(self, day, amount, type):
        """
        We create an object Expense of the class Expense with the following properties:
        :param day: Integer. The day the expense happened
        :param amount: Integer. The amount of the expense
        :param type: String. The type of the expense
        """
        self._day = day
        self._amount = amount
        self._type = type

    def __str__(self):
        """

        :return: The form in which we want to print the objects
        """
        return "On day " + str(self._day) + " you spent " + str(self._amount) + " on " + self._type

    @property
    def day(self):
        return self._day

    @property
    def amount(self):
        return self._amount

    @property
    def type(self):
        return self._type

    @day.setter
    def day(self, value):
        self._day = value

    @amount.setter
    def amount(self, value):
        self._amount = value

    @type.setter
    def type(self, value):
        self._type = value

    @staticmethod
    def sample_expenses():
        """

        :return: Randomly generated expenses list
        """
        types = ["Books", "VideoGames", "Food", "Other", "Drinks", "Car Fuel", "Utilities", "Gym Membership",
                "Netflix Subscription", "Food", "Clothes", "Phone Bill", "Transportation"]
        expenses = []
        for i in range(0,10):
            expenses.append(Expense(random.randint(1, 30), random.randint(1, 500), random.choice(types)))
        return expenses

