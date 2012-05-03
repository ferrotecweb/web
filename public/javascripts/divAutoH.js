window.onload=window.onresize=function(){
    m=document.getElementById("colmm");
    m1=document.getElementById("colm1");
    m2=document.getElementById("colm2");
    alert(document.getElementById("colm2").style.height);
    if(m1.style.height<m.style.height || m2.style.height<m.style.height){
        m1.style.height=m2.style.height=m.offsetHeight+"px";
    }
}
