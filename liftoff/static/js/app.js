angular.module('app', [])
	.config(function($routeProvider){
		$routeProvider.
		when('/', {controller: AppCtrl, templateUrl: 'index.html'})
	});

function AppCtrl($scope){
	$scope.foo = 'bar';
}