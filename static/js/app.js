var app = angular.module('liftoff', []);


app.config(['$routeProvider', function($routeProvider){
	$routeProvider.when('/artist', {templateUrl: 'partials/artistpage.html'});

	$routeProvider.otherwise({redirectTo: '/404'});
}]);


