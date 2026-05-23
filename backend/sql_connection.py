import mysql.connector

__conexion = None

def get_sql_connection():
    global __conexion
    if __conexion is None or not __conexion.is_connected():
        __conexion = mysql.connector.connect(
            host="127.0.0.1",
            user="root",
            password="Danicerredo02@",
            database="almacen",
            autocommit=True
        )
    return __conexion
