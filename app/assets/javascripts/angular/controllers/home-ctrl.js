function HomeCtrl($scope) {

    $scope.initialize = function () {
        console.log('L')
    };
    $scope.initialize();

}
;

linguazone_customizer.controller('HomeCtrl', HomeCtrl);
    HomeCtrl.$inject = ['$scope'];