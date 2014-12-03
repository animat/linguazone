/*
 jQuery Easing v1.3: Copyright (c) 2008 George McGinley Smith | BSD License: http://www.opensource.org/licenses/bsd-license.php
 jquery.transloadit2-custom-ivanix.js: Copyright (c) 2013 Transloadit Ltd | MIT License: http://www.opensource.org/licenses/mit-license.php

 Fork this on Github: http://github.com/transloadit/jquery-sdk

 Transloadit servers allow browsers to cache jquery.transloadit2.js for 1 hour.
 keep this in mind when rolling out fixes.
 json2: Douglas Crockford | Public domain
 jQuery Tools 1.2.3: Tero Piirainen | Public domain
*/
jQuery.easing.jswing=jQuery.easing.swing;
jQuery.extend(jQuery.easing,{def:"easeOutQuad",swing:function(e,a,b,c,d){return jQuery.easing[jQuery.easing.def](e,a,b,c,d)},easeInQuad:function(e,a,b,c,d){return c*(a/=d)*a+b},easeOutQuad:function(e,a,b,c,d){return-c*(a/=d)*(a-2)+b},easeInOutQuad:function(e,a,b,c,d){return 1>(a/=d/2)?c/2*a*a+b:-c/2*(--a*(a-2)-1)+b},easeInCubic:function(e,a,b,c,d){return c*(a/=d)*a*a+b},easeOutCubic:function(e,a,b,c,d){return c*((a=a/d-1)*a*a+1)+b},easeInOutCubic:function(e,a,b,c,d){return 1>(a/=d/2)?c/2*a*a*a+b:
c/2*((a-=2)*a*a+2)+b},easeInQuart:function(e,a,b,c,d){return c*(a/=d)*a*a*a+b},easeOutQuart:function(e,a,b,c,d){return-c*((a=a/d-1)*a*a*a-1)+b},easeInOutQuart:function(e,a,b,c,d){return 1>(a/=d/2)?c/2*a*a*a*a+b:-c/2*((a-=2)*a*a*a-2)+b},easeInQuint:function(e,a,b,c,d){return c*(a/=d)*a*a*a*a+b},easeOutQuint:function(e,a,b,c,d){return c*((a=a/d-1)*a*a*a*a+1)+b},easeInOutQuint:function(e,a,b,c,d){return 1>(a/=d/2)?c/2*a*a*a*a*a+b:c/2*((a-=2)*a*a*a*a+2)+b},easeInSine:function(e,a,b,c,d){return-c*Math.cos(a/
d*(Math.PI/2))+c+b},easeOutSine:function(e,a,b,c,d){return c*Math.sin(a/d*(Math.PI/2))+b},easeInOutSine:function(e,a,b,c,d){return-c/2*(Math.cos(Math.PI*a/d)-1)+b},easeInExpo:function(e,a,b,c,d){return 0==a?b:c*Math.pow(2,10*(a/d-1))+b},easeOutExpo:function(e,a,b,c,d){return a==d?b+c:c*(-Math.pow(2,-10*a/d)+1)+b},easeInOutExpo:function(e,a,b,c,d){return 0==a?b:a==d?b+c:1>(a/=d/2)?c/2*Math.pow(2,10*(a-1))+b:c/2*(-Math.pow(2,-10*--a)+2)+b},easeInCirc:function(e,a,b,c,d){return-c*(Math.sqrt(1-(a/=d)*
a)-1)+b},easeOutCirc:function(e,a,b,c,d){return c*Math.sqrt(1-(a=a/d-1)*a)+b},easeInOutCirc:function(e,a,b,c,d){return 1>(a/=d/2)?-c/2*(Math.sqrt(1-a*a)-1)+b:c/2*(Math.sqrt(1-(a-=2)*a)+1)+b},easeInElastic:function(e,a,b,c,d){e=1.70158;var f=0,h=c;if(0==a)return b;if(1==(a/=d))return b+c;f||(f=.3*d);h<Math.abs(c)?(h=c,e=f/4):e=f/(2*Math.PI)*Math.asin(c/h);return-(h*Math.pow(2,10*--a)*Math.sin(2*(a*d-e)*Math.PI/f))+b},easeOutElastic:function(e,a,b,c,d){e=1.70158;var f=0,h=c;if(0==a)return b;if(1==(a/=
d))return b+c;f||(f=.3*d);h<Math.abs(c)?(h=c,e=f/4):e=f/(2*Math.PI)*Math.asin(c/h);return h*Math.pow(2,-10*a)*Math.sin(2*(a*d-e)*Math.PI/f)+c+b},easeInOutElastic:function(e,a,b,c,d){e=1.70158;var f=0,h=c;if(0==a)return b;if(2==(a/=d/2))return b+c;f||(f=.3*d*1.5);h<Math.abs(c)?(h=c,e=f/4):e=f/(2*Math.PI)*Math.asin(c/h);return 1>a?-.5*h*Math.pow(2,10*--a)*Math.sin(2*(a*d-e)*Math.PI/f)+b:h*Math.pow(2,-10*--a)*Math.sin(2*(a*d-e)*Math.PI/f)*.5+c+b},easeInBack:function(e,a,b,c,d,f){void 0==f&&(f=1.70158);
return c*(a/=d)*a*((f+1)*a-f)+b},easeOutBack:function(e,a,b,c,d,f){void 0==f&&(f=1.70158);return c*((a=a/d-1)*a*((f+1)*a+f)+1)+b},easeInOutBack:function(e,a,b,c,d,f){void 0==f&&(f=1.70158);return 1>(a/=d/2)?c/2*a*a*(((f*=1.525)+1)*a-f)+b:c/2*((a-=2)*a*(((f*=1.525)+1)*a+f)+2)+b},easeInBounce:function(e,a,b,c,d){return c-jQuery.easing.easeOutBounce(e,d-a,0,c,d)+b},easeOutBounce:function(e,a,b,c,d){return(a/=d)<1/2.75?7.5625*c*a*a+b:a<2/2.75?c*(7.5625*(a-=1.5/2.75)*a+.75)+b:a<2.5/2.75?c*(7.5625*(a-=
2.25/2.75)*a+.9375)+b:c*(7.5625*(a-=2.625/2.75)*a+.984375)+b},easeInOutBounce:function(e,a,b,c,d){return a<d/2?.5*jQuery.easing.easeInBounce(e,2*a,0,c,d)+b:.5*jQuery.easing.easeOutBounce(e,2*a-d,0,c,d)+.5*c+b}});
(function(e){function a(){}function b(a){t=[a]}function c(a,g,m){return a&&a.apply(g.context||g,m)}function d(d){function w(a){C++||(D(),E&&(m[q]={s:[a]}),z&&(a=z.apply(d,[a])),c(k,d,[a,"success",d]),c(x,d,[d,"success"]))}function n(a){C++||(D(),E&&"timeout"!=a&&(m[q]=a),c(s,d,[d,a]),c(x,d,[d,a]))}d=e.extend({},A,d);var k=d.success,s=d.error,x=d.complete,z=d.dataFilter,F=d.callbackParameter,I=d.callback,L=d.cache,E=d.pageCache,J=d.charset,q=d.url,y=d.data,K=d.timeout,G,C=0,D=a,p,B,H;h&&h(function(a){a.done(k).fail(s);
k=a.resolve;s=a.reject}).promise(d);d.abort=function(){!C++&&D()};if(!1===c(d.beforeSend,d,[d])||C)return d;q=q||"";y=y?"string"==typeof y?y:e.param(y,d.traditional):"";q+=y?(/\?/.test(q)?"&":"?")+y:"";F&&(q+=(/\?/.test(q)?"&":"?")+encodeURIComponent(F)+"=?");L||E||(q+=(/\?/.test(q)?"&":"?")+"_"+(new Date).getTime()+"=");q=q.replace(/=\?(&|$)/,"="+I+"$1");E&&(G=m[q])?G.s?w(G.s[0]):n(G):(f[I]=b,p=e("<script>")[0],p.id="_jqjsp"+g++,J&&(p.charset=J),r&&11.6>r.version()?(B=e("<script>")[0]).text="document.getElementById('"+
p.id+"').onerror()":p.async="async",u&&(p.htmlFor=p.id,p.event="onclick"),p.onload=p.onerror=p.onreadystatechange=function(a){if(!p.readyState||!/i/.test(p.readyState)){try{p.onclick&&p.onclick()}catch(g){}a=t;t=0;a?w(a[0]):n("error")}},p.src=q,D=function(a){H&&clearTimeout(H);p.onreadystatechange=p.onload=p.onerror=null;l.removeChild(p);B&&l.removeChild(B)},l.insertBefore(p,F=l.firstChild),B&&l.insertBefore(B,F),H=0<K&&setTimeout(function(){n("timeout")},K));return d}var f=window,h=e.Deferred,l=
e("head")[0]||document.documentElement,m={},g=0,t,A={callback:"_jqjsp",url:location.href},r=f.opera,u=!!e("<div>").html("\x3c!--[if IE]><i><![endif]--\x3e").find("i").length;d.setup=function(a){e.extend(A,a)};e.jsonp=d})(jQuery);this.JSON||(this.JSON={});
(function(){function e(a){return 10>a?"0"+a:a}function a(a){d.lastIndex=0;return d.test(a)?'"'+a.replace(d,function(a){var g=l[a];return"string"===typeof g?g:"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)})+'"':'"'+a+'"'}function b(g,d){var c,e,u,v,w=f,n,k=d[g];k&&"object"===typeof k&&"function"===typeof k.toJSON&&(k=k.toJSON(g));"function"===typeof m&&(k=m.call(d,g,k));switch(typeof k){case "string":return a(k);case "number":return isFinite(k)?String(k):"null";case "boolean":case "null":return String(k);
case "object":if(!k)return"null";f+=h;n=[];if("[object Array]"===Object.prototype.toString.apply(k)){v=k.length;for(c=0;c<v;c+=1)n[c]=b(c,k)||"null";u=0===n.length?"[]":f?"[\n"+f+n.join(",\n"+f)+"\n"+w+"]":"["+n.join(",")+"]";f=w;return u}if(m&&"object"===typeof m)for(v=m.length,c=0;c<v;c+=1)e=m[c],"string"===typeof e&&(u=b(e,k))&&n.push(a(e)+(f?": ":":")+u);else for(e in k)Object.hasOwnProperty.call(k,e)&&(u=b(e,k))&&n.push(a(e)+(f?": ":":")+u);u=0===n.length?"{}":f?"{\n"+f+n.join(",\n"+f)+"\n"+
w+"}":"{"+n.join(",")+"}";f=w;return u}}"function"!==typeof Date.prototype.toJSON&&(Date.prototype.toJSON=function(a){return isFinite(this.valueOf())?this.getUTCFullYear()+"-"+e(this.getUTCMonth()+1)+"-"+e(this.getUTCDate())+"T"+e(this.getUTCHours())+":"+e(this.getUTCMinutes())+":"+e(this.getUTCSeconds())+"Z":null},String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(a){return this.valueOf()});var c=/[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
d=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,f,h,l={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"},m;"function"!==typeof JSON.stringify&&(JSON.stringify=function(a,c,d){var e;h=f="";if("number"===typeof d)for(e=0;e<d;e+=1)h+=" ";else"string"===typeof d&&(h=d);if((m=c)&&"function"!==typeof c&&("object"!==typeof c||"number"!==typeof c.length))throw Error("JSON.stringify");return b("",{"":a})});
"function"!==typeof JSON.parse&&(JSON.parse=function(a,m){function d(a,g){var c,e,b=a[g];if(b&&"object"===typeof b)for(c in b)Object.hasOwnProperty.call(b,c)&&(e=d(b,c),void 0!==e?b[c]=e:delete b[c]);return m.call(a,g,b)}var e;a=String(a);c.lastIndex=0;c.test(a)&&(a=a.replace(c,function(a){return"\\u"+("0000"+a.charCodeAt(0).toString(16)).slice(-4)}));if(/^[\],:{}\s]*$/.test(a.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g,"@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g,
"]").replace(/(?:^|:|,)(?:\s*\[)+/g,"")))return e=eval("("+a+")"),"function"===typeof m?d({"":e},""):e;throw new SyntaxError("JSON.parse");})})();
(function(e){e.tools=e.tools||{version:"2013-02-15"};var a=e.tools.expose={conf:{maskId:"exposeMask",loadSpeed:"slow",closeSpeed:"fast",zIndex:9998,opacity:.8,startOpacity:0,color:"#fff"}},b,c,d,f,h;e.mask={load:function(l,m){if(d)return this;l=l||f;f=l=e.extend(e.extend({},a.conf),l);b=e("#"+l.maskId);b.length||(b=e("<div/>").attr("id",l.maskId),e("body").append(b));b.css({position:"fixed",top:0,left:0,width:"100%",height:"100%",display:"block",opacity:l.opacity,zIndex:l.zIndex,backgroundColor:l.color});
m&&m.length&&(h=m.eq(0).css("zIndex"),c=m.css({zIndex:Math.max(l.zIndex+1,"auto"==h?0:h)}));d=!0;return this},close:function(){d&&(b.fadeOut(f.closeSpeed,function(){c&&c.css({zIndex:h})}),d=!1);return this}};e.fn.mask=function(a){e.mask.load(a);return this};e.fn.expose=function(a){e.mask.load(a,this);return this}})(jQuery);
!function(e){function a(a,g){g=g||[];return a.replace(/(%[s])/g,function(a,m,c){return(a=g.shift())||0===a?a+"":""})}function b(){this.timer=this.documentTitle=this.instance=this.assemblyId=null;this._options={};this.uploads=[];this.results={};this.pollStarted=this.ended=null;this.pollRetries=0;this.started=!1;this.params=this.assembly=null;this.lastPoll=this.bytesReceivedBefore=0;this.$modal=this.$iframe=this.$fileClones=this.$files=this.$form=this.$params=null;this._clockseq=this._lastNSecs=this._lastMSecs=
0;this._uploadFileIds=[];this._resultFileIds=[]}var c="https:"==document.location.protocol?"https://":"http://",d=c+"api2.transloadit.com/",f={service:d,assets:c+"assets.transloadit.com/",beforeStart:function(){return!0},onFileSelect:function(){},onStart:function(){},onProgress:function(){},onUpload:function(){},onResult:function(){},onCancel:function(){},onError:function(){},onSuccess:function(){},interval:2500,pollTimeout:8E3,poll404Retries:15,pollConnectionRetries:3,wait:!1,processZeroFiles:!0,
triggerUploadOnFileSelection:!1,autoSubmit:!0,modal:!0,exclude:"",fields:!1,params:null,signature:null,region:"us-east-1",debug:!0,locale:"en"},h={en:{"errors.BORED_INSTANCE_ERROR":"Could not find a bored instance.","errors.CONNECTION_ERROR":"There was a problem connecting to the upload server","errors.unknown":"There was an internal error.","errors.tryAgain":"Please try your upload again.","errors.troubleshootDetails":"If you would like our help to troubleshoot this, please email us this information:",
cancel:"Cancel",details:"Details",startingUpload:"Starting upload ...",processingFiles:"Upload done, now processing files ...",uploadProgress:"%s / %s MB at %s kB/s | %s left"}},l=!1;e.fn.transloadit=function(){var a=Array.prototype.slice.call(arguments),g,c;if(0!==this.length)if(1<this.length)this.each(function(){e.fn.transloadit.apply(e(this),a)});else{(1==a.length&&"object"==typeof a[0]||void 0===a[0])&&a.unshift("init");g=a.shift();"init"==g?(c=new b,a.unshift(this),this.data("transloadit.uploader",
c)):c=this.data("transloadit.uploader");if(!c)throw Error("Element is not initialized for transloadit!");g=c[g].apply(c,a);return void 0===g?this:g}};e.fn.transloadit.i18n=h;b.prototype.init=function(a,g){this.$form=a;this.options(e.extend({},f,g||{}));var c=this;a.bind("submit.transloadit",function(){c.validate();c.detectFileInputs();c._options.processZeroFiles||0!==c.$files.length?c._options.beforeStart()&&c.getBoredInstance():c._options.beforeStart()&&c.submitForm();return!1});if(this._options.triggerUploadOnFileSelection)a.on("change",
'input[type="file"]',function(){a.trigger("submit.transloadit")});a.on("change",'input[type="file"]',function(){c._options.onFileSelect(e(this).val(),e(this))});this.includeCss()};b.prototype.getBoredInstance=function(){function a(){e.jsonp({url:b,timeout:g._options.pollTimeout,callbackParameter:"callback",success:function(a){a.error?(g.ended=!0,a.url=b,g.renderError(a),g._options.onError(a)):(g.instance=a.api2_host,g.start())},error:function(e,f){if(A&&g._options.service===d)A=!1,g._findBoredInstanceUrl(function(e,
d){e?(g.ended=!0,e={error:"BORED_INSTANCE_ERROR",message:g.i18n("errors.BORED_INSTANCE_ERROR")+" "+e.message},g.renderError(e),g._options.onError(e)):(b=c+"api2."+d+"/instances/bored",a())});else{g.ended=!0;var v={error:"CONNECTION_ERROR",message:g.i18n("errors.CONNECTION_ERROR"),reason:"JSONP request status: "+f,url:b};g.renderError(v);g._options.onError(v)}}})}var g=this;this.instance=null;var b=this._options.service+"instances/bored",A=!0;a();this._options.modal&&this.showModal()};b.prototype._findBoredInstanceUrl=
function(a){var g=this,b=c+"s3.amazonaws.com/infra-"+this._options.region;e.ajax({url:b+".transloadit.com/cached_instances.json",datatype:"json",timeout:5E3,success:function(c){c=g._shuffle(c.uploaders);g._findResponsiveInstance(c,0,a)},error:function(g,c){a(Error("Could not query S3 for cached uploaders"))}})};b.prototype._findResponsiveInstance=function(a,g,b){if(!a[g])return b(Error("No responsive uploaders"));var d=this,r=a[g];e.jsonp({url:c+r,timeout:3E3,callbackParameter:"callback",success:function(a){b(null,
r)},error:function(c,e){d._findResponsiveInstance(a,g+1,b)}})};b.prototype._shuffle=function(a){for(var g=[],c,b=0;b<a.length;b++)c=Math.floor(Math.random()*(b+1)),g[b]=g[c],g[c]=a[b];return g};b.prototype.start=function(){var a=this;this.ended=this.started=!1;this.pollRetries=this.bytesReceivedBefore=0;this.uploads=[];this._uploadFileIds=[];this._resultFileIds=[];this.results={};this.assemblyId=this._genUuid();this.$fileClones=e().not(document);this.$files.each(function(){var b=e(this).clone(!0);
a.$fileClones=a.$fileClones.add(b);b.insertAfter(this)});this.$iframe=e('<iframe id="transloadit-'+this.assemblyId+'" name="transloadit-'+this.assemblyId+'"/>').appendTo("body").hide();var g=c+this.instance+"/assemblies/"+this.assemblyId+"?redirect=false";if(this._options.formData){var b=this.$form.find("input[name=params]").val();if(this._options.formData instanceof FormData)this._options.formData.append("params",b);else{var d=new FormData(this.$form);d.append("params",b);for(b=0;b<this._options.formData.length;b++){var r=
this._options.formData[b];d.append(r[0],r[1],r[2])}this._options.formData=d}d=new XMLHttpRequest;d.open("POST",g);d.send(this._options.formData)}else{this.$uploadForm=e('<form enctype="multipart/form-data" />').attr("action",g).attr("target","transloadit-"+this.assemblyId).attr("method","POST").append(this.$files).appendTo("body").hide();g="[name=params], [name=signature]";!0===this._options.fields?g="*":"string"===typeof this._options.fields&&(g+=", "+this._options.fields);b=this.$form.find(":input[type!=file]").filter(g);
g=b.filter("select");b=b.filter(function(){return!e(this).is("select")});b=b.filter("[type!=submit]");b=this.clone(b);this._options.params&&!this.$params&&(b=b.add('<input name="params" value=\''+JSON.stringify(this._options.params)+"'>"));this._options.signature&&(b=b.add('<input name="signature" value=\''+this._options.signature+"'>"));if("object"==typeof this._options.fields)for(d in this._options.fields)b=b.add('<input name="'+d+"\" value='"+this._options.fields[d]+"'>");b.prependTo(this.$uploadForm);
g.each(function(){e('<input type="hidden"/>').attr("name",e(this).attr("name")).attr("value",e(this).val()).prependTo(a.$uploadForm)});this.$uploadForm.submit()}this.lastPoll=+new Date;setTimeout(function(){a._poll()},300)};b.prototype.clone=function(a){var b=a.clone();a=a.filter("textarea");for(var c=b.filter("textarea"),d=0;d<a.length;++d)e(c[d]).val(e(a[d]).val());return b};b.prototype.detectFileInputs=function(){var a=this.$form.find("input[type=file]").not(this._options.exclude);this._options.processZeroFiles||
(a=a.filter(function(){return""!==this.value}));this.$files=a};b.prototype.validate=function(){if(this._options.params)this.params=this._options.params;else{var a=this.$form.find("input[name=params]");if(!a.length){alert("Could not find input[name=params] in your form.");return}this.$params=a;try{this.params=JSON.parse(a.val())}catch(b){alert("Error: input[name=params] seems to contain invalid JSON.");return}}this.params.redirect_url?this.$form.attr("action",this.params.redirect_url):this._options.autoSubmit&&
this.$form.attr("action")==this._options.service+"assemblies"&&alert("Error: input[name=params] does not include a redirect_url")};b.prototype._poll=function(a){var b=this;if(!this.ended){var d=/(mozilla)(?:.*? rv:([\w.]+))?/.exec(navigator.userAgent),d=d&&d[1];this.documentTitle=document.title;d&&!this.documentTitle&&(document.title="Loading...");this.pollStarted=+new Date;var d=this.instance.replace(/\.transloadit\.com/,"")+"-status.transloadit.com",f=c+d+"/assemblies/"+this.assemblyId;a&&(f+=a);
e.jsonp({url:f,timeout:b._options.pollTimeout,callbackParameter:"callback",success:function(a){if(!b.ended)if(b.assembly=a,"ASSEMBLY_NOT_FOUND"==a.error)b.pollRetries++,b.pollRetries>b._options.poll404Retries?(document.title=b.documentTitle,b.ended=!0,b.renderError(a),b._options.onError(a)):setTimeout(function(){b._poll()},400);else if(a.error)b.ended=!0,b.renderError(a),document.title=b.documentTitle,b._options.onError(a);else{b.started||(b.started=!0,b._options.onStart(a));b.pollRetries=0;var c=
"ASSEMBLY_EXECUTING"===a.ok,d="ASSEMBLY_CANCELED"===a.ok,e="ASSEMBLY_COMPLETED"===a.ok;b._options.onProgress(a.bytes_received,a.bytes_expected,a);for(var m=0;m<a.uploads.length;m++){var f=a.uploads[m];-1===b._uploadFileIds.indexOf(f.id)&&(b._options.onUpload(f,a),b.uploads.push(f),b._uploadFileIds.push(f.id))}for(var t in a.results)for(b.results[t]=b.results[t]||[],m=0;m<a.results[t].length;m++){var f=a.results[t][m],h=t+"_"+f.id;-1===b._resultFileIds.indexOf(h)&&(b._options.onResult(t,f,a),b.results[t].push(f),
b._resultFileIds.push(h))}d?(b.ended=!0,document.title=b.documentTitle,b._options.onCancel(a)):(c=e||!b._options.wait&&c,b.renderProgress(a,c,b._options.wait),c?(b.ended=!0,document.title=b.documentTitle,a.uploads=b.uploads,a.results=b.results,b._options.onSuccess(a),setTimeout(function(){b._options.modal&&b.cancel();b.submitForm()},600)):(a=b.pollStarted-+new Date,b.timer=setTimeout(function(){b._poll()},a<b._options.interval?b._options.interval:a),b.lastPoll=+new Date))}},error:function(a,c){if(!b.ended)if(b.pollRetries++,
b.pollRetries>b._options.pollConnectionRetries){document.title=b.documentTitle;b.ended=!0;var d={error:"CONNECTION_ERROR",message:b.i18n("errors.CONNECTION_ERROR"),reason:"JSONP request status: "+c,url:f};b.renderError(d);b._options.onError(d)}else setTimeout(function(){b._poll()},350)}})}};b.prototype.stop=function(){document.title=this.documentTitle;this.ended=!0};b.prototype.cancel=function(){if(!this.ended){var a=this;this.$params&&this.$params.prependTo(this.$form);this.$fileClones.each(function(b){b=
e(a.$files[b]).clone(!0);var c=e(this);b.insertAfter(c);c.remove()});clearTimeout(a.timer);this._poll("?method=delete");"Microsoft Internet Explorer"==navigator.appName&&this.$iframe[0].contentWindow.document.execCommand("Stop");setTimeout(function(){a.$iframe.remove()},500)}this._options.modal&&this.hideModal()};b.prototype.submitForm=function(){"multipart/form-data"===this.$form.attr("enctype")&&this.$form.removeAttr("enctype");null!==this.assembly&&e("<textarea/>").attr("name","transloadit").text(JSON.stringify(this.assembly)).prependTo(this.$form).hide();
this._options.autoSubmit&&this.$form.unbind("submit.transloadit").submit()};b.prototype.hideModal=function(){e.mask.close();this.$modal.remove()};b.prototype.showModal=function(){this.$modal=e('<div id="transloadit"><div class="content"><a href="#close" class="close">'+this.i18n("cancel")+'</a><p class="status"></p><div class="progress progress-striped active"><div class="bar"><span class="percent"></span></div></div><label>'+this.i18n("startingUpload")+'</label><p class="error"></p><div class="error-details-toggle"><a href="#">'+
this.i18n("details")+'</a></div><p class="error-details"></p></div></div>').appendTo("body");e.extend(this.$modal,{$content:this.$modal.find(".content"),$close:this.$modal.find(".close"),$label:this.$modal.find("label"),$progress:this.$modal.find(".progress"),$percent:this.$modal.find(".progress .percent"),$progressBar:this.$modal.find(".progress .bar"),$error:this.$modal.find(".error"),$errorDetails:this.$modal.find(".error-details"),$errorDetailsToggle:this.$modal.find(".error-details-toggle")});
var a=this;this.$modal.$close.click(function(){a.cancel()});this.$modal.$error.hide();this.$modal.$errorDetails.hide();this.$modal.$errorDetailsToggle.hide();this.$modal.expose({api:!0,maskId:"transloadit_expose",opacity:.9,loadSpeed:250,closeOnEsc:!1,closeOnClick:!1});this.$modal.$close.click(function(){a.cancel();return!1})};b.prototype.renderError=function(a){if(this._options.modal){if(!this._options.debug)return this.cancel();this.$modal.$content.addClass("content-error");this.$modal.$progress.hide();
this.$modal.$label.hide();var b=a.error+": "+a.message+"<br /><br />",b=b+(a.reason||"");if(-1===["CONNECTION_ERROR","BORED_INSTANCE_ERROR","ASSEMBLY_NOT_FOUND"].indexOf(a.error))this.$modal.$error.html(b).show();else{var d=this.i18n("errors.unknown")+"<br/>"+this.i18n("errors.tryAgain");this.$modal.$error.html(d).show();var f=a.assemblyId?a.assemblyId:this.assemblyId,r=this,h=null;e.getJSON(c+"jsonip.com/",function(a){h=a.ip}).always(function(){var d={endpoint:a.url,instance:r.instance,assembly_id:f,
ip:h,time:r.getUTCDatetime(),agent:navigator.userAgent,poll_retries:r.pollRetries,error:b};e.post(c+"status.transloadit.com/client_error",d);var t=[],n;for(n in d)t.push(n+": "+d[n]);d=r.i18n("errors.troubleshootDetails")+"<br /><br />";r.$modal.$errorDetails.hide().html(d+t.join("<br />"));r.$modal.$errorDetailsToggle.show().find("a").off("click").on("click",function(a){a.preventDefault();r.$modal.$errorDetails.toggle()})})}}};b.prototype.renderProgress=function(a,b,c){if(this._options.modal){var d=
a.bytes_received/a.bytes_expected*100;100<d&&(d=0);var e=a.bytes_received-this.bytesReceivedBefore,f=+new Date-this.lastPoll,h=100===d?1E3:2*this._options.interval,l=this.i18n("processingFiles");if(100!=d)var l=(a.bytes_received/1024/1024).toFixed(2),n=(a.bytes_expected/1024/1024).toFixed(2),k=(e/1024/(f/1E3)).toFixed(1),s=a.bytes_expected-a.bytes_received,f=(e/(f/1E3)).toFixed(1),f=this._duration(s/f),l=this.i18n("uploadProgress",l,n,k,f);this.$modal.$label.text(l);var x=parseInt(this.$modal.$progress.css("width"),
10);this.bytesReceivedBefore=a.bytes_received;if(!(0>=e)||b){var z=this;a=d;90<a&&!b&&c&&(a=90);b&&c&&(h=500);this.$modal.$progressBar.stop().animate({width:a+"%"},{duration:h,easing:"linear",progress:function(a,b,c){a=(100*parseInt(z.$modal.$progressBar.css("width"),10)/x).toFixed(0);100<a&&(a=100);13<a&&z.$modal.$percent.text(a+"%")}})}}};b.prototype.includeCss=function(){!l&&this._options.modal&&(l=!0,e('<link rel="stylesheet" type="text/css" href="'+this._options.assets+'css/transloadit2-latest.css" />').appendTo("head"))};
b.prototype.getUTCDatetime=function(){var a=new Date,a=new Date(a.getUTCFullYear(),a.getUTCMonth(),a.getUTCDate(),a.getUTCHours(),a.getUTCMinutes(),a.getUTCSeconds()),b=function(a){return 10>a?"0"+a:a},c=a.getTimezoneOffset(),d=(0<c?"-":"+")+b(parseInt(c/60,10));0!==c%60&&(d+=b(c%60));0===c&&(d="Z");return a.getFullYear()+"-"+b(a.getMonth()+1)+"-"+b(a.getDate())+"T"+b(a.getHours())+":"+b(a.getMinutes())+":"+b(a.getSeconds())+d};b.prototype._duration=function(a){var b=Math.floor(a/3600);a-=3600*b;
var c=Math.floor(a/60);a-=60*c;var d="";0<b&&(d+=b+"h ");0<c&&(d+=c+"min ");0<a&&(a=a.toFixed(0),d+=a+"s");""===d&&(d="0s");return d};b.prototype._genUuid=function(a,b,c){function d(a,b){var c=b||0,e=n;return e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]+e[a[c++]]}a=a||{};c=b&&c||0;var e=b||[],f=Array(16),h=function(){for(var a=0,b;16>a;a++)0===(a&3)&&(b=4294967296*Math.random()),f[a]=b>>>((a&3)<<
3)&255;return f}(),l=[h[0]|1,h[1],h[2],h[3],h[4],h[5]];this._clockseq=(h[6]<<8|h[7])&16383;for(var h=null!=a.clockseq?a.clockseq:this._clockseq,n=[],k=0;256>k;k++)n[k]=(k+256).toString(16).substr(1);var k=null!=a.msecs?a.msecs:(new Date).getTime(),s=null!=a.nsecs?a.nsecs:this._lastNSecs+1,x=k-this._lastMSecs+(s-this._lastNSecs)/1E4;0>x&&null==a.clockseq&&(h=h+1&16383);(0>x||k>this._lastMSecs)&&null==a.nsecs&&(s=0);if(1E4<=s)throw Error("uuid.v1(): Can't create more than 10M uuids/sec");this._lastMSecs=
k;this._lastNSecs=s;this._clockseq=h;k+=122192928E5;s=(1E4*(k&268435455)+s)%4294967296;e[c++]=s>>>24&255;e[c++]=s>>>16&255;e[c++]=s>>>8&255;e[c++]=s&255;k=k/4294967296*1E4&268435455;e[c++]=k>>>8&255;e[c++]=k&255;e[c++]=k>>>24&15|16;e[c++]=k>>>16&255;e[c++]=h>>>8|128;e[c++]=h&255;a=a.node||l;for(l=0;6>l;l++)e[c+l]=a[l];return b?b:d(e)};b.prototype.options=function(a){if(0===arguments.length)return this._options;e.extend(this._options,a)};b.prototype.option=function(a,b){if(1==arguments.length)return this._options[a];
this._options[a]=b};b.prototype.i18n=function(){var b=Array.prototype.slice.call(arguments),c=b.shift(),d=this._options.locale,d=h[d]&&h[d][c]||h.en[c];if(!d)throw Error("Unknown i18n key: "+c);return a(d,b)}}(window.jQuery);