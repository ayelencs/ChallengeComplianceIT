print("Sistema de Gestión de Mails para Generar Reuniones Presenciales")

print("Cargando tabla User managers.csv")

#importe de librerias
import csv
import mysql.connector
import json
import os
import smtplib

#conexion a la base de datos mysql para carga del csv
db = mysql.connector.connect(host='localhost',
    user='root',
    passwd='',
    db='bd_ml')
cursor = db.cursor()
cursor.execute("""Truncate table db_list""")
cursor.execute("""Truncate table user_manager""")

with open('user_manager.csv') as f:
    reader = csv.reader(f)
    
    for row in reader:
        cursor.execute("""INSERT INTO user_manager(row_id, user_id, user_state, user_manager)
                          VALUES(%s, %s, %s, %s)
                       """, row)

db.commit()
cursor.close()
print("Tabla User Manager.csv cargada")
print("Cargando Db_list.json")
print("Tabla Db_list.json cargada")
print(" ")
print(" ")
print("Tabla datos_owners")
print("(Classification, Base de datos, Owner_Email, Manager_Email)")

#conexion a la base de datos mysql para carga del json
db = mysql.connector.connect(host='localhost',
    user='root',
    passwd='',
    db='bd_ml')
cursor = db.cursor()

#codigo para serializar el json
class FileItem(dict):
    def __init__(self, fname):
        dict.__init__(self, fname=fname)
        
#carga del archivo json
file = os.path.abspath('dblist.json')
json_data=open(file).read()
json_obj = json.loads(json_data)

#codigo sql para la carga en la base del archivo
sql = """
    INSERT INTO db_list
    (
        dn_name,
        classification_confidentiality,
        classification_integrity,
        classification_availability,
        owner_name,
        owner_uid,
        owner_email,
        time_stamp
    )
    VALUES (
        %s,
        %s,
        %s,
        %s,
        %s,
        %s,
        %s,
        %s
        ) 
    """

for dn_name in json_obj['db_list']:
   
    datosb = (dn_name['dn_name'], dn_name['classification']['confidentiality'], dn_name['classification']['integrity'], dn_name['classification']['availability'], dn_name['owner']['name'], dn_name['owner']['uid'], dn_name['owner']['email'], dn_name['time_stamp'])
    cursor.execute(sql, datosb)

cursor.execute("""DROP TABLE datos_owners""")

#se unen las dos tablas para traer solamente las bases con clasificacion alta 
cursor.execute("""CREATE TABLE `Datos_owners` ( `Classification` VARCHAR(10) NOT NULL DEFAULT 'high' )
SELECT dn_name, owner_email, user_manager
FROM db_list
JOIN user_manager
ON user_manager.user_id = db_list.owner_uid
WHERE db_list.classification_confidentiality = "High" OR db_list.classification_integrity = "High" OR db_list.classification_availability = "High"
""")

#Comienzo del envio de los emails
cursor.execute("SELECT * FROM datos_owners")

myresult = cursor.fetchall()

for x in myresult:
  print(x)
  origen = 'challengecomplianceayelen@gmail.com' #Direccion desde la cual se va a mandar el correo
  co='"' #comillas 
  destino = co+x[3]+co #Direccion de destino se selecciona la columna 3 que tiene el correo
  msg= '\n Buenos dias, se requiere la confirmacion de que las siguientes bases de datos son de clasificacion alta.   Base de datos: %s            Challenge de Ayelen Chaglasian. ' #String que contiene el mensaje
  # Credenciales
  usuario = 'challengecomplianceayelen'
  password = 'Compl1anceIT!'
  # Envío del correo
  server = smtplib.SMTP('smtp.gmail.com:587')
  server.starttls() #Comienza la conexion
  server.login(usuario,password) #Login
  server.sendmail(origen, destino, msg % x[1]) #Envío del mensaje
  server.quit()


print("Tabla datos_owners creada")
print("Enviando correos electrónicos a los managers que se muestran arriba, quienes son responsables de las bases de clasificación alta") 
print("El email fue enviado a los respectivos responsables")

db.commit()
cursor.close()
db.close()
