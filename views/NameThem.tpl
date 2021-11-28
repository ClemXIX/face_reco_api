<style>
    *{background-color: #7c777e;}
    span{color:#7f1035;}
    .btn{height:75px;width:200px;
        margin:10px;font-size:large;border:none;
        background-color:#194c4d;color:#607a00;}
</style>
<title>Name</title>

<h1> Name and Tag </h1>
<br>
<h3> Shows the information of people already recognized</h3>
<h3> but if the person is not recognized, indicate the associated tag and name</h3>
<br>
<br>
<br>
% import os
% import face_recognition as fr
% from PIL import Image
% import io
% import base64
% import sqlite3
% import fct
% import numpy as np

%    path = './static/image/tmp.jpeg'
%    img_input = fr.load_image_file(path)
%    group_faces = fr.face_locations(img_input)
%    faces = len(group_faces)
%
%   conn = sqlite3.connect('db.db')
%   c = conn.cursor()
%   r = """SELECT Client_Name, tag, photo FROM CLIENTS"""
%   c.execute(r)
%   rows = c.fetchall()
%
%   all_name = []
%   all_tag = []
%   all_photo = []
%
% for row in rows:
    % all_name.append(row[0])
    % all_tag.append(row[1])
    % all_photo.append(row[2])
% image_compare = list(zip(all_name, all_tag, all_photo))
% end

<form action="/names" method="post">

% for face_location in group_faces:
%     top, right, bottom, left = face_location
%     face_image = img_input[top:bottom, left:right]
%     face_encode = fr.face_encodings(img_input,[face_location])[0]
    % for name, tag, photo in image_compare:
        % face_db = fct.base64_to_image(photo)
        % face_db = np.array(face_db)
        % face_db_encod = fr.face_encodings(face_db)[0]
        % result = fr.compare_faces([face_encode], face_db_encod)
        % if result[0] == True:
            % pil_image = Image.fromarray(face_image)
            % pil_image = pil_image.resize(size=(150,150))
            % img_sql = fct.img_to_base64_str(pil_image)
            <div>
            <img src="data:image/png;base64,{{img_sql}} "  alt="">
            Name :<span id="n">{{name}}</span> & Tag : <span id="t">{{tag}}</span>
            <img src="data:image/png;base64,{{photo}} "  alt="">
            </div>
            % break
        % elif (name, tag, photo) == image_compare[-1]:
                % if result[0] != True:
                    % pil_image = Image.fromarray(face_image)
                    % pil_image = pil_image.resize(size=(150, 150))
                    % img_sql = fct.img_to_base64_str(pil_image)
                    <div>
                    <img src="data:image/png;base64,{{img_sql}} "  alt="">
                    Name :
                    <input type="text" name="name"  required>
                    Tag :
                    <input type="text" name="tag"  required>
                    <input hidden type="text" name="img_s" value="{{img_sql}}" >
                    </div>

       % end
    % end
 % end


% end

<input class="btn" type="submit" value="Validate" >
</form>
