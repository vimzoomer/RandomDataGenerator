import random
import pyodbc
from faker import Faker

class DatabaseConnection:
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

    def get_last_inserted_id(self):
        cursor = self.connection.cursor()
        cursor.execute("SELECT @@IDENTITY")
        id = cursor.fetchone()[0]
        return id

    def get_all_roles(self):
        query = "SELECT id FROM Roles"
        cursor = self.connection.cursor()
        cursor.execute(query)
        roles = [row[0] for row in cursor.fetchall()]
        cursor.close()
        return roles

    def send_query(self, query):
        try:
            cursor = self.connection.cursor()
            cursor.execute(query)
            self.connection.commit()
            cursor.close()
        except pyodbc.Error as ex:
            print("Error executing query:", ex)

class DatabaseManager(DatabaseConnection):
    def __init__(self):
        super().__init__()

    def drop_table(self, table_name):
        drop_query = f"DROP TABLE IF EXISTS {table_name};"
        self.send_query(drop_query)

    def create_roles_table(self):
        create_roles_query = """
                CREATE TABLE Roles (
                    RoleID INT IDENTITY(1,1) PRIMARY KEY,  
                    RoleName VARCHAR(50) NOT NULL          
                );
                """

        self.send_query(create_roles_query)

class DataGenerator(DatabaseConnection):
    def __init__(self):
        super().__init__()

    def __insert_to_database(self, insert_query, data):
        try:
            cursor = self.connection.cursor()

            cursor.execute(insert_query, data)

            self.connection.commit()
            cursor.close()
        except pyodbc.Error as ex:
            print("Błąd wykonania zapytania:", ex)

    def insert_roles(self):
        roles = ['Lecturer', 'Translator', 'OfficeWorker', 'Accountant']

        insert_query = "INSERT INTO roles (RoleName) VALUES (?)"

        for data in roles:
            self.__insert_to_database(insert_query, (data,))

    def insert_to_employee(self, n):
        insert_employee_query = """
                 INSERT INTO Employee (
                     FirstName, LastName, Email, Login, Password,
                     Address, City, Region, PostalCode, Country, Phone
                 ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """

        insert_role_query = "INSERT INTO employee_roles (employee_id, role_id) VALUES (?, ?)"

        roles = self.get_all_roles()

        f = self.faker
        employee_data = [
            (
                f.first_name(), f.last_name(), f.unique.email(), f.unique.user_name(), f.password(),
                f.address(), f.city(), f.state(), f.zipcode(), f.country(), f.phone_number()
            )
            for _ in range(n)
        ]

        for data in employee_data:
            self.__insert_to_database(insert_employee_query, data)
            role_id = random.choice(roles)
            employee_id = self.get_last_inserted_id()
            self.__insert_to_database(insert_role_query, (employee_id, role_id))


c = DataGenerator()
c.insert_roles()



