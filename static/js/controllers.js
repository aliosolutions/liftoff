

function ArtistCtrl($scope, $http, $routeParams){
	var DAY = 86400000;
	$http.get('/artist/' + $routeParams.id).success(function(data){
		$scope.artist = data;
		//calculate each show's days till liftoff and percentage funded.
		for(var i in $scope.artist.shows){
			var show = $scope.artist.shows[i];
			show.percent = Math.floor(show.ticketsSold / show.ticketsGoal) * 100;
			show.daysLeft = Math.ceil((new Date(show.liftoffDate) - Date.now()) / DAY);
			if(show.daysLeft < 0) show.daysLeft = 0;
		}
	});

	$scope.selectedShow = {};
	$scope.selectedArtist = {}
	$scope.order = {
		quantity: 1
	}
	$scope.openInfo = function(show, artist){
		$scope.selectedShow = show;
		$scope.selectedArtist = artist;
		$('#infoModal').modal();
	} 
	$scope.openPayment = function(){
		$('#infoModal').modal('hide');
		console.log("Show price: " + $scope.selectedShow.price + ", artist name: " + $scope.selectedArtist.name);
		var token = function(res){
			//pack everything up neatly into $scope.order
			$scope.order.city = $scope.selectedShow.city;
			$scope.order.artist = $scope.selectedArtist.name;
			$scope.order.token = res;
			$scope.order.amount = $scope.selectedShow.price * $scope.order.quantity;
			$scope.placeOrder();
		}
		var show = $scope.selectedShow;
		var artist = $scope.selectedArtist;
		var order = $scope.order;
		StripeCheckout.open({
			key:         'pk_test_rNLU0zbXW71NwhRENYPYXmUi',
	        amount:      show.price * order.quantity,
	        name:        artist.name,
	        description: "" + order.quantity + " ticket(s)($" + show.price / 100 + " each) to show in " + show.city,
	        panelLabel:  'Buy ' + order.quantity + ' ticket(s)',
	        token:       token
		});
	}
	$scope.placeOrder = function(){
		console.log("Placing order");
		console.log($scope.order);
		$http.put('/artist/' + $routeParams.id, $scope.order).success(function(){
			alert("Your order has been placed. Thank you!"); //redirection to real receipt page goes here.
		});
	}
}
