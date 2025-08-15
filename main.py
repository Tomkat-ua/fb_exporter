import os

from prometheus_client import start_http_server, Info, Gauge
from dotenv import load_dotenv
import db,time

load_dotenv()

app_name = 'Firebird Exporter'
app_ver = '0.0.1'
http_server_port = 5000
sql = os.getenv('SQL')

fb_monitoring = Gauge('fb_monitoring','FB Monitoring Data',['param','db'])
info= Info('app','Application about',['name','version'])

def get_data():
    try:
        con = db.get_connection()
        cur = con.cursor()
        cur.execute(sql)
        result = cur.fetchall()
        con.commit()
        cur.close()
        con.close()
        return result
    except Exception as e:
        return str(e)

info.labels(app_name, app_ver)

if __name__ == "__main__":
    get_data()
    print('Start metrics server on http://localhost:'+str(http_server_port))
    start_http_server(http_server_port)
    while True:
        # try:
        #     fb_monitoring.labels('reload proc', db.db_path).set(0)
            for row in get_data():
                param = row[0]
                value = float(row[1])
                fb_monitoring.labels(param.strip(), db.db_path).set(value)
            time.sleep(15)
        # except Exception as e:
        #     fb_monitoring.labels('reload proc', db.db_path).set(1)
