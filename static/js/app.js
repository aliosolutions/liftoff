var app = angular.module('liftoff', []);


app.config(function($routeProvider){
	$routeProvider.when('/', {templateUrl: 'artistpage.html'});
});


