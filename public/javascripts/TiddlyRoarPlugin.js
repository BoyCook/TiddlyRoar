/***
|''Name''|TiddlyRoarPlugin|
|''Description''|triggers GET of tiddlers from rails REST|
|''Author''|Craig Cook|
|''Version''|0.0.1|
|''Status''|@@experimental@@|
|''Source''|http://craigcook.co.uk/samples/tiddlyroar.js|
|''CodeRepository''|http://craigcook.co.uk/svn/cccs/tiddlyroar/trunk|
|''CoreVersion''|2.4.2|
|''Keywords''|serverSide tiddlyRoar|
!Revision History
!!v0.0.1 (2009-03-05)
* initial release
!To Do
* Get it working
!Code
***/
//{{{
if(!version.extensions.TiddlyRoarPlugin) { //# ensure that the plugin is only installed once
version.extensions.TiddlyRoarPlugin = { installed: true };

(function() { //# set up local scope

var adaptor = new config.adaptors.tiddlyweb();

function doCallback(context, userparams) {
    var tiddlers = context.tiddlers;

    for(var i = 0; i < tiddlers.length; i++) {
        var tiddler = tiddlers[i];

        if (tiddler instanceof Tiddler) {
            store.addTiddler(tiddler);
        }
    }
}

var context = {
    host: 'http://localhost:3000/',
    workspace:  'bags/common'
};

adaptor.getTiddlerList(context, null, doCallback);

})(); //# end of local scope

} //# end of "install only once"
//}}}