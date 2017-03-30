%%%-------------------------------------------------------------------
%%% @author przemek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Mar 2017 22:59
%%%-------------------------------------------------------------------
-module(onp).
-author("przemek").

%% API
-export([onp/1,count/2]).

onp(Expr) ->
  List = strings:tokens(Expr," "),
  count(List, []).

count([], [H|T])->H;
count([A|T], [Tail]) -> count([T], [A|Tail]);
count(["+"|T], [A,B|Tail])->count(T, [B+A|Tail]);
count(["-"|T], [A,B|Tail])->count(T, [B-A|Tail]);
count(["*"|T], [A,B|Tail])->count(T, [B*A|Tail]);
count(["/"|T], [A,B|Tail])->count(T, [B/A|Tail]).



