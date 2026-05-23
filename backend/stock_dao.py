def get_all_stock(conexion):
    cursor = conexion.cursor(buffered=True)
    cursor.execute(
        "SELECT s.id_producto, p.nombre, p.unidad_medida, "
        "s.stock_inicial, s.stock_actual "
        "FROM stock s "
        "JOIN productos p ON s.id_producto = p.id_producto "
        "ORDER BY s.stock_actual ASC"
    )
    response = []
    for (id_producto, nombre, unidad, stock_inicial, stock_actual) in cursor.fetchall():
        response.append({
            'id_producto': id_producto,
            'nombre': nombre,
            'unidad_medida': unidad,
            'stock_inicial': stock_inicial,
            'stock_actual': stock_actual
        })
    return response


def get_stock_by_product(conexion, id_producto):
    cursor = conexion.cursor(buffered=True)
    cursor.execute(
        "SELECT stock_actual FROM stock WHERE id_producto = %s",
        (id_producto,)
    )
    row = cursor.fetchone()
    return row[0] if row else 0


def get_low_stock(conexion, umbral=20):
    cursor = conexion.cursor(buffered=True)
    cursor.execute(
        "SELECT s.id_producto, p.nombre, p.unidad_medida, "
        "s.stock_actual "
        "FROM stock s "
        "JOIN productos p ON s.id_producto = p.id_producto "
        "WHERE s.stock_actual < %s "
        "ORDER BY s.stock_actual ASC",
        (umbral,)
    )
    response = []
    for (id_producto, nombre, unidad, stock_actual) in cursor.fetchall():
        response.append({
            'id_producto': id_producto,
            'nombre': nombre,
            'unidad_medida': unidad,
            'stock_actual': stock_actual
        })
    return response


def init_stock_for_product(conexion, id_producto, stock_inicial=100):
    cursor = conexion.cursor(buffered=True)
    cursor.execute(
        "INSERT IGNORE INTO stock (id_producto, stock_inicial, stock_actual) "
        "VALUES (%s, %s, %s)",
        (id_producto, stock_inicial, stock_inicial)
    )
    conexion.commit()


def update_stock_after_order(conexion, id_producto, cantidad):
    cursor = conexion.cursor(buffered=True)
    cursor.execute(
        "UPDATE stock SET stock_actual = stock_actual - %s "
        "WHERE id_producto = %s",
        (int(cantidad), id_producto)
    )
    conexion.commit()
