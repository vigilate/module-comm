from sqlalchemy import engine, exc
from sqlalchemy.orm import sessionmaker 
from sqlalchemy.sql import select
from Table import Users, User_monitored_program, User_preference, Vulns
import PyArgon2
import string
import random
import binascii

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
    salt = ''.join([random.choice(string.printable) for _ in range(10)])
    password = binascii.hexlify(PyArgon2.Hash_pwd(password.encode(), salt.encode())) + salt.encode()
    session.add(Users(username=username, email=email, password=password, type=user_type, contrat=contrat, id_dealer=id_dealer))
    session.commit()

def check_pwd(session, username, password):
    user = session.execute(select("*", "username = '%s'" % username, "users")).first()
    return PyArgon2.Check_pwd(password.encode(), user[3][-10:].encode(), binascii.unhexlify(user[3][:-10]))
