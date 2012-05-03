// JScript 文件
function $() 
{ 
   var elements = new Array(); 
   for (var i = 0; i < arguments.length; i++) 
   { 
     var element = arguments[i]; 
     if (typeof element == 'string') 
       element = document.getElementById(element); 
     if (arguments.length == 1) 
       return element; 
     elements.push(element); 
   } 
   return elements; 
}
//错误图片载入
function errorImg(X) {
	rImg = "Images/Noname.jpg";
	X.src = rImg;
}
function ShowHiden(m){
    if(m.style.display=="none"){
        m.style.display="";
    }else{
        m.style.display="none";
    }
}
