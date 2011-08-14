//{{{
// TiddlyRoar login macro
// v0.1
// 05th March 2009
//
// Author: Craig Cook, craig [dot] cook [at] bt [dot] com
//
// Usage: <<tiddlyRoarLogin>>
// Where option is the mode that you using

if(!config.options.pasPassWord) config.options.pasPassWord = "password";

config.macros.tiddlyRoarLogin = {};

config.macros.tiddlyRoarLogin = {
    label: "login",
    prompt: "Login",
    accessKey: "L"
};

config.macros.tiddlyRoarLogin.handler = function(place,macroName,params,wikifier,paramString){
    //Handler for macro
    //Assigns action based upon parameters passed in
    //this.loginUI(place);
    createTiddlyButton(place,this.label,this.prompt,this.onClick);
};

config.macros.tiddlyRoarLogin.onClick = function(e)
{
    config.macros.tiddlyRoarLogin.login();
};


config.macros.tiddlyRoarLogin.login = function(){
    var adaptor = new config.adaptors.tiddlyweb();

    var context = {
        host: 'http://localhost:3000/',
        workspace:  'bags/common',
        authenticity_token: '57993da11c08b8a12004125ce15b51d40a09e317',
        username: 'test',
        password: 'password'
    };

    adaptor.login(context, null, null);
};


config.macros.tiddlyRoarLogin.loginUI = function(){
    alert('Show login UI');
};

//}}}