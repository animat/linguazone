lz.config(function ($stateProvider, $urlRouterProvider, $httpProvider) {
	$urlRouterProvider.otherwise('/index');
    $stateProvider
    	.state('index', {
    			url: '/index',
    			templateUrl: '/assets/index.html',
    		})
    	.state('add-game', {
    		url: '/add-game',
    		templateUrl: '/assets/add-game.html',
    		controller: 'GameCtrl'
    	})
    ;
});