-module(webserver).
-export([start/0]).

start() ->
    spawn(fun () -> {ok, Sock} = gen_tcp:listen(8080, [{reuseaddr, true},{active, false}]),
                    loop(Sock) end).

loop(Sock) ->
    {ok, Conn} = gen_tcp:accept(Sock),
    Handler = spawn(fun () -> handle(Conn) end),
    gen_tcp:controlling_process(Conn, Handler),
    loop(Sock).

handle(Conn) ->
    gen_tcp:send(Conn, response(gen_response())),
    gen_tcp:close(Conn).

gen_response() ->
  "<!DOCTYPE html>
<html>
<style type='text/css'>*{
background-color:#FFFF00;
background-image:none;
font-family:Comic Sans MS,Comic Sans;
font-size:15px;
color:#FFFFFF;
}
a:link{
color:#00FF00;

}

body{
background-color:#FFFF00;
background-image:none;
font-family:Comic Sans MS,Comic Sans;
font-size:15px;
color:#000000;
}

p{
background-color:#FF0000;
background-image:none;
font-family:Comic Sans MS,Comic Sans;
font-size:20px;
}

li
{
list-style-image:url(https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/point.gif);
}</style><body>
<img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/epic_win_pic_china_panda_armor_statue-574234.jpg' /><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/man-farting.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/7upspot.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/man-farting.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/man-farting.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/7upspot.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/funstuff.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/7upspot.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/man-farting.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/7upspot.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/man-farting.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/dancingbaby.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/7upspot.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/man-farting.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/7upspot.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/man-farting.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/funstuff.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/7upspot.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/dancingbaby.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/dancingbaby.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/funstuff.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/dancingbaby.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/d<div style='height:100px; text-align:center'><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/counter.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/ns_logo.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/ie_logo.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/noframes.gif'/><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/notepad.gif'/></div><embed src='sound/tubthumping.mid' width='100px' height='20px'></embed>
<div id='cornerlogo' style='position:fixed; bottom:0px; left:0px; z-index:1000;'><a href='/'><img src='https://s3-us-west-2.amazonaws.com/unikernel-demo/panda_site/images/logo.gif' /></a></div><br />".

response(Str) ->
    B = iolist_to_binary(Str),
    iolist_to_binary(
      io_lib:fwrite(
         "HTTP/1.0 200 OK\nContent-Type: text/html\nContent-Length: ~p\n\n~s",
         [size(B), B])).
