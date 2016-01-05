// linguazone_customizer.config(function($stateProvider, $urlRouterProvider){
// 	$urlRouterProvider.otherwise(function ($injector){
// 		var $state = $injector.get('$state');
// 		$state.go('home');
// 	});
// 	return $stateProvider.state('home', {
// 		url: "/home",
// 		templateUrl: "/assets/home.html"
// 	});
// });

linguazone_customizer.config(function ($stateProvider, $urlRouterProvider, $httpProvider) {

    $urlRouterProvider.otherwise('/home');
    $stateProvider
            .state('home', {
                url: '/home',
                views: {
                    '': {
                        templateProvider: function ($templateFactory) {
                                return $templateFactory.fromUrl('/assets/home.html');
                           
                        }//,
                        // controller: 'LoginCtrl'
                    }
                }
            
            });

    // $httpProvider.interceptors.push('Interceptor');

});

linguazone_customizer.run(['$rootScope', function ($rootScope, $state, Subdomain) {

        $rootScope.$on('$stateChangeSuccess', function (event, to, toParams, from, fromParams) {
            // if (to.name === 'signup-1') {
            //     if (from.name !== 'signup-2') {
            //         delete $localStorage.temp;
            //     }
            // }
        });

        $rootScope.$on('$stateChangeError', function (event, to, toParams, from, fromParams, error, $state) {
            if (error.error === "Your session expired. Please sign in again to continue.") {
                window.location = "#/home";
            }
        });
    }]);

