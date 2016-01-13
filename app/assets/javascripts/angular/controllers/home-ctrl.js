function HomeCtrl ($scope, $state, HomeService, x2js, $filter) {

	convertToXML = function(jsonObject){
		var x2js = new X2JS();
		$scope.xmlString = x2js.json2xml_str(jsonObject);
		$scope.xmlString = vkbeautify.xml($scope.xmlString, 4);
	};
	
	$scope.init = function(){
		$scope.step = 1;
		$scope.heading = 'Step 1: Select a language';
		$scope.heading_description = 'Select a language for activity.';
		$scope.jsonObj = 	{ 
     						xml: {}
						};
		convertToXML($scope.jsonObj);
		var promise = HomeService.getLanguages();
		promise.then(
			function (result) {
				$scope.languages = result;
			}
			, function (reason) {
				alert('Languages cound not be fetched');
			}
		);
	};
	$scope.init();

	function camelize(str) {
		return str.replace(/(?:^\w|[A-Z]|\b\w)/g, function(letter, index) {
			return index == 0 ? letter.toLowerCase() : letter.toUpperCase();
		}).replace(/\s+/g, '');
	}

	$scope.editXML = function(){

		// Include name into XML
		if (typeof($scope.activity_name) !== 'undefined' && $scope.activity_name !== ''){
			var swfString = camelize($scope.activity_name).replace(/\s/g, '');
			var formatString = {format : {_gamename : $scope.activity_name, _gameSWF: swfString}}; 
			$scope.jsonObj["xml"] = formatString;
			convertToXML($scope.jsonObj);
		};

		// Include Description into XML
		if (typeof($scope.description_name) !== 'undefined' && $scope.description_name !== ''){
			$scope.jsonObj["xml"]["description"] = {text : $scope.description_name};
		};

		if (typeof($scope.language) !== 'undefined' && $scope.language !== ''){
			var language = getSpecificLanguage($scope.language);
			$scope.jsonObj["xml"]["language"] = language.name; 
			convertToXML($scope.jsonObj);
		}
		// for (var key in $scope.jsonObj) {
  //            if (key === 'xml') {
  //              console.log($scope.jsonObj[key]);
  //            }
  //       }

	};

	getSpecificLanguage = function(lang_id){
		return $filter('filter')($scope.languages, function (language) {
			return language.id === lang_id;
		})[0];
	};

	$scope.changeText = function(){
		if ($scope.step === 1){
			$scope.heading = 'Step 1: Select a language';
			$scope.heading_description = 'Select a language for activity.';
		}else if($scope.step === 2){
			$scope.heading = 'Step 2: Provide name for activity';
			$scope.heading_description = 'Provide name and description for activity.';
		}else if($scope.step === 3){
			$scope.heading = 'Step 3: Select an activity';
			$scope.heading_description = 'Select an activity to generate XML for.';
		}else if($scope.step === 4){
			$scope.heading = 'Step 4: Provide activity data';
			$scope.heading_description = 'Provide metadata required for activity';
		}
	};
};

lz.controller('HomeCtrl', HomeCtrl);
HomeCtrl.$inject = ['$scope'
				, '$state'
				, 'HomeService'
				, 'x2js'
				, '$filter'];