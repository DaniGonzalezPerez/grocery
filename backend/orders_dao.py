def get_all_orders(conexion):
    cursor = conexion.cursor()
    cursor.execute(
        "SELECT p.id_pedido, p.nombre_cliente, p.total, p.fecha, "
        "COUNT(d.id_producto) as num_productos "
        "FROM pedidos p "
        "LEFT JOIN detalles_pedido d ON p.id_pedido = d.id_pedido "
        "GROUP BY p.id_pedido, p.nombre_cliente, p.total, p.fecha "
        "ORDER BY p.fecha DESC"
    )
    response = []
    for (id_pedido, nombre_cliente, total, fecha, num_productos) in cursor:
        response.append({
            'id_pedido': id_pedido,
            'nombre_cliente': nombre_cliente,
            'total': float(total),
            'fecha': str(fecha),
            'num_productos': num_productos
        })
    return response


def get_order_details(conexion, id_pedido):
    cursor = conexion.cursor()
    cursor.execute(
        "SELECT d.id_producto, pr.nombre, pr.unidad_medida, "
        "d.cantidad, pr.precio_unidad, d.precio_total "
        "FROM detalles_pedido d "
        "JOIN productos pr ON d.id_producto = pr.id_producto "
        "WHERE d.id_pedido = %s",
        (id_pedido,)
    )
    response = []
    for (id_producto, nombre, unidad, cantidad, precio, precio_total) in cursor:
        response.append({
            'id_producto': id_producto,
            'nombre': nombre,
            'unidad_medida': unidad,
            'cantidad': cantidad,
            'precio_unidad': float(precio),
            'precio_total': float(precio_total)
        })
    return response


def insert_order(conexion, pedido):
    cursor = conexion.cursor()
    query = (
        "INSERT INTO pedidos (id_pedido, nombre_cliente, total, fecha) "
        "VALUES (%s, %s, %s, %s)"
    )
    data = (pedido['id_pedido'], pedido['nombre_cliente'], pedido['total'], pedido['fecha'])
    cursor.execute(query, data)
    conexion.commit()

    id_pedido = pedido['id_pedido']
    for detalle in pedido.get('detalles', []):
        query_detalle = (
            "INSERT INTO detalles_pedido (id_pedido, id_producto, cantidad, precio_total) "
            "VALUES (%s, %s, %s, %s)"
        )
        data_detalle = (id_pedido, detalle['id_producto'], detalle['cantidad'], detalle['precio_total'])
        cursor.execute(query_detalle, data_detalle)

    conexion.commit()
    return id_pedido
