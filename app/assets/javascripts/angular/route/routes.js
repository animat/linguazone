lz_custom.config(function ($stateProvider, $urlRouterProvider, $httpProvider) {
	$urlRouterProvider.otherwise('/index');
    $stateProvider
    		.state('index', {
    			url: '/index',
    			templateUrl: '/assets/index.html',
    			controller: 'HomeCtrl'
    		});

    		
});