from sqlalchemy import Column, ForeignKey, Integer, String, Date, Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()
    
class Users(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    username = Column(String(20), nullable=False, unique=True)
    email = Column(String(100), nullable=False, unique=True)
    password = Column(String(60), nullable=False)
    type = Column(Integer, nullable=False)
    contrat = Column(Integer, nullable=False)
    id_dealer = Column(Integer, ForeignKey('users.id'))
    
class User_monitored_program(Base):
    __tablename__ = 'user_monitored_program'

    id = Column(Integer, primary_key=True)
    program_name = Column(String(20), nullable=False)
    program_version = Column(String(20), nullable=False)
    minimum_score = Column(Integer, nullable=False)
    id_user = Column(Integer, ForeignKey('users.id'), nullable=False)

    
class User_preference(Base):
    __tablename__ = 'user_preference'

    id = Column(Integer, primary_key=True)
    id_user = Column(Integer, ForeignKey('users.id'), nullable=False)
    id_program = Column(Integer, ForeignKey('user_monitored_program.id'), nullable=False)
    score = Column(Integer, nullable=False)
    alert_mean = Column(Integer, nullable=False)


class Vulns(Base):
    __tablename__ = 'vulns'

    id = Column(Integer, primary_key=True)
    cveid = Column(String(20), nullable=False)
    program_name = Column(String(100), nullable=False)
    program_version = Column(String(100), nullable=False)
    date = Column(Date, nullable=False)
    detail = Column(Text, nullable=False)
    simplified_detail = Column(Text, nullable=False)
    score = Column(Integer, nullable=False)

    
class Alertes(Base):
    __tablename__ = 'alertes'

    id = Column(Integer, primary_key=True)
    id_user = Column(Integer, ForeignKey('users.id'), nullable=False)
    id_cve = Column(Integer, ForeignKey('vulns.id'), nullable=False)
    alert_mean = Column(Integer, nullable=False)
