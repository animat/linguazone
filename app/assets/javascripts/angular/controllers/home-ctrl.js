function HomeCtrl ($scope, $state, HomeService, x2js, $filter) {

	convertToXML = function(jsonObject){
		var x2js = new X2JS();
		$scope.xmlString = x2js.json2xml_str(jsonObject);
		$scope.xmlString = vkbeautify.xml($scope.xmlString, 4);
	};
	
	$scope.init = function(){
		$scope.activity_name = '';
		$scope.activity_swf = '';
		$scope.step = 'language';
		$scope.heading = 'Select a language';
		$scope.heading_description = 'Select a language for your activity.';
		$scope.metaData = [{question: '', response: ''}];
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

        
		var promise = HomeService.getActivities();
		promise.then(
			function (result) {
				$scope.activities = result;
			}
			, function (reason) {
				alert('Languages cound not be fetched');
			}
		);
	};
	$scope.init();

	$scope.editXML = function(){

		// Include name into XML
		if (typeof($scope.activity_name) !== 'undefined' && $scope.activity_name !== ''){
			var formatString = {format : {_gamename : $scope.activity_name, _gameSWF: $scope.activity_swf}}; 
			$scope.jsonObj["xml"] = formatString;
			convertToXML($scope.jsonObj);
		};

		// Include Description into XML
		if (typeof($scope.description_name) !== 'undefined' && $scope.description_name !== ''){
			$scope.jsonObj["xml"]["description"] = {text : $scope.description_name};
		};

		// Include Q/A to XML metadara
		if ($scope.metaData[0].question !== '' && $scope.metaData[0].response !== ''){
			nodeArray = [];
			for (var i=0; i < $scope.metaData.length; i++){
				if ($scope.metaData[i].question !== '' && $scope.metaData[i].response !== ''){
					nodeArray.push(
						{
							question: {
							_content: $scope.metaData[i].question, _name: getSpecificLanguage($scope.language).name, _type: 'text'},
							response: {
								_content: $scope.metaData[i].response, _name: 'lang', _type: 'text' 
							}
						}
					);
				}
			}
			$scope.jsonObj["xml"]["gamedata"] = {};
			$scope.jsonObj["xml"]["gamedata"]["node"] = nodeArray;
			convertToXML($scope.jsonObj);
		}

		if (typeof($scope.language) !== 'undefined' && $scope.language !== ''){
			var language = getSpecificLanguage($scope.language);
			$scope.jsonObj["xml"]["language"] = language.name; 
			convertToXML($scope.jsonObj);
		}
	};

	$scope.addMetaToXML = function(meta_to_add){

	}

	getSpecificLanguage = function(lang_id){
		return $filter('filter')($scope.languages, function (language) {
			return language.id === lang_id;
		})[0];
	};

	$scope.changeText = function(current_step, new_step_number){
		if ($scope.validate_forms(current_step)){
			$scope.step = new_step_number;
			if ($scope.step === 'language'){
				$scope.heading = 'Select a language';
				$scope.heading_description = 'Select a language for your activity';
			}else if($scope.step === 1){
				$scope.heading = 'Step 1: Select an activity';
				$scope.heading_description = 'Select an activity to generate XML for';
			}else if($scope.step === 2){
				$scope.heading = 'Step 2: Provide activity data';
				$scope.heading_description = 'Provide data for your activity';
			}else if($scope.step === 3){
				$scope.heading = 'Step 3: Describe your activity';
				$scope.heading_description = 'Enter information about your activity';
			}
		}
	};

	$scope.leapFrog = function(activity_name){
		if(activity_name.swf == 'leapFrog'){
			$scope.activity_name = activity_name.name;
			$scope.activity_swf = activity_name.swf;
			$scope.editXML();
			$scope.changeText(1,2);
		}
	};

	validateGameData = function(index){
		if ($scope.metaData[index].question !== '' && $scope.metaData[index].response !== ''){
			$('#QA_warning_'+index).hide();
		}else{
			$('#QA_warning_'+index).show();
			return false;
		}
		return true;
	}

	$scope.addToMeta = function(index){
		if (validateGameData(index)){
			$scope.editXML();
			$scope.metaData.splice(index+1, 0, {question: '', response: ''});
		}
	};

	$scope.removeFromMeta = function(index){
		$scope.metaData.splice(index,1);
		// if($scope.metaData.length > 1 && validateGameData()){
		// 	$scope.editXML();
		// 	$scope.metaData.pop();
		// }
	};

	$scope.submit = function(){
		alert('Success');
	};

	$scope.validate_forms = function(step_number){
		switch(step_number){
			case 'language':
				if (typeof($scope.language) === 'undefined' || $scope.language === ''){
					$('#language_warning').show();
					return false;
				}else{
					$('#language_warning').hide();
				}
				break;
			case 2:
				if (!validateGameData()){
					return false;
				}
				break;
			case 3:
				if (typeof($scope.description_name) === 'undefined' || $scope.description_name === ''){
					$('#description_warning').show();
					return false;
				}else{
					$('#description_warning').hide();
				}
				break;
			default:
		}
		return true;
	};
};

lz.controller('HomeCtrl', HomeCtrl);
HomeCtrl.$inject = ['$scope'
				, '$state'
				, 'HomeService'
				, 'x2js'
				, '$filter'];