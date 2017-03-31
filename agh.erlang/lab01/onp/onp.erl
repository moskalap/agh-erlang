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
-export([onp/1]).

onp(Expr) ->
  List = string:tokens(Expr," "),
  process(List, []).

process([], [H|T]) -> H;
process(["+"|T],[A,B|Tail]) -> process(T, [B+A|Tail]);
process(["-"|T],[A,B|Tail]) -> process(T, [B-A|Tail]);
process(["*"|T],[A,B|Tail]) -> process(T, [B*A|Tail]);
process(["/"|T],[A,B|Tail]) -> process(T, [B/A|Tail]);
process(["sqrt"|T],[A|Tail]) -> process(T, [math:sqrt(A)|Tail]);
process(["pow"|T], [A,B|Tail]) -> process(T, [math:pow(B,A)|Tail]);
process(["sin"|T],[A|Tail]) -> process(T, [math:sin(A)|Tail]);
process(["cos"|T], [A|Tail]) -> process(T, [math:cos(A)|Tail]);
process(["tan"|T], [A|Tail]) -> process(T, [math:tan(A)|Tail]);
process([H|T], B) -> process(T, [list_to_integer(H)|B]).


