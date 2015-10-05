from sqlalchemy import Column, ForeignKey, Integer, String, Date, Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy_utils.functions import database_exists, create_database
from sqlalchemy import create_engine, exc

Base = declarative_base()

class Dealer(Base):
    __tablename__ = 'dealer'

    id = Column(Integer, primary_key=True)
    id_user_dealer = Column(Integer, ForeignKey('users.id'), nullable=False)
    id_user_client = Column(Integer, ForeignKey('users.id'), nullable=False)

    
class Users(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    username = Column(String(20), nullable=False, unique=True)
    email = Column(String(100), nullable=False, unique=True)
    password = Column(String(60), nullable=False)
    id_list_programs_monitored = Column(Integer, nullable=False)
    list_programs_monitored = Column(Integer, nullable=False)
    type = Column(Integer, nullable=False)
    contrat = Column(Integer, nullable=False)

    
class User_monitored_program(Base):
    __tablename__ = 'user_monitored_program'

    id = Column(Integer, primary_key=True)
    program_name = Column(String(20), nullable=False)
    program_version = Column(String(20), nullable=False)
    minimum_score = Column(Integer, nullable=False)

    
class User_preference(Base):
    __tablename__ = 'user_preference'

    id = Column(Integer, primary_key=True)
    id_user = Column(Integer, nullable=False)
    id_prgram = Column(Integer, nullable=False)
    score = Column(Integer, nullable=False)
    aler_mean = Column(Integer, nullable=False)


class Vulns(Base):
    __tablename__ = "vulns"

    id = Column(Integer, primary_key=True)
    cveid = Column(String(20), nullable=False)
    program_name = Column(String(100), nullable=False)
    program_version = Column(String(100), nullable=False)
    date = Column(Date, nullable=False)
    detail = Column(Text, nullable=False)
    simplified_detail = Column(Text, nullable=False)
    score = Column(Integer, nullable=False)


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
            print("Can't create database : mysql, postgres %s" % err2)
            exit(0)
            
    Base.metadata.create_all(engine)
    print("Setup finish")
