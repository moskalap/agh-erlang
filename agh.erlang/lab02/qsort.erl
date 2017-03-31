%%%-------------------------------------------------------------------
%%% @author przemek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 31. mar 2017 13:10
%%%-------------------------------------------------------------------
-module(qsort).
-author("przemek").

%% API
-export([qs/1,lessThan/2,grtEqThan/2,randomElems/3,compareSpeeds/3]).
lessThan(List, Arg) -> [X || X<-List, X<Arg].
grtEqThan(List, Arg) -> [X || X<-List, X>=Arg].


qs([Pivot|Tail]) ->
  qs( lessThan(Tail,Pivot) ) ++ [Pivot] ++ qs(grtEqThan(Tail,Pivot));
qs([]) ->[].

randomElems(0, _, _)-> [];
randomElems(N, Min, Max) -> [random:uniform(Max-Min)+Min] ++ randomElems(N-1, Min, Max).

compareSpeeds(List, Fun1, Fun2) ->
  {Time1, _} = timer:tc(Fun1, [List]),
  {Time2, _} = timer:tc(Fun2, [List]),
  io:format("Time of Fun 1 = " ++integer_to_list(Time1) ++ " Time of Fun 2=" ++integer_to_list(Time2)).


