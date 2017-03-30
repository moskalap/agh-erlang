%%%-------------------------------------------------------------------
%%% @author przemek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. Mar 2017 22:27
%%%-------------------------------------------------------------------
-module(myFunctions).
-author("przemek").

%% API
-export([power/2,contains/2,divisibleBy/2]).
power(A,N)->A*power(A,N-1);
power(A,0)->1.

contains([A|T], A) ->true;
contains([],A) -> false;
contains([H|T],A) ->contains(T,A).

duplicateElements([]) -> [];
duplicateElements([H|T]) ->[H,H|duplicateElements(T)].

divisibleBy([], A)->[];
divisibleBy([H|T],A) when H rem A == 0 -> [H|divisibleBy(T,A)];
divisibleBy([H|T],A) -> divisibleBy(T,A).

toBinary(0)-> [];
toBinary(N)->
  case N rem 2 of
    0->[0|toBinary(N div 2)];
    1->[1|toBinary(N div 2)]
  end.


