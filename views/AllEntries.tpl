<title>All entries</title>
<style>
*{background-color: #7c777e;}
.btn{height:75px;width:200px;
        margin:10px;font-size:x-large;
        background-color:#194c4d;color:#607a00;}
</style>

<div>
<a href="/"/>
<button class="btn">Home</button></a></div>
<h1> All entries</h1>


% for r in result:
    <div>
    % for i in r:
        % if i != r[-1]:
          {{i}}
        % else:
            <img src="data:image/png;base64,{{i}} "  alt="">
    </div>
% end

