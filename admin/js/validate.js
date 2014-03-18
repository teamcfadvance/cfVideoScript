// JavaScript Document
function validatePassword(form,field,value) {
if (value.length < 6) {
return 0;
}
else {
return 1;
}
}

function checkPasswordsMatch(form,field,value) {
if (value != form.password.value) {
return 0;
}
else {
return 1;
}
}
function WinOpen(url,x,y) { 
        var attributes = "toolbar=no,scrollbars=yes,resizable=no,width=" + x + ",height=" + y; 
        msgWindow=window.open(url,"WinOpen",attributes); 
} 
if ( !WinOpen ){ 
    alert('You must disable your popup blocker for this website to allow you to login!'); 
}
function openPictureWindow_Fever(imageName,imageWidth,imageHeight,alt,posLeft,posTop) {
	newWindow = window.open("","newWindow","width="+imageWidth+",height="+imageHeight+",left="+posLeft+",top="+posTop);
	newWindow.document.open();
	newWindow.document.write('<html><title>'+alt+'</title><body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" onBlur="self.close()">'); 
	newWindow.document.write('<img src='+imageName+' width='+imageWidth+' height='+imageHeight+' alt='+alt+'>'); 
	newWindow.document.write('</body></html>');
	newWindow.document.close();
	newWindow.focus();
}

