var app = angular.module('liftoff', []);


app.config(['$routeProvider', function($routeProvider){
	$routeProvider.when('/artist/:id', {templateUrl: 'partials/artistpage.html', controller: ArtistCtrl});

	$routeProvider.otherwise({redirectTo: '/404'});
}]);


