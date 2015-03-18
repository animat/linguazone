/*jslint nomen: true */
/*global
 alert: true,
 $: true,
 lgzRec: true,
 navigator: true,
 FWRecorder: true,
 swfobject: true,
 window: true,
 console: true
*/


$(function () {
    'use strict';
    var response, RECORDER_APP_ID,
        appWidth, appHeight, flashvars, params, attributes;
  
    RECORDER_APP_ID = "recorderApp";
  
    //var $level = $('.level .progress');

    appWidth = 5;
    appHeight = 5;
    //flashvars = {'upload_image': '/assets/waverec/upload.png'};
	flashvars = {};
    params = {};
    attributes = {'id': RECORDER_APP_ID, 'name': RECORDER_APP_ID};
    swfobject.embedSWF("/swfs/audio-recorder.swf", "lgzRecorderFlashDiv", appWidth, appHeight, "11.0.0", "", flashvars, params, attributes);
	
    window.fwr_event_handler = function fwr_event_handler() {
        var name, $controls, mic, ts;
        // console.log('fwr_event_handler: ' + arguments[0]);
        switch (arguments[0]) {
        case "ready":
            // lgzRec.delayedinit();
            FWRecorder.uploadFormId = "#uploadForm";
            FWRecorder.uploadFieldName = "upload_file[filename]";
            FWRecorder.connect(RECORDER_APP_ID, 0);
            FWRecorder.recorderOriginalWidth = appWidth;
            FWRecorder.recorderOriginalHeight = appHeight;
            // console.log('check mic');
            break;

        case "microphone_user_request":
            FWRecorder.showPermissionWindow();
            break;

        case "permission_panel_closed":
            lgzRec.hideWinPerm();
            FWRecorder.defaultSize();

            if (FWRecorder.isMicrophoneAccessible()) {
                //ivanixcu: last
                lgzRec.doAction('start-recording');
            }
            break;
        case "recording":
            FWRecorder.hide();
            FWRecorder.observeLevel();
            break;
        case "recording_stopped":
            console.log('recording stopped:');
            FWRecorder.stopObservingLevel();
            break;
        case "observing_level_stopped":
            console.log('observing_level_stopped: recstop()');
            lgzRec.display.recStop();
            break;

        case "microphone_level":
            // console.log('microphone_level: ' + arguments[1]);
            lgzRec.display.levelRec(arguments[1] * 100);
            // $level.css({height: arguments[1] * 100 + '%'});
            break;

        case "save_pressed":
            FWRecorder.updateForm();
            break;

        case "saving":
            name = arguments[1];
            console.info('saving started', name);
            break;

        case "saved":
            name = arguments[1];
            response = arguments[2];
            console.info('saving success', name, response);
            break;

        case "save_failed":
            name = arguments[1];
            var errorMessage = arguments[2];
            console.info('saving failed', name, errorMessage);
            break;

        case "save_progress":
            name = arguments[1];
            var bytesLoaded = arguments[2];
            var bytesTotal = arguments[3];
            console.info('saving progress', name, bytesLoaded, '/', bytesTotal);
            break;

        case "playback_started":
            console.log('playback_started');
            break;

        case "stopped":
            console.log('playback_stopped');
            lgzRec.btn.className = 'start-playback';
            lgzRec.display.playStop();
            break;

        }
    };

    function recorderEl() {
        return $('#' + RECORDER_APP_ID);
    }

});
