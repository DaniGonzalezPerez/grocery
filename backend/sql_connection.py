import os
from urllib.parse import urlparse
import mysql.connector

__conexion = None

def _load_env():
    """Lee el archivo .env de la raiz del proyecto."""
    env_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), '.env')
    if os.path.exists(env_path):
        with open(env_path, encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#') and '=' in line:
                    key, value = line.split('=', 1)
                    os.environ.setdefault(key.strip(), value.strip())

_load_env()

def _parse_database_url(url):
    """Parsea DATABASE_URL (mysql://user:pass@host:port/dbname)."""
    parsed = urlparse(url)
    return {
        'host': parsed.hostname or '127.0.0.1',
        'port': parsed.port or 3306,
        'user': parsed.username or 'root',
        'password': parsed.password or '',
        'database': parsed.path.lstrip('/') or 'almacen',
    }

def get_sql_connection():
    global __conexion
    if __conexion is None or not __conexion.is_connected():
        database_url = os.environ.get('DATABASE_URL')
        if database_url:
            config = _parse_database_url(database_url)
        else:
            config = {
                'host': os.environ.get('DB_HOST', '127.0.0.1'),
                'user': os.environ.get('DB_USER', 'root'),
                'password': os.environ.get('DB_PASSWORD', ''),
                'database': os.environ.get('DB_NAME', 'almacen'),
            }

        if os.environ.get('DB_SSL', '').lower() == 'true':
            config['ssl_disabled'] = False

        __conexion = mysql.connector.connect(**config, autocommit=True)
    return __conexion
