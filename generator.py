import random
from datetime import timedelta

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

    def send_query_from_file(self, filename, args=None, fetch=False):
        with open(filename, "r") as sql_file:
            query = sql_file.read()
        return self.send_query(query, args, fetch)

    def get_min_max(self, table, column):
        maxi = self.send_query(f"SELECT MAX({column}) FROM [{table}]", None, True)[0][0]
        mini = self.send_query(f"SELECT MIN({column}) FROM [{table}]", None, True)[0][0]
        return mini, maxi

class DatabaseManager(DatabaseConnection):
    def __init__(self):
        super().__init__()

    def insert_employee(self, first_name, last_name, email, login, password, address, city, region, postal_code,
                        country, phone, role):
        self.send_query_from_file("./inserts/insert_employee.sql", (
            first_name, last_name, email, login, password, address, city, region, postal_code, country, phone, role))

    def insert_user(self, first_name, last_name, email, login, password, address, city, region, postal_code, country,
                    phone):
        self.send_query_from_file("./inserts/insert_user.sql", (
            first_name, last_name, email, login, password, address, city, region, postal_code, country, phone))

    def insert_order_details(self, order_id, service_id, shipped_date):
        self.send_query_from_file("./inserts/insert_order_details.sql",
                                  (order_id, service_id, shipped_date))

    def insert_order(self, user_id, order_date, ship_address, ship_city, cart_details):
        self.send_query_from_file("./inserts/insert_order.sql", (user_id, order_date, ship_address, ship_city))

        order_id = self.send_query("SELECT @@IDENTITY", None, True)[0][0]
        print("Order: ")
        print(user_id, order_date, ship_address, ship_city)
        for data in cart_details:
            print("Order details: ")
            print(data)
            self.insert_order_details(order_id, *data)

    def insert_webinar(self, lecturer_id, translator_id, meeting_link, start_date, end_date, title, description,
                       language):
        self.send_query_from_file("./inserts/insert_webinar.sql", (
            lecturer_id, translator_id, meeting_link, start_date, end_date, title, description, language))

    def insert_studies_module(self, programme_id, name, description):
        self.send_query_from_file("./inserts/insert_studies_module.sql", (programme_id, name, description))

    def insert_studies_programme(self, name, description):
        self.send_query_from_file("./inserts/insert_studies_programme.sql", (name, description))

    def insert_exam(self, studies_id, user_id, passed, date):
        self.send_query_from_file("./inserts/insert_exam.sql", (studies_id, user_id, passed, date))

    def insert_course(self, lecturer_id, translator_id, price, title, description, advance, person_limit, start_date):
        self.send_query_from_file("./inserts/insert_course.sql",
                                  (lecturer_id, translator_id, price, title, description, advance, person_limit, start_date))

    def insert_internship(self, studies_id, user_id, passed, start_date, end_date):
        self.send_query_from_file("./inserts/insert_internship.sql",
                                  (studies_id, user_id, passed, start_date, end_date))

    def insert_meeting(self, type_of_meeting_id, classroom_no, building_no, meeting_link, recording_link, translator_id,
                       lecturer_id, title, description, start_date, end_date, language, module_id):
        self.send_query_from_file("./inserts/insert_meeting.sql", (
            type_of_meeting_id, classroom_no, building_no, meeting_link, recording_link, translator_id,
            lecturer_id, title, description, start_date, end_date, language, module_id))

    def insert_module(self, course_id, lecturer_id, individual_price, start_date, end_date, price, module_programme_id,
                      studies_id, person_limit):
        self.send_query_from_file("./inserts/insert_module.sql", (
            course_id, lecturer_id, individual_price, start_date, end_date, price, module_programme_id,
            studies_id, person_limit))

    def insert_studies(self, programme_id, price, start_date, person_limit, ready):
        self.send_query_from_file("./inserts/insert_studies.sql", (programme_id, price, start_date, person_limit, ready))

