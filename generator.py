import random
import pyodbc
from faker import Faker

class DatabaseConnection:
    def __init__(self):
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

    def get_last_inserted_id(self):
        return self.send_query_from_file("./selects/select_last_id.sql", None, True)[0][0]

    def send_query(self, query, args=None, fetch=False):
        cursor = None
        try:
            cursor = self.connection.cursor()

            if args:
                cursor.execute(query, args)
            else:
                cursor.execute(query)

            if not fetch:
                self.connection.commit()

            if fetch:
                return cursor.fetchall()
        except pyodbc.Error as ex:
            print("Error executing query:", ex)
            self.connection.rollback()
            return None
        finally:
            if cursor:
                cursor.close()
    def drop_table(self, table_name):
        drop_query = f"DROP TABLE IF EXISTS {table_name};"
        self.send_query(drop_query)

    def send_query_from_file(self, filename, args = None, fetch = False):
        with open(filename, "r") as sql_file:
            query = sql_file.read()
        self.send_query(query, args, fetch)


class DatabaseManager(DatabaseConnection):
    def __init__(self):
        super().__init__()

    def insert_employee_role(self, employee_id, role_name):
        self.send_query_from_file("./inserts/insert_employee_role.sql", (employee_id, role_name))

    def insert_employee(self, first_name, last_name, email, login, password, address, city, region, postal_code, country, phone, role):
        self.send_query_from_file("./inserts/insert_employee.sql", (first_name, last_name, email, login, password, address, city, region, postal_code, country, phone))
        employee_id = self.get_last_inserted_id()
        self.insert_employee_role(employee_id, role)

    def insert_roles(self):
        roles = ['Lecturer', 'Translator', 'OfficeWorker', 'Accountant']

        for data in roles:
            self.send_query_from_file("./inserts/insert_roles.sql", (data,))

class DataGenerator:
    def __init__(self):
        super().__init__()
        self.faker = Faker()
        self.dm = DatabaseManager()

    def insert_to_employee(self, n):
        roles = ['Lecturer', 'Translator', 'OfficeWorker', 'Accountant']

        f = self.faker
        employee_data = [
            (
                f.first_name(), f.last_name(), f.unique.email(), f.unique.user_name(), f.password(),
                f.address(), f.city(), f.state(), f.zipcode(), f.country(), f.phone_number()
            )
            for _ in range(n)
        ]

        for data in employee_data:
            role = random.choice(roles)
            self.dm.insert_employee(*data, role)







