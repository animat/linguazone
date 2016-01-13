lz.factory("HomeService", function ($http, $q) {
    return {
        getLanguages: function () {
            var url = "/api/v3/about/get_languages";
            var defer = $q.defer();
            $http({
                method: 'GET',
                url: url
            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {
                defer.reject(data);
            });
            return defer.promise;
        },
        getActivities: function () {
            var url = "/api/v3/about/get_activities";
            var defer = $q.defer();
            $http({
                method: 'GET',
                url: url
            }).success(function (data, status, header, config) {
                defer.resolve(data);
            }).error(function (data, status, header, config) {
                defer.reject(data);
            });
            return defer.promise;
        }
    };
});