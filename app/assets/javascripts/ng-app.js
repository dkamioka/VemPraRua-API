var vemPraRua = angular.module("vemPraRua", ['ngResource', 'analytics', 'google-maps', 'AngularGM'])
	.config(['AnalyticsProvider', function(AnalyticsProvider) {
		AnalyticsProvider.account = 'AIzaSyA9qzGHxiCcbqQP-lwobg-BMDlircBa7Ec';
	}]);

'use strict';

vemPraRua.factory('User',['$resource', function($resource){
	return $resource(app.api + 'users/:id',{id: '@id'},{
			query:{method:'GET', isArray: false}
			});
}]);


vemPraRua.filter('debug', function () {
	return function (name) {
		console.log(name);
		return "";
	}
});


vemPraRua.directive('debug', [function() {
	return {
		restrict: 'E',
		scope: false,
		compile: function compile(tElement, tAttrs, transclude) {
			return {
				pre: function preLink(scope, iElement, iAttrs, controller) {
					iElement.css({
						'-moz-box-shadow': '#000000 0px 0px 10px',
						'-webkit-box-shadow': '#bb0000 0 0 10px',
						'background-color': '#bb0000',
						'border': '2px solid #000000',
						'box-shadow': '#000000 0px 0px 10px',
						'color': '#ffffff',
						'display': 'inline-block',
						'font-family': 'Arial',
						'font-size': '20px',
						'padding': '15px',
						'text-decoration': 'none',
						'position': 'fixed',
						'min-width':'200px',
						'bottom':'30px',
						'right': '5px',
						'z-index': '9999'
					});
				},
				post: function postLink(scope, iElement, iAttrs, controller) { }
			}
		}
	};
}]);
