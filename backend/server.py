import os
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import products_dao
import orders_dao
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
    return jsonify({'id_pedido': id_pedido})

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
    print("Starting Python Flask server for Grocery Store")
    print("Abre http://localhost:5000 en tu navegador")
    app.run(host='0.0.0.0', port=5000, debug=True)
