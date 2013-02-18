

function ArtistCtrl($scope){
	$scope.artist = {
		name: 'Justin and The Goughs',
		description: "Triple threat musician, comedian, entrepreneur Justin Gough. See his unforgettable one-man show.",
		pic: "http://placehold.it/640x480"
	};

	var testShow = {
		city: "Seattle",
		tix: {
			sold: 30,
			goal: 50
		},
		percent: Math.floor(100 * 30 / 50),
		daysLeft: 4
	};
	var otherShow = {
		tix: {
			sold: 20,
			goal: 60
		},
		percent: Math.floor(100 * 20 / 60),
		city: "San Francisco",
		daysLeft: 4
	};
	var oneMoreShow = {
		tix: {
			sold: 45,
			goal: 300
		},
		percent: Math.floor(100 * 45 / 300),
		city: "Portland",
		daysLeft: 4,
		price: 8000
	};
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
			key:         'pk_test_czwzkTp2tactuLOEOqbMTRzG',
	        amount:      show.price * order.quantity,
	        name:        artist.name,
	        description: "" + order.quantity + " ticket(s)($" + show.price / 100 + " each) to show in " + show.city,
	        panelLabel:  'Buy ticket(s)',
	        token:       token
		});
	}
	$scope.placeOrder = function(){
		console.log("Placing order");
		console.log($scope.order)
	}

	$scope.shows = [testShow, otherShow, oneMoreShow]
}
