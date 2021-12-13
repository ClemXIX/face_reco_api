# face_reco_api
A local face recognizer, take an image, and save the faces and add a TAG. Then you can see all stored persons

# Getting Started 

The face-recognition library need to be compiled from c++, so before installing the requirements.txt,  
A compiller need to be setup in the virtual environement, we will use cmake, like it's recommanded in the dlib website  
http://dlib.net/face_recognition.py.html    
  
```pip install cmake```  
`pip install dlib`    

Then the other projets libraries can be installed with   
``pip install -r requirements.txt``
  
## Launching it  
In the folder with the pythons files  
`python main.py` 

go to your webbrowser with http://localhost:8888/