var lz = angular.module('lz', [
				'ui.router',
            	'ui.bootstrap',
            	'cb.x2js'
    			]);

lz.config(["$httpProvider", function ($httpProvider) {
        csrfToken = $('meta[name=csrf-token]').attr('content');
        $httpProvider.defaults.headers.post['X-CSRF-Token'] = csrfToken;
        $httpProvider.defaults.headers.put['X-CSRF-Token'] = csrfToken;
        $httpProvider.defaults.headers.patch['X-CSRF-Token'] = csrfToken;
    }]);