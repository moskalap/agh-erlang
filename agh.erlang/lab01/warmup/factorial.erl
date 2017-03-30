%%%-------------------------------------------------------------------
%%% @author przemek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Mar 2017 22:08
%%%-------------------------------------------------------------------
-module(factorial).
-author("przemek").

%% API
-export([fact/1]).
fact(N) when N>0 -> N * fact(N-1);
fact(0) -> 1.


