<title>Summary</title>
<style>
*{background-color: #7c777e;}
.btn{height:75px;width:200px;
        margin:10px;font-size:x-large;
        background-color:#194c4d;color:#607a00;}
</style>

<h1> Summary</h1>
<div>
<a href="/"/>
<button class="btn">Home</button></a></div>

% for i in ziip:
    <div>
    % for x in i:
        % if x != i[-1]:
            {{x}}
        % else:
            <img src="data:image/png;base64,{{x}} "  alt="">
            </div>
% end

