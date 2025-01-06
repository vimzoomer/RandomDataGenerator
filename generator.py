import pyodbc
from faker import Faker

class DataGenerator:
    def __init__(self):
        self.faker = Faker()
        self.connection = None
        try:
            self.connection = pyodbc.connect(
                "DRIVER={ODBC Driver 17 for SQL Server};"
                "SERVER=dbmanage.lab.ii.agh.edu.pl;"
                "DATABASE=u_bilko;"
                "UID=u_bilko;"
                "PWD=BazyDanych2024;"
            )
        except pyodbc.Error as ex:
            print("Błąd połączenia:", ex)

    def insert_to_database(self, insert_query, data):
        try:
            cursor = self.connection.cursor()

            for row in data:
                cursor.execute(insert_query, row)

            self.connection.commit()
            cursor.close()
        except pyodbc.Error as ex:
            print("Błąd wykonania zapytania:", ex)

    def insert_to_employee(self, n):
        insert_query = """
                 INSERT INTO Employee (
                     FirstName, LastName, Email, Login, Password,
                     Address, City, Region, PostalCode, Country, Phone
                 ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """

        f = self.faker
        employee_data = [(f.name(), f.last_name(), f.unique.email(), f.unique.user_name(), f.password(),\
                          f.address(), f.city(), f.regon(), f.postcode(), f.country(), f.phone_number()
                          ) for _ in range(1, n + 1)]

        self.insert_to_database(insert_query, employee_data)


