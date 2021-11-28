
<style>
    *{background:#7c777e;}

    #v{height:75px;width:100px;margin:10px;
    background-color:#194c4d;color:#607a00;}

    #btn{height:50px;width:90px;margin:10px;
    background-color:#7f1035;}

    #i{color:#7f1035;font-size:2em;}
</style>

<title>Image selection</title>

<body>
   <h1 align="center">Select an Image</h1>

   <form action="/ImgInput" method="post" enctype="multipart/form-data">
        jpeg, png or jpg image : <input name="img" type="file" accept=".jpeg, .png, .jpg" id=i>
        <br>
        <input value="Validate" type="submit" id="v" />
   </form>


   <p> <a href="/">
   <button id="btn">Return</button>
   </a> </p>
</body>