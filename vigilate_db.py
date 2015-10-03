from sqlalchemy import engine, exc

class vigilate_db:
    """VIGILATE's dabatase communication module"""

    def __init__(self):

        try:
            self.e = engine.create_engine("mysql://root:toor@localhost/vigilate")
            connection = self.e.connect()
        except exc.OperationalError as err:
            print (err)
        else:
            print ("Successfully connected to mariadb database.")
            return
