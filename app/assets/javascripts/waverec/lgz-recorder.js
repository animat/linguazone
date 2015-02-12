/*jslint nomen: true */
/*global
 alert: true,
 $: true,
 navigator: true,
 FormData: true,
 FWRecorder: true,
 window: true,
 console: true
*/
// navigator.mimeTypes['application/x-shockwave-flash']
var lgzRec = {};

//note: g for debugging only
var g = {};
lgzRec.ClassDisplay = function () {
    'use strict';
    var thisObj, $canvas, canvas, level, ctx, slider, timeArr, timeloc,
        mouse, color, font, blink, modePlay, $btnRedo, $overlay, timew;
    thisObj = this;
    modePlay = false;
    $btnRedo =  $('#lgzBtnRedo');
    $canvas  =  $('#lgzRecCanvas');
    canvas = $canvas[0];
    ctx = canvas.getContext('2d');
    g.ctx = ctx;
    g.canvas = canvas;
    font =  {};
    // font.size = 21 @ canvas.height = 100px
    font.size = Math.round(canvas.height / 5);
    font.family = 'sans-serif';
    font.hh = Math.round(font.size / 2);
    color =  {};
    color.clr = '#0066cc';
    color.bg  = '#0066cc';
    color.fg  = '#66ccff';
    color.active = '#00ffff';
    color.rec = '#cc0000';

    g.color = color;

    ctx.strokeStyle = color.fg;
    ctx.font = font.size + 'px ' + font.family;

    mouse =  {};
    mouse.move = 0;
    mouse.drag = false;
    mouse.pct = 0;
    mouse.playCont = false;

    thisObj.vuArr = [];


    slider =  {};
    slider.thumbw = 15;
    slider.thumbww = 7;
    slider.thumbh = 20;

    slider.x1 = 5;
    slider.x2 = canvas.width - (2 * slider.x1);

    slider.y = (4 * canvas.height / 7) |0;
    slider.y2 = slider.thumbh + 4;
    slider.y1 = slider.y - Math.floor(slider.y2 / 2);

    slider.thumbx = slider.x1;
    slider.thumby = slider.y - (slider.thumbh/2|0);
    slider.pctRatio = (slider.x2 - (slider.thumbw)) / 100;
    slider.pos = 0;

    g.slider = slider;

    level =  {};

    level.fpsMax = 25;
    level.fpsDelay =  (1000/ level.fpsMax) | 0;


    level.x1 = 5;
    level.y1 = 5;
    level.padx = 2;
    level.pady = 2;
    level.x2 = canvas.width - (2 * level.x1);
    level.y2 = Math.floor((canvas.height / 2)) - Math.floor(slider.y2 / 2)
        - (2 * level.y1);
    level.pctRatio = ((level.x2 - (2 * level.padx)) / 100);

    

    g.level = level;
	
    timew =  Math.round(ctx.measureText('99:99:99').width);

    timeArr = [];
    timeloc  = {};
    timeloc.tx = 5;
    timeloc.ty = canvas.height - 5;
    timeloc.x1 = timeloc.tx - 2;
    timeloc.y1 = timeloc.ty - font.size + 2;
    timeloc.x2 = timew + 4;
    timeloc.y2 = font.size;
    timeloc.ts = 0;
    timeArr.push(timeloc);

    timeloc  = {};
    timeloc.tx =  canvas.width - Math.round(ctx.measureText('99:99:99').width) - 5;
    timeloc.ty = canvas.height - 5;
    timeloc.x1 = timeloc.tx - 2;
    timeloc.y1 = timeloc.ty - font.size + 2;
    timeloc.x2 = timew + 4;
    timeloc.y2 = font.size;
    timeloc.ts = 0;
    timeArr.push(timeloc);

    /*
     * hardcoded values assume 
     * canvas dim of 500x150
     */


    thisObj.write = function (text, fg) {
        var x, y, w, h;

        h = font.size;
        w = Math.round(ctx.measureText(text).width);
        x = (canvas.width - w)/2|0;
        y = (canvas.height + h ) /2|0;
        thisObj.clearRect(0, y - h, canvas.width, h);
        if (fg) {
            ctx.fillStyle = fg;
        }
        ctx.fillText(text, x, y);
        if (fg) {
            ctx.fillStyle = color.fg;
        }
    };
    thisObj.clearRect = function (x, y, w, h) {
        ctx.fillStyle = color.clr;
        ctx.fillRect(x, y, w, h);
        ctx.fillStyle = color.fg;
    };
    thisObj.clear = function () {
            thisObj.clearRect(0, 0, canvas.width, canvas.height);
    };
    thisObj.fmtTimeMsAsHHMMSS = function (msecs) {
        var t, s, secs;
        secs = Math.floor(msecs / 1000);
        t = new Date(1970, 0, 1);
        t.setSeconds(secs);
        s = t.toTimeString().substr(0, 8);
        if (secs > 86399) {
            s = Math.floor((t - Date.parse("1/1/70")) / 3600000) + s.substr(2);
        }
        return s;
    };
    thisObj.fmtTimeSecsAsHHMMSS = function (secs) {
        var t, s;
        t = new Date(1970, 0, 1);
        t.setSeconds(secs);
        s = t.toTimeString().substr(0, 8);
        if (secs > 86399) {
            s = Math.floor((t - Date.parse("1/1/70")) / 3600000) + s.substr(2);
        }
        return s;
    };
    thisObj.sliderThumbDraw = function (pct) {
        slider.pct = pct;
        slider.pos = slider.thumbx + Math.floor(slider.pctRatio * pct);
        if (mouse.drag) {
            ctx.fillStyle = color.active;
            ctx.fillRect(slider.pos, slider.thumby, slider.thumbw, slider.thumbh);
            ctx.fillStyle = color.fg;
            mouse.pct = pct;
        } else {
            ctx.fillRect(slider.pos, slider.thumby, slider.thumbw, slider.thumbh);
        }
    };
    thisObj.sliderDraw = function (pct) {
        var timeLapse;
        // pct = Math.floor(rawpct);
        if (pct < 0) {
            pct = 0;
        }
        if (pct > 100) {
            pct = 100;
        }
        // thisObj.clearRect(slider.x1, slider.y1, slider.x2, slider.y2);
        ctx.fillStyle = color.bg;
        ctx.fillRect(slider.x1, slider.y1, slider.x2, slider.y2);
        ctx.fillStyle = color.fg;

        ctx.fillRect(slider.x1, slider.y, slider.x2, 2);
        thisObj.sliderThumbDraw(pct);

        /*
         * set timeLapse to 2 decimal places, 
         * at 3 or more, FWRecord.playBackFrom('audio',starTime) will go haywire
         */
         // thisObj.timeLapse = (((timeLapseMS / 10)|0)/100);
         
        thisObj.sliderPct = pct;
        timeLapse = (pct * thisObj.dur / 100);
        thisObj.timeDraw(timeLapse, 0);

    };
    thisObj.sliderPlay = function () {
        var pct, ds, idx, rec;

        if (thisObj.playCont) {
            ds = FWRecorder.getCurrentTime('audio');
        } else {
            ds = thisObj.dur;
        }
        pct = Math.floor(10000 * ds / thisObj.dur) / 100;
        thisObj.sliderDraw(pct);

        idx = Math.round(pct * thisObj.vuArr.length / 100);
        /*
        console.debug('sliderPlay: '
            + ' dmax=' + dmax
            + ' ds=' + ds
            + ' pct=' + pct
            + ' idx=' + idx
            );
        */
        if (idx > thisObj.lastIdx) {
            idx = thisObj.lastIdx;
        }
        rec = thisObj.vuArr[idx];

        thisObj.levelDraw(rec.level);
    };
    thisObj.timeDraw = function (time, pos) {
        var ftime, timeloc, w;
        timeloc = timeArr[pos];
        timeloc.ts = time;

        ftime = thisObj.fmtTimeSecsAsHHMMSS(time);
        //w = Math.round(ctx.measureText(ftime).width);

        ctx.fillStyle = color.bg;
        //ctx.fillRect(timeloc.x1, timeloc.y1, w, timeloc.y2);
        ctx.fillRect(timeloc.x1, timeloc.y1, timeloc.x2, timeloc.y2);
        ctx.fillStyle = color.fg;

        ctx.fillText(ftime, timeloc.tx, timeloc.ty);
    };
    thisObj.levelDraw = function (pct) {
        var plevel;
        plevel = (pct * level.pctRatio)|0;
        thisObj.clearRect(level.x1, level.y1, level.x2, level.y2);
        ctx.rect(level.x1, level.y1, level.x2, level.y2);
        ctx.stroke();
        if (pct) {
            ctx.fillRect(level.x1 + level.padx, level.y1 + level.pady, plevel, level.y2 - 2 * level.pady);
        }

    };
    thisObj.recStatusBlink = function () {
        var mod, bin, orig;

        blink += 1;
        
        mod =  (blink % (1 +  level.fpsMax / 4 |0));
        if (mod) {
            return;
        }
        bin = blink % 2;
        orig = ctx.fillStyle;
        if (bin) {
            thisObj.write('RECORDING', color.rec);
        } else {
            //thisObj.write('');
        }
        ctx.fillStyle = orig;


    };
    thisObj.levelRec = function (rawlevel) {
        var rec, newtime, dur, intLevel, curLen;

        newtime = new Date();
        if (!thisObj.timeInit) {
            thisObj.timeInit = newtime;
            thisObj.timeLast = thisObj.timeInit;
        }
        dur =  newtime - thisObj.timeLast;

        // @100, save only 5 samples per second
        //
        if (dur < level.fpsDelay) {
            return;
        }
        // thisObj.recStatusBlink();
        intLevel = Math.floor(rawlevel);
        thisObj.levelDraw(intLevel);

        curLen = (newtime - thisObj.timeInit) / 1000;
        thisObj.timeDraw(curLen, 0);
        rec = {};
        rec.level = intLevel;
        rec.ts = newtime;
        rec.dur = dur;
        thisObj.timeLast = newtime;
        thisObj.vuArr.push(rec);
        g.vuArr = thisObj.vuArr;
    };
    thisObj.recInit = function (level) {
        // console.debug('recInit');
        blink = 0;
        thisObj.clear();
        thisObj.write('RECORDING', color.active);
        thisObj.vuArr = [];
        /*
        thisObj.timeInit = new Date();
        thisObj.timeLast = thisObj.timeInit;
        */
        thisObj.timeInit = 0;
        thisObj.timeLast = thisObj.timeInit;
    };
    thisObj.recStop = function (level) {
        var ts;
        // console.debug('recStop');
        ts = new Date();
        window.setTimeout(function () {
            thisObj.levelRec(0);
            thisObj.sliderInit();
        }, 100);
        $btnRedo.css('visibility', 'visible');
        if (lgzRec.send) {
            window.setTimeout(function () {
                lgzRec.levelRec(0);
            }, 100);
        }
    };
    thisObj.playLoop = function () {
        var rec, timeLapse;
        if (!thisObj.playCont) {
            return;
        }
        timeLapse = FWRecorder.getCurrentTime('audio');
        thisObj.timeDraw(timeLapse, 0);

        thisObj.sliderPlay();
        window.setTimeout(function () {
            thisObj.playLoop();
        }, 100);
               
    };
    thisObj.playStart = function () {
        var timeStart;
        console.debug('playStart');
        $btnRedo.css('visibility', 'hidden');
            
        thisObj.stopByUser = false;

        if (thisObj.sliderPct === 100) {
            thisObj.sliderPct = 0;
        }
        /*
         * set timeStart to 2 decimal places, 
         * at 3 or more, FWRecord.playBackFrom('audio',starTime) will go haywire
         */
        timeStart  = (Math.round(thisObj.sliderPct * thisObj.dur) / 100);

        thisObj.playCont = true;
        FWRecorder.playBackFrom('audio', timeStart);
        thisObj.sliderPlay();
        window.setTimeout(function () {
            thisObj.playLoop();
        }, 300);
               
    };
    thisObj.playStop = function (byuser) {
        if (byuser) {
            thisObj.stopByUser = true;
            return;
        }
        lgzRec.btn.className = 'start-playback';
        if (!mouse.drag) {
            $btnRedo.css('visibility', 'visible');
        }
        thisObj.playCont = false;
        if (!thisObj.stopByUser) {
            thisObj.sliderPlay();
        }
        thisObj.levelDraw(0);
    };
    thisObj.mouseCoords = function (event) {
        var box, ms;
        ms = {};
        box = canvas.getBoundingClientRect();
        ms.x = (event.clientX - box.left) * (canvas.width / box.width);
        ms.y = (event.clientY - box.top) * (canvas.height / box.height);

        return ms;
    };
    thisObj.mouseStopTrue = function (event) {
        var ms;
        ms = thisObj.mouseCoords(event);
        //console.debug('mouseStopTrue: ');

        if ((slider.pos  <  ms.x && ms.x < (slider.pos + slider.thumbw)) &&
                (slider.y1 <  ms.y && ms.y < (slider.y1 + slider.y2))) {
            //console.debug('mouseStopTrue: pointer');
            $canvas.css('cursor', 'pointer');
        } else {
            if (!mouse.drag) {
                //console.debug('mouseStopTrue: default');
                $canvas.css('cursor', 'default');
            }
        }
        if (!mouse.drag) {
            // console.debug('mouseStopTrue: !mouse.drag');
            thisObj.sliderDraw(slider.pct);
        }

    };
    thisObj.mouseStopCheckTO = function (event) {
        //console.debug('mouseStopCheckTO:');
        mouse.move -= 1;
        if (!mouse.move) {
            thisObj.mouseStopTrue(event);
        }
    };
    thisObj.mouseStopCheck = function (event) {
        //console.debug('mouseStopCheck:');
        mouse.move += 1;
        window.setTimeout(function () {
            thisObj.mouseStopCheckTO(event);
        }, 100);
    };
    thisObj.mouseMove = function (event) {
        var ms, xpct;
        if (!modePlay) {
            return;
        }
        if (mouse.drag) {
            // console.debug('mouseMove: (' + event.clientX + ',' + event.clientY + ')');
            ms = thisObj.mouseCoords(event);
            xpct = (ms.x - slider.x1 - slider.thumbww) / slider.pctRatio;
            // console.debug('xpct: ' + xpct);
            thisObj.sliderDraw(xpct);
            
            //ivanix: debug
        }
        thisObj.mouseStopCheck(event);
    };
    thisObj.mouseUp = function (event) {
        if (!modePlay) {
            return;
        }
        // console.debug('mouseUp: (' + event.clientX + ',' + event.clientY + ')');
        if (mouse.drag && mouse.playCont) {
            lgzRec.doAction('start-playback');
        }
        mouse.drag = false;
        thisObj.mouseStopCheck(event);
    };
    thisObj.mouseDown = function (event) {
        var ms, xpos;
        if (!modePlay) {
            return;
        }
       // console.debug('mouseDown: (' + event.clientX + ',' + event.clientY + ')');
        ms = thisObj.mouseCoords(event);
        if (slider.pos  <  ms.x && ms.x < (slider.pos + slider.thumbw)) {
            if (slider.y1 <  ms.y && ms.y < (slider.y1 + slider.y2)) {
                mouse.drag = true;
                mouse.playCont =  thisObj.playCont;
                lgzRec.doAction('stop-playback');
                // $canvas.css('cursor', 'pointer');
                //thisObj.mouseStopCheck(event);
                thisObj.sliderDraw(slider.pct);
            }
        }
    };
    thisObj.testLoop = function () {
        window.setTimeout(function () {
            var l;
            l = Math.random() * 100;
            thisObj.levelRec(l);
            if (thisObj.testCont) {
                thisObj.testLoop();
            }
        }, 50);
    };
    thisObj.test = function () {
        thisObj.timeInit = new Date();
        thisObj.timeLast = thisObj.timeInit;
        thisObj.testCont = true;
        thisObj.testLoop();
        //testLoop for 5 seconds
        window.setTimeout(function () {
            thisObj.testCont = false;
        }, 10000);
    };
    thisObj.sliderInit = function () {
        mouse.drag = false;
        modePlay = true;
        thisObj.lastIdx = thisObj.vuArr.length - 1;
        thisObj.dur = FWRecorder.duration('audio');
        thisObj.timeDraw(thisObj.dur, 1);
        thisObj.write('');
        thisObj.sliderPlay();
    };
    thisObj.redo = function () {
        thisObj.reset();
    };
    thisObj.resetTO = function () {
        lgzRec.btn.className = 'start-recording';
        $btnRedo.css('visibility', 'hidden');
        thisObj.clear();
        thisObj.write('READY TO RECORD');
    };
    thisObj.reset = function () {
        modePlay = false;
        window.setTimeout(function () {
            thisObj.resetTO();
        }, 500);
    };
	thisObj.showOverlay = function() {
		$overlay = $('<div id="recording_overlay"></div>').prependTo(".recorder");
	}
	thisObj.hideOverlay = function() {
		$overlay.remove();
	}
    thisObj.init = function () {
        thisObj.clear();
        if (lgzRec.hasFlash()) {
            $('#lgzBtnRedo')[0].onclick = function () { thisObj.redo(); return false; };
            canvas.addEventListener("mousedown", thisObj.mouseDown, false);
            canvas.addEventListener("mousemove", thisObj.mouseMove, false);
            window.addEventListener("mouseup", thisObj.mouseUp, false);
            thisObj.reset();
        }
        //thisObj.test();
    };
    thisObj.init();


};
lgzRec.hasFlash = function () {
    'use strict';
    //ivanix: debug for mobile
    // return false;
    return navigator.mimeTypes['application/x-shockwave-flash']  !== undefined;
};
lgzRec.isMobile = {
    Android: function () {
        'use strict';
        return (/Android/i.test(navigator.userAgent));
    },
    BlackBerry: function () {
        'use strict';
        return (/BlackBerry/i.test(navigator.userAgent));
    },
    iOS: function () {
        'use strict';
    //ivanix: debug for mobile
    // return true;
        return (/iPhone|iPad|iPod/i.test(navigator.userAgent));
    },
    Windows: function () {
        'use strict';
        return (/IEMobile/i.test(navigator.userAgent));
    },
    any: function () {
        'use strict';
        return (this.Android() || this.BlackBerry() || this.iOS() || this.Windows());
    }
};
lgzRec.addBlob0 = function ($form) {
    'use strict';
    var  blob, fd, uploader;

    blob  = FWRecorder.getBlob('audio');
    fd = new FormData($form);
    fd.append("file", blob, "blob.wav");

    uploader = $form.data('transloadit.uploader');
    uploader._options.formData = fd;
    //ivanix: debug
    // "interval": 2500,
    // "pollTimeout": 8000,
    // "poll404Retries": 15,
    console.debug('interval: ' + uploader._options.interval);
    console.debug('pollTimeout: ' + uploader._options.pollTimeout);
    console.debug('poll404Retries: ' + uploader._options.poll404Retries);
};
lgzRec.addBlob = function ($form) {
    'use strict';
    var blob, fd, uploader;
    console.debug('lgzRec.addBlob: entered');
    blob = FWRecorder.getBlob('audio');
    console.debug('lgzRec.addBlob: got blob');
    fd = [];
    console.debug('lgzRec.addBlob: new form');
    fd.push(["file", blob, "blob.wav"]);
    console.debug('lgzRec.addBlob: appended blob to new form');
    uploader = $form.data('transloadit.uploader');
    uploader._options.formData = fd;
    //ivanix: debug
    // "interval": 2500,
    // "pollTimeout": 8000,
    // "poll404Retries": 15,
    console.debug('interval: ' + uploader._options.interval);
    console.debug('pollTimeout: ' + uploader._options.pollTimeout);
    console.debug('poll404Retries: ' + uploader._options.poll404Retries);
	
	this.display.hideOverlay();
	$("#lgzWinSending").attr("class", "winInit");
};
lgzRec.addMov = function ($form) {
    'use strict';
    var  blob, fd, uploader;
    return;
};
lgzRec._manualSend = function (formid) {
    'use strict';
    var  blob, $form, empty;
    console.debug('lgzRec._manualSend');
	
	this.display.showOverlay();
    $('#lgzWinSending').attr('class', 'winShow');
        
    $form = $(formid);
    empty = false;
    if (lgzRec.hasFlash()) {
        blob  = FWRecorder.getBlob('audio');
        if (!blob.size) {
            empty = true;
        }
    } else {
        if (lgzRec.fieldFile.value === '') {
            empty = true;
        }
    }
    if (empty) {
       // send form directly back to server
       // skip transloadit script
        $form[0].submit();
    } else {
        console.debug('lgzRec._manualSend: submit.transloadit');
        // $form.submit();
        $form.trigger('submit.transloadit');
    }
};
lgzRec._manualSendTO = function (formid) {
    'use strict';
    console.debug('lgzRec._manualSendTO');
    window.setTimeout(function () {
        lgzRec._manualSend(formid);
    }, 500);

};
lgzRec.manualSend = function (formid) {
    'use strict';
    var classAction;
    console.debug('lgzRec.manualSend');

    $('#lgzWinSending').attr('class', 'winShow');

    switch (lgzRec.btn.className) {
    case 'start-recording':
        lgzRec._manualSendTO(formid);
        break;
    case 'start-playback':
        lgzRec._manualSendTO(formid);
        break;
    case 'launch-recorder':
        lgzRec._manualSendTO(formid);
        break;
    case 'stop-recording':
        lgzRec.doAction(lgzRec.btn.className);
        lgzRec._manualSendTO(formid);
        break;
    case 'stop-playback':
        lgzRec.doAction(lgzRec.btn.className);
        lgzRec._manualSendTO(formid);
        break;
    }
};
lgzRec.hideWinPerm = function () {
    'use strict';
	this.display.hideOverlay();
    $('#lgzWinPermFWR').attr('class', 'winHide');
};
lgzRec.showWinPermFWR = function (event) {
    'use strict';
    
    $('#lgzWinPermFWR').attr('class', 'winShow');
	this.display.showOverlay();
    // FWRecorder.showPermissionWindow();
    FWRecorder.showPermissionWindow({permanent: true});
};
lgzRec.hideWinMobile = function (event) {
    'use strict';
	this.display.hideOverlay();
    $('#lgzWinMobile').attr('class', 'winHide');
};
lgzRec.showWinMobile = function (event) {
    'use strict';
	this.display.showOverlay();
    $('#lgzWinMobile').attr('class', 'winShow');
};
lgzRec.launchMobileRecorder = function (event) {
    'use strict';
    lgzRec.hideWinMobile();
    $('#upload_file').click();
};
lgzRec.onClickFWR = function (event) {
    'use strict';
    // lgzRec.btn = event.target;
    if (!FWRecorder.isMicrophoneAccessible()) {
        lgzRec.showWinPermFWR();
        return false;
    }
    lgzRec.doAction(lgzRec.btn.className);
};
lgzRec.onClickMobile = function (event) {
    'use strict';
    // lgzRec.btn = event.target;
    lgzRec.doAction(lgzRec.btn.className);
};
lgzRec.doAction = function (classAction) {
    'use strict';
    // console.debug('lgzRec.doAction:  ' + classAction);
    switch (classAction) {
    case 'start-recording':
        //note: lgzRec.btn called by fwr_event_handler
        lgzRec.btn.className = 'stop-recording';
        lgzRec.display.recInit();
        FWRecorder.record('audio', 'audio.wav');
        break;
    case 'stop-recording':
        console.debug('doAction: stop-recording');
        lgzRec.btn.className = 'start-playback';
        FWRecorder.stopRecording('audio');
        break;
    case 'start-playback':
        lgzRec.btn.className = 'stop-playback';
        lgzRec.display.playStart();
        break;
    case 'stop-playback':
        lgzRec.btn.className = 'start-playback';
        lgzRec.display.playStop(true);
        FWRecorder.stopPlayBack('audio');
        break;
    case 'launch-recorder':
        lgzRec.showWinMobile();
        break;
    }
};
lgzRec.initFWR = function (formid, script) {
    'use strict';
    var  $form;
    console.debug('lgzRec.initFWR');
    $form = $(formid);
                //
                // transloadit jquery default props
                // "interval": 2500,
                // "pollTimeout": 8000,
                // "poll404Retries": 15,
    $.getScript(script, function () {
        $form
            .attr('enctype', 'multipart/form-data')
            .transloadit({
		        "wait": true,
                "interval": 2500,
                "pollTimeout": 8000,
                "poll404Retries": 20,
		        "beforeStart": function () { lgzRec.addBlob($form); return true; },
              "autoSubmit": false,
              "onSuccess": function(assembly) {
                $("#post_audio_id").val(assembly.assembly_id);
                $("#comment_audio_id").val(assembly.assembly_id);
                $form[0].submit();
              }
		    });
    });
    /*
     * for debugging
     *
    $form.submit(function (e) {
        e.preventDefault();
    });
    */
};
lgzRec.mobileFileStatus = function () {
    'use strict';
    lgzRec.display.clear();
    if (lgzRec.fieldFile.value === '') {
        lgzRec.display.write('MEDIA EMPTY');
    } else {
        lgzRec.display.write('MEDIA FOUND');
    }
};
lgzRec.initIOS = function (formid, script) {
    'use strict';
    console.debug('lgzRec.initIOS');
    var  $form;
    console.debug('lgzRec.initIOS:');

    $('#lgzBtnMain').attr('class', 'launch-recorder');
    $('#lgzRecorderFlashDiv').css('display', 'none');
    $('#lgzRecorderLevel').css('display', 'none');

    lgzRec.fieldFile = $('#upload_file')[0];
    lgzRec.fieldFile.onchange = function () { lgzRec.mobileFileStatus(); };
    lgzRec.mobileFileStatus();


    $form = $(formid);
    $.getScript(script, function () {
        $form
            .attr('enctype', 'multipart/form-data')
            .transloadit({
		        "wait": true,
		        "beforeStart": function () { lgzRec.addMov($form); return true; },
              "autoSubmit": false,
              "onSuccess": function(assembly) {
                $("#post_audio_id").val(assembly.assembly_id);
                $("#comment_audio_id").val(assembly.assembly_id);
                $form[0].submit();
              }
		    });
    });
    /*
     * for debugging
     *
    $form.submit(function (e) {
        e.preventDefault();
    });
    */
};
lgzRec.init = function (formid, script) {
    'use strict';

    lgzRec.btn = $('#lgzBtnMain')[0];

    lgzRec.display = new lgzRec.ClassDisplay(lgzRec);

    if (lgzRec.hasFlash()) {
        lgzRec.onClick = lgzRec.onClickFWR;
        lgzRec.initFWR(formid, script);
        return;
    }
    if (lgzRec.isMobile.any()) {
        lgzRec.onClick = lgzRec.onClickMobile;
        lgzRec.initIOS(formid, script);
        return;
    }

};
