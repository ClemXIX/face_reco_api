<style>
    *{background:#7c777e;}
    .btn{height:75px;width:200px;margin:10px;
    background-color:#194c4d;color:#607a00;
    font-size:large;border:none;}
</style>
<title>Show Image</title>
<div>
 % if faces == 1:
    <h1>Their is {{faces}} face detected in this image</h1>
 % else:
     <h1>Their are {{faces}} faces detected in this image</h1>
 % end
</div>

<div class="im"><img src="./static/image/tmpr.jpeg" alt=""></div>

<div>
<p > <a href="/names">
   <button class="btn">Validate and Continue</button></a>
<a href="/ImgInput">
    <button class="btn" style="background-color:#7f1035" >Return</button></a></p>
</div>