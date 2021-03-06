var app = angular.module('liftoff', []);


app.config(['$routeProvider', function($routeProvider){
	$routeProvider.when('/', {templateUrl: 'partials/landing.html', controller: LandingCtrl});
	$routeProvider.when('/a/:name', {templateUrl: 'partials/artistpage.html', controller: ArtistCtrl})
	$routeProvider.when('/about', {templateUrl: 'partials/landing.html', controller: LandingCtrl});
	$routeProvider.when('/artist/:id', {templateUrl: 'partials/artistpage.html', controller: ArtistCtrl});
	$routeProvider.when('/contact', {templateUrl: 'partials/contact.html', controller: ContactCtrl});
	$routeProvider.when('/admin', {templateUrl: 'partials/admin.html', controller: AdminCtrl});
	$routeProvider.when('/confirm', {templateUrl: 'partials/confirm.html', controller: ConfirmCtrl});
	$routeProvider.when('/discover', {templateUrl: 'partials/discovery.html', controller: DiscoveryCtrl});
	$routeProvider.when('/404', {templateUrl: 'partials/404.html', controller: NotFoundCtrl});

	$routeProvider.otherwise({redirectTo: '/404'});
}]);


