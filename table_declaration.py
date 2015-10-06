from sqlalchemy_utils.functions import database_exists, create_database
from sqlalchemy import create_engine, exc
from Table import *

print("Setup the data base")
if database_exists('mysql+pymysql://root:toor@localhost/vigilate') or database_exists('postgresql://vigilate@localhost/vigilate'):
    print ("Database already setup")
else:
    try:
        create_database('mysql+pymysql://root:toor@localhost/vigilate')
        engine = create_engine('mysql+pymysql://root:toor@localhost/vigilate')
    except exc.OperationalError as err1:
        try:
            create_database('postgresql://vigilate@localhost/vigilate')
            engine = create_engine('postgresql://vigilate@localhost/vigilate')
        except exc.OperationalError as err2:
            exit("Can't create database : mysql, postgres %s" % err2)
            
    Base.metadata.create_all(engine)
    s = sessionmaker(bind=engine)()
    s.add(Users(username="NULL", email="NULL", password="NULL", type=0, contrat=0, id_dealer=1))
    s.commit()
    print("Setup finish")
