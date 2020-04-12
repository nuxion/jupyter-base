from sqlalchemy import (create_engine, Table, Column, MetaData, select, inspect)

class SQL():

    DRIVERS={
        'mysql': 'mysql+mysqldb://'
    }

    def __init__(self, engine, driver="mysql"):

        self.engine = create_engine("{}{}".format(
            self.DRIVERS[driver], engine))
        self.conn = self.engine.connect()
        self.meta = MetaData()

    def select(self):
        return select
    def get_tables_names(self):
        inspector = inspect(self.engine)
        for tn in inspector.get_table_names():
            print("Tabla: {}".format(tn))

if __name__=='__main__':
    engine = "user:pass@address/db_name"
    sql = SQL(engine, driver="mysql")
    sql.get_tables_names()

