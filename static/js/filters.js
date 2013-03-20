
app.filter('truncate', function(Data){
	return function(text){
		console.log("Truncation filter")
		return text.substring(0, Data.truncationLength) + '...'
	}
});