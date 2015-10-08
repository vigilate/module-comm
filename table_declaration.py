from sqlalchemy_utils.functions import database_exists, create_database
from sqlalchemy import create_engine, exc
from Table import *
import Config

print("Setup the data base")
mysql_url = 'mysql+pymysql://%s:%s@%s/vigilate' % (Config.config.mysql_user,
                                                   Config.config.mysql_pwd,
                                                   Config.config.pgsql_host)

pgsql_url = 'postgresql://%s:%s@%s/vigilate' % (Config.config.pgsql_user,
                                                Config.config.pgsql_pwd,
                                                Config.config.pgsql_host)

if database_exists(mysql_url) or database_exists(pgsql_url):
    print ("Database already setup")
else:
    try:
        create_database(mysql_url)
        engine = create_engine(mysql_url)
    except exc.OperationalError as err1:
        try:
            create_database(pgsql_url)
            engine = create_engine(pgsql_url)
        except exc.OperationalError as err2:
            exit("Can't create database : mysql, postgres %s" % err2)
            
    Base.metadata.create_all(engine)
    s = sessionmaker(bind=engine)()
    s.add(Users(username="NULL", email="NULL", password="NULL", type=0, contrat=0, id_dealer=1))
    s.commit()
    print("Setup finish")
