

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


	
	$scope.shows = [testShow, otherShow]
}
