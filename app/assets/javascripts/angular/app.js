var lz_custom = angular.module('lz_custom', [
				'ui.router',
            	'ui.bootstrap'
    			]);

lz_custom.config(["$httpProvider", function ($httpProvider) {
        csrfToken = $('meta[name=csrf-token]').attr('content');
        $httpProvider.defaults.headers.post['X-CSRF-Token'] = csrfToken;
        $httpProvider.defaults.headers.put['X-CSRF-Token'] = csrfToken;
        $httpProvider.defaults.headers.patch['X-CSRF-Token'] = csrfToken;
    }]);