from sql_connection import get_sql_connection

def get_all_productos(conexion):

    cursor = conexion.cursor()
    cursor.execute("Select * from productos")
    response=[]
    for (id_producto,nombre,unidad_medida,precio_unidad) in cursor:
         response.append(
             {
             'id_producto' : id_producto,
             'nombre': nombre,
             'unidad_medida':unidad_medida,
             'precio_unidad': precio_unidad
         }
    )
   
    return response
def insert_new_product(conexion,producto):
    cursor=conexion.cursor()
    query= ("INSERT INTO productos"
            "(id_producto,nombre,unidad_medida,precio_unidad)"
            "VALUES (%s,%s,%s,%s)")
    data= (producto['id_producto'],producto['nombre'], producto['unidad_medida'], producto['precio_unidad'])
    cursor.execute(query,data)
    conexion.commit()

    return cursor.lastrowid
def delete_products(conexion, id_producto):
    cursor = conexion.cursor()
    cursor.execute("DELETE FROM productos WHERE id_producto = %s", (id_producto,))
    conexion.commit()


if __name__=="__main__":
    conexion=get_sql_connection()
    print(delete_products(conexion,22))