from sqlalchemy import engine, exc
from sqlalchemy.orm import sessionmaker 
from table_declaration import Users, User_monitored_program, User_preference, Vulns

def connect_to_database():
    try:
        e = engine.create_engine("mysql+pymysql://root:toor@localhost/vigilate")
        connection = e.connect()
    except exc.OperationalError as err:
        print (err)
    else:
        print ("Successfully connected to the mysql database.")
        session = sessionmaker(bind=e)
        return session()

    try:
        e = engine.create_engine("postgresql://root:toor@localhost/vigilate")
        connection = e.connect()
    except exc.OperationalError as err:
        print (err)
    else:
        print ("Successfully connected to the postgresql database")
        session = sessionmaker(bind=e)
        return session()

def add_user(session, username, email, password, user_type, contrat, id_dealer):
    session.add(Users(username=username, email=email, password=password, type=user_type, contrat=contrat, id_dealer=id_dealer))
    session.commit()
