# Almacén - Sistema de Gestión de Productos

Sistema web para la gestión de productos y pedidos de un almacén de alimentación.

---

## Estructura del Proyecto

```
grocery/
├── iniciar.bat              # Script para iniciar la aplicación
├── DOCUMENTACION.md         # Este archivo
├── backend/
│   ├── server.py            # Servidor Flask (API REST + servidor de archivos)
│   ├── sql_connection.py    # Conexión a la base de datos MySQL
│   ├── products_dao.py      # Operaciones de base de datos para productos
│   └── orders_dao.py        # Operaciones de base de datos para pedidos
├── frontend/
│   ├── index.html           # Dashboard principal
│   ├── manage_products.html # Gestión de productos (CRUD)
│   ├── order.html           # Historial de pedidos
│   └── js/
│       ├── common.js        # Funciones compartidas (API, formatos, categorías)
│       ├── dashboard.js     # Lógica del dashboard
│       ├── manage_products.js # Lógica de gestión de productos
│       └── order.js         # Lógica de pedidos
├── ui/
│   └── styles.css           # Estilos globales de la aplicación
└── database/
    └── database.sql         # Dump de la base de datos (esquema + datos)
```

---

## Requisitos Previos

- **Python 3.8+**
- **MySQL 8.0+**
- **Paquetes Python:** Flask, flask-cors, mysql-connector-python

---

## Instalación

### 1. Base de datos

Importa el dump en MySQL:

```sql
mysql -u root -p < database/database.sql
```

Esto crea la base de datos `almacen` con tres tablas:

| Tabla             | Descripción                          |
|-------------------|--------------------------------------|
| `productos`       | Catálogo de productos del almacén    |
| `pedidos`         | Registro de pedidos de clientes      |
| `detalles_pedido` | Líneas de detalle de cada pedido     |

### 2. Configuración de la conexión

Edita `backend/sql_connection.py` con tus credenciales de MySQL:

```python
__conexion = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="TU_CONTRASEÑA",
    database="almacen"
)
```

### 3. Dependencias Python

```bash
pip install flask flask-cors mysql-connector-python
```

---

## Ejecución

### Opción 1: Doble clic en `iniciar.bat`

El script instala dependencias automáticamente, inicia el servidor y abre el navegador.

### Opción 2: Manual

```bash
cd backend
python server.py
```

Luego abre `http://localhost:5000` en tu navegador.

---

## Páginas de la Aplicación

### Dashboard (`/`)

- Tarjetas de estadísticas: total de productos, pedidos, ingresos y pedido promedio
- Grid de productos con tarjetas visuales
- Filtros por categoría: Lácteos, Panadería, Despensa, Verduras
- Barra de búsqueda por nombre

### Gestión de Productos (`/manage_products.html`)

- Tabla con todos los productos del almacén
- Añadir nuevos productos (nombre, unidad de medida, precio)
- Eliminar productos existentes con confirmación
- Búsqueda en tiempo real

### Pedidos (`/order.html`)

- Estadísticas de pedidos: total, ingresos, fecha del último pedido
- Tabla con historial de pedidos
- Modal de detalle por pedido con desglose de productos
- Búsqueda por nombre de cliente

---

## API REST

| Método   | Endpoint                        | Descripción                    |
|----------|---------------------------------|--------------------------------|
| `GET`    | `/getProducts`                  | Lista todos los productos      |
| `POST`   | `/insertProduct`                | Crea un nuevo producto         |
| `DELETE` | `/deleteProduct/<id_producto>`  | Elimina un producto por ID     |
| `GET`    | `/getOrders`                    | Lista todos los pedidos        |
| `GET`    | `/getOrderDetails/<id_pedido>`  | Detalle de un pedido específico|
| `POST`   | `/insertOrder`                  | Crea un nuevo pedido           |

### Ejemplo: Crear un producto

```json
POST /insertProduct
{
    "nombre": "Manzanas",
    "unidad_medida": "kg",
    "precio_unidad": 2.30
}
```

---

## Tecnologías

| Capa      | Tecnología                     |
|-----------|--------------------------------|
| Backend   | Python 3 + Flask               |
| Frontend  | HTML5 + JavaScript (vanilla)   |
| Estilos   | CSS3 (diseño responsive)       |
| Base datos| MySQL 8.0                      |