class DataGenerator:
    def __init__(self):
        super().__init__()
        self.faker = Faker()
        self.dm = DatabaseManager()

    def insert_to_employee(self, n):
        f = self.faker
        mi, ma = self.dm.get_min_max("Roles", "RoleID")
        employee_data = [
            (
                f.first_name(), f.last_name(), f.unique.email(), f.unique.user_name(), f.password(),
                f.address(), f.city(), f.state(), f.zipcode(), f.country(), f.phone_number(), random.randint(mi, ma)
            )
            for _ in range(n)
        ]

        for data in employee_data:
            self.dm.insert_employee(*data)

    def insert_to_user(self, n):
        f = self.faker
        user_data = [
            (
                f.first_name(), f.last_name(), f.unique.email(), f.unique.user_name(), f.password(),
                f.address(), f.city(), f.state(), f.zipcode(), f.country(), f.phone_number()
            )
            for _ in range(n)
        ]

        for data in user_data:
            self.dm.insert_user(*data)

    def insert_orders(self, n):
        min_users, max_users = self.dm.get_min_max("User", "UserID")
        min_services, max_services = self.dm.get_min_max("Services", "ServiceID")

        f = self.faker
        for _ in range(n):
            order_data = (random.randint(min_users, max_users), f.date_this_year(), f.address().replace("\n", " "), f.city())

            num_order_details = random.randint(1, 5)

            cart_details = [(f.random.randint(min_services, max_services), f.date_this_year()) for _ in
                            range(num_order_details)]

            self.dm.insert_order(*order_data, cart_details)

    def insert_webinars(self, n):
        min_employees, max_employees = self.dm.get_min_max("Employee", "EmployeeID")

        for _ in range(n):
            lecturer_id = random.randint(min_employees, max_employees)
            translator_id = random.randint(min_employees, max_employees)
            meeting_link = f"https://meet.example.com/{self.faker.uuid4()}"
            start_date = self.faker.date_this_year(before_today=True, after_today=False)
            end_date = start_date
            title = self.faker.sentence(nb_words=6)
            description = self.faker.text(max_nb_chars=200)
            language = random.choice(["English", "Spanish", "German", "French", "Chinese"])

            self.dm.insert_webinar(lecturer_id, translator_id, meeting_link, start_date, end_date, title, description,
                                   language)

    def insert_studies_module(self, n):
        mi, ma = self.dm.get_min_max("StudiesProgramme", "ProgrammeID")

        for _ in range(n):
            programme_id = random.randint(mi, ma)
            name = self.faker.word().capitalize()
            description = self.faker.text(max_nb_chars=200)

            self.dm.insert_studies_module(programme_id, name, description)

    def insert_studies_programme(self, n):
        for _ in range(n):
            name = self.faker.word().capitalize()
            description = self.faker.text(max_nb_chars=300)

            self.dm.insert_studies_programme(name, description)

    def insert_exam(self, n):
        miu, mau = self.dm.get_min_max("User", "UserID")
        mis, mas = self.dm.get_min_max("Studies", "StudiesID")

        for _ in range(n):
            studies_id = random.randint(mis , mas)
            user_id = random.randint(miu, mau)
            passed = random.choice([True, False])
            date = self.faker.date_this_decade()

            self.dm.insert_exam(studies_id, user_id, passed, date)

    def insert_course(self, n):
        min_employees, max_employees = self.dm.get_min_max("Employee", "EmployeeID")

        for _ in range(n):
            lecturer_id = random.randint(min_employees, max_employees)
            translator_id = random.randint(min_employees, max_employees)
            price = round(random.uniform(50, 500), 2)
            title = self.faker.sentence(nb_words=5)
            description = self.faker.text(max_nb_chars=300)
            advance = round(random.uniform(10, 100), 2)
            person_limit = random.randint(5, 50)
            start_date = self.faker.date_this_decade()

            self.dm.insert_course(lecturer_id, translator_id, price, title, description, advance, person_limit, start_date)

    def insert_internship(self, n):
        miu, mau = self.dm.get_min_max("User", "UserID")
        mis, mas = self.dm.get_min_max("Studies", "StudiesID")

        for _ in range(n):
            studies_id = random.randint(mis, mas)
            user_id = random.randint(miu, mau)
            passed = random.choice([True, False])
            start_date = self.faker.date_this_year(before_today=False, after_today=True)
            end_date = start_date

            self.dm.insert_internship(studies_id, user_id, passed, start_date, end_date)

    def insert_meeting(self, n):
        min_employees, max_employees = self.dm.get_min_max("Employee", "EmployeeID")
        min_module, max_module = self.dm.get_min_max("Module", "ModuleID")
        mi, ma = self.dm.get_min_max("TypeOfMeeting", "TypeOfMeetingID")

        for _ in range(n):
            type_of_meeting_id = random.randint(mi, ma)
            classroom_no = random.randint(1, 10)
            building_no = random.randint(1, 3)
            meeting_link = self.faker.url()
            recording_link = self.faker.url()
            translator_id = random.choice(
                [None, random.randint(min_employees, max_employees)])
            lecturer_id = random.randint(min_employees, max_employees)
            title = self.faker.sentence()
            description = self.faker.paragraph()
            start_date = self.faker.date_this_year(before_today=False, after_today=True)
            end_date = start_date + timedelta(hours=random.randint(1, 3))
            language = random.choice(['English', 'Spanish', 'German', 'French', 'Italian'])
            module_id = random.randint(min_module, max_module)

            self.dm.insert_meeting(type_of_meeting_id, classroom_no, building_no, meeting_link, recording_link,
                                   translator_id, lecturer_id, title, description, start_date, end_date, language,
                                   module_id)

    def insert_module(self, n):
        min_employees, max_employees = self.dm.get_min_max("Employee", "EmployeeID")
        min_course, max_course = self.dm.get_min_max("Courses", "CourseID")
        min_studies, max_studies = self.dm.get_min_max("Studies", "StudiesID")
        min_module, max_module = self.dm.get_min_max("StudiesProgrammeModules", "ModuleProgrammeID")

        for _ in range(n):
            course_id = random.choice([None, random.randint(min_course, max_course)])
            lecturer_id = random.randint(min_employees, max_employees)
            individual_price = round(random.uniform(50.0, 500.0), 2)
            start_date = self.faker.date_this_year(before_today=False, after_today=True)
            end_date = start_date + timedelta(
                days=random.randint(30, 90))
            price = round(random.uniform(100.0, 1000.0), 2)
            module_programme_id = random.choice([None, random.randint(min_module, max_module)])
            studies_id = random.choice([None, random.randint(min_studies, max_studies)])
            person_limit = random.randint(10, 30)

            self.dm.insert_module(course_id, lecturer_id, individual_price, start_date, end_date, price,
                                  module_programme_id, studies_id, person_limit)

    def insert_studies(self, n):
        min_module, max_module = self.dm.get_min_max("StudiesProgramme", "ProgrammeID")

        for _ in range(n):
            programme_id = random.randint(min_module, max_module)
            price = round(random.uniform(100.0, 5000.0), 2)
            start_date = self.faker.date_this_year(before_today=False, after_today=True)
            person_limit = random.randint(10, 100)
            ready = random.choice([True, False])

            self.dm.insert_studies(programme_id, price, start_date, person_limit, ready)




