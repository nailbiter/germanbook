var dataendon = "data-endon";
var endsymbol = "eof"
function numOfIds(){ 
	var spans = document.getElementsByTagName("span");
	var maxId = 0;
	for ( var i = 0; i < spans.length; i++)
		if(spans[i].getAttribute(dataendon)!=null)
		{
			maxId = Math.max(maxId,Number(spans[i].id))
		}
	return maxId;
}
function cleanAllHighlights()
{
	var spans = document.getElementsByTagName("span");
	var count = 0;
	for ( var i = 0; i < spans.length; i++)
		if(spans[i].getAttribute(dataendon)!=null)
		{
			count++;
			spans[i].style.background = "";
		}
	console.warn("cleanAllHighlights");
}
function cb(x)
{
	cleanAllHighlights();
	var elem = document.getElementById(x);
    elem.scrollIntoView(true);
	if(elem==null)
		return endsymbol;

	elem.style.background = "yellow";
	return elem.getAttribute(dataendon);
}
