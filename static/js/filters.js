
app.filter('truncate', function(Data){
	return function(text){
		return text.substring(0, Data.truncationLength) + '...'
	}
});

app.filter('URLify', function(Data){
	return function(name){
		return name.replace(/\s/g, '_')
	}
});