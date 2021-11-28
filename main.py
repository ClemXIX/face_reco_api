from bottle import run, route, install, static_file, template, request, post, get, error, view
from bottle_sqlite import SQLitePlugin
import os
from PIL import Image
import face_recognition
import sqlite3
import fct

install(SQLitePlugin(dbfile='db.db'))


@error(404)
def error404(error):
    return '<title>404</title> <style>*{background-color: #7c777e;} </style>' \
           '<center><h1>Wrong url</h1></center>' \
           '<center><p><img src="./static/image/loupee.png" alt="404"></p></center>'


try:
    # connection to the database, well named "db"  (っ▀¯▀)つ
    connection = sqlite3.connect('db.db')

    # now python can talk in SQL
    cursor = connection.cursor()

    # creation of the CLIENTS table with their name, tag, and the face's image
    cursor.execute('''CREATE TABLE CLIENTS (
                       Client_Name TEXT NOT NULL,
                       tag TEXT NOT NULL,
                       photo BLOB NOT NULL)''')

    # one row in the database, so first convert the img to str then add it
    thor = Image.open('./static/image/thor.jpeg')
    thor_in_db = fct.img_to_base64_str(thor)

    spidy = Image.open('./static/image/spidy.jpeg')
    spidy_in_db = fct.img_to_base64_str(spidy)

    avengers = [('Thor', 'Hero', thor_in_db),
                ('Spidy', 'Hero', spidy_in_db)]

    cursor.executemany("INSERT INTO CLIENTS VALUES (?, ?, ?)", avengers)

    connection.commit()
    connection.close()

except sqlite3.Error as error:
    print(error)


@route('/static/image/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='static/image')


@route('/')
def home():
    return template('index')


@get('/ImgInput')
def form_img():
    return template('ImageInput')


@post('/ImgInput')
def show_img():
    # path for image input, and imageResized for display
    path = './static/image/tmp.jpeg'
    pathr = './static/image/tmpr.jpeg'

    # retrieve image from form
    img = request.files.get('img')

    # check existing image and rewrite over it, like this the server will never be full
    if os.path.exists(path):
        os.remove(path)
    img.save(path)

    # resize the max size of image if it's too large
    # and check if path already exist
    if os.path.exists(pathr):
        os.remove(pathr)

    img = Image.open(path)
    if img.size > (700, 700):
        img.resize((1024, 764)).save(pathr)
    else:
        img.save(pathr)

    # count and output the number of face detected
    img = face_recognition.load_image_file(path)
    face_locations = face_recognition.face_locations(img)
    faces = len(face_locations)

    return template('ImageDisplay', faces=faces)


@get('/names')
def names():
    return template('NameThem')


@post('/names')
def valide():
    im_name = request.forms.getall('name')
    tags = request.forms.getall('tag')
    img_s = request.forms.getall('img_s')
    ziip = zip(im_name, tags, img_s)

    conn = sqlite3.connect('db.db')
    c = conn.cursor()
    c.executemany("INSERT INTO CLIENTS (Client_Name, tag, photo) VALUES (?,?,?)",
                  tuple(zip(im_name, tags, img_s)))
    conn.commit()
    conn.close()
    return template('NameShow', ziip=ziip)


@route('/DataBase')
def d():
    c = connection.cursor()
    c.execute("SELECT Client_Name, tag, photo FROM CLIENTS")
    result = c.fetchall()
    return template('AllEntries', result=result)


run(host='localhost', port=8080)
