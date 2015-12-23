linguazone_customizer.config(function($stateProvider, $urlRouterProvider){
	$urlRouterProvider.otherwise("home");
	return $stateProvider.state('home', {
		url: "/home",
		templateUrl: "/assets/home.html"
	});
});