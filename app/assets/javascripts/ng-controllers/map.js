vemPraRua.controller('MapCtrl',
	['$scope', 'User', 'Analytics',
	function ($scope, User, Analytics) {
		$scope.position = {
	      coords: {
	        latitude: -23.558362,
	        longitude: -46.635381
	      }
	    };

		/** the initial center of the map */
		$scope.centerProperty = {
			latitude: -23.558362,
			longitude: -46.635381
		};

		/** the initial zoom level of the map */
		$scope.zoomProperty = 14;

		/** list of markers to put in the map */
		$scope.markers = [];
		$scope.users = [];
		var t, inProgress;

		$scope.geolocationAvailable = navigator.geolocation ? true : false;
		$scope.findMe = function () {
			
			if ($scope.geolocationAvailable) {
				
				navigator.geolocation.getCurrentPosition(function (position) {
					
					$scope.center = {
						latitude: position.coords.latitude,
						longitude: position.coords.longitude
					};
					
					$scope.$apply();
				}, function () {
					
				});
			}	
		};

		$scope.loadPins = function () {			
			clearTimeout(t);
			if(inProgress) return;

			inProgress = true
			
			User.query({},function (data) {
				$scope.total = data.total;
				if(data.users) {
					$scope.markers = [];
					$.each(data.users, function (i, user) {
						if(user.status) {
							infoWindow = "<b>" + user.name + ":</b> " + user.status;
						} else {
							infoWindow = "<b>" + user.name + "</b>";
						}
						$scope.markers.push({
								latitude: user.latitude,
								longitude: user.longitude,
								title: user.name,
								infoWindow: infoWindow,
								icon: '/assets/pin.png'
						});
					});
					$scope.refresh = true;
					$scope.findMe();
				}

				inProgress = false;

				t = setTimeout(function () {
					$scope.loadPins();
				},5000);
			});

		};

		$scope.loadPins();	
	}]);
