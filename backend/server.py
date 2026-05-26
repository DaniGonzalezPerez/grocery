import os
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import products_dao
import orders_dao
import stock_dao
from sql_connection import get_sql_connection

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FRONTEND_DIR = os.path.join(BASE_DIR, 'frontend')
UI_DIR = os.path.join(BASE_DIR, 'ui')

app = Flask(__name__)
CORS(app)

conexion = get_sql_connection()

@app.route('/getProducts', methods=['GET'])
def get_products():
    productos = products_dao.get_all_productos(conexion)
    return jsonify(productos)

@app.route('/insertProduct', methods=['POST'])
def insert_product():
    producto = request.get_json()
    id_producto = products_dao.insert_new_product(conexion, producto)
    stock_dao.init_stock_for_product(conexion, id_producto)
    return jsonify({'id_producto': id_producto})

@app.route('/deleteProduct/<int:id_producto>', methods=['DELETE'])
def delete_product(id_producto):
    products_dao.delete_products(conexion, id_producto)
    return jsonify({'message': 'Producto eliminado'})

@app.route('/getOrders', methods=['GET'])
def get_orders():
    pedidos = orders_dao.get_all_orders(conexion)
    return jsonify(pedidos)

@app.route('/getOrderDetails/<int:id_pedido>', methods=['GET'])
def get_order_details(id_pedido):
    detalles = orders_dao.get_order_details(conexion, id_pedido)
    return jsonify(detalles)

@app.route('/insertOrder', methods=['POST'])
def insert_order():
    pedido = request.get_json()
    id_pedido = orders_dao.insert_order(conexion, pedido)
    for detalle in pedido.get('detalles', []):
        stock_dao.update_stock_after_order(conexion, detalle['id_producto'], detalle['cantidad'])
    return jsonify({'id_pedido': id_pedido})

@app.route('/getStock', methods=['GET'])
def get_stock():
    stock = stock_dao.get_all_stock(conexion)
    return jsonify(stock)

@app.route('/getLowStock', methods=['GET'])
def get_low_stock():
    umbral = request.args.get('umbral', 20, type=int)
    alertas = stock_dao.get_low_stock(conexion, umbral)
    return jsonify(alertas)

@app.route('/')
def serve_index():
    return send_from_directory(FRONTEND_DIR, 'index.html')

@app.route('/<path:filename>.html')
def serve_html(filename):
    return send_from_directory(FRONTEND_DIR, filename + '.html')

@app.route('/js/<path:filename>')
def serve_js(filename):
    return send_from_directory(os.path.join(FRONTEND_DIR, 'js'), filename)

@app.route('/ui/<path:filename>')
def serve_ui(filename):
    return send_from_directory(UI_DIR, filename)

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 5000))
    debug = os.environ.get('FLASK_ENV') != 'production'
    print("Starting Python Flask server for Grocery Store")
    print(f"Abre http://localhost:{port} en tu navegador")
    app.run(host='0.0.0.0', port=port, debug=debug)
