var app = angular.module('liftoff', []);


app.config(['$routeProvider', function($routeProvider){
	$routeProvider.when('/artist/:id', {templateUrl: 'partials/artistpage.html', controller: ArtistCtrl});
	$routeProvider.when('/contact', {templateUrl: 'partials/contact.html', controller: ContactCtrl});
	$routeProvider.when('/admin', {templateUrl: 'partials/admin.html', controller: AdminCtrl});

	$routeProvider.otherwise({redirectTo: '/404'});
}]);


