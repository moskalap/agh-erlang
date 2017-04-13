%%%-------------------------------------------------------------------
%%% @author przemek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 31. mar 2017 23:07
%%%-------------------------------------------------------------------
-module(pollution).
-author("przemek").
-record(station, {geo_cord,name,measurement}).
-record(measurement, {temperature, date, others}).
-record(monitor, {by_name, by_cord, stations, id_count}).
%% API
-export([create_monitor/0,add_station/3]).
create_monitor()-> #monitor{
  by_name = maps:new(),
  by_cord = maps:new(),
  stations=maps:new(),
  id_count=0
}.



add_station(Monitor, Name, Cord) ->
  case {maps:is_key(Name, Monitor#monitor.by_name), maps:is_key(Cord, Monitor#monitor.by_cord)}  of
    {true, _} -> Monitor;
    {_,true}  -> Monitor;
        _ ->  #monitor{
  by_name = maps:put(Name,Monitor#monitor.id_count,Monitor#monitor.by_name),
  by_cord = maps:put(Cord,Monitor#monitor.id_count,Monitor#monitor.by_cord),
  stations = maps:put(Monitor#monitor.id_count, #station{
                                                        geo_cord = Cord,
                                                        name = Name,
                                                        measurement = []
                                                        },
                                                        Monitor#monitor.stations),
  id_count = Monitor#monitor.id_count+1

  }
  end.





%add_value(Monitor, Cord_or_Name, Date, Type, Value) ->
 % ID = get_ID(Cord_or_Name, Monitor),
  %maps:put

%  }


%remove_value(Monitor, ID, Date, Type) ->.
%get_one_value(Monitor, ID, Date, Type) ->.
%get_station_mean(Monitor, ID, Type) ->.
%get_daily_mean(Monitor, Type, Date)->.

get_ID(Cord_or_Name, Monitor) ->
  case Cord_or_Name of
    {_,_} ->maps:get(Cord_or_Name, Monitor#monitor.by_cord);
      _   ->maps:get(Cord_or_Name, Monitor#monitor.by_name)
  end.


%%%createMonitor/0 - tworzy i zwraca nowy monitor zanieczyszczeń;
%%%addStation/3 - dodaje do monitora wpis o nowej stacji pomiarowej (nazwa i współrzędne geograficzne), zwraca zaktualizowany monitor;
%%%addValue/5 - dodaje odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru, wartość), zwraca zaktualizowany monitor;
%%%removeValue/4 - usuwa odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru), zwraca zaktualizowany monitor;
%%%getOneValue/4 - zwraca wartość pomiaru o zadanym typie, z zadanej daty i stacji;
%%%getStationMean/3 - zwraca średnią wartość parametru danego typu z zadanej stacji;
%%%getDailyMean/3 - z