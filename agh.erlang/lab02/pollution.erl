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
-record(measurement, { temperature, pm2p5, pm10, pressure, humidity, others=[]}).
-record(monitor, {by_name, by_cord, stations, id_count}).
%% API
-export([create_monitor/0,test_creation_station/0,add_station/3,add_value/5]).
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
                                                        measurement = maps:new()
                                                        },
                                                        Monitor#monitor.stations),
  id_count = Monitor#monitor.id_count+1

  }
  end.





add_value(Monitor, Cord_or_Name, Date, Type, Value) ->
  Station = get_station(Monitor,Cord_or_Name),
  Measurement = get_measurment(Station,Date),

  case Type of
    "pm2.5"       ->  add_measurement(Monitor, Cord_or_Name, Date, Measurement#measurement{pm2p5 = Value}, Station);
    "pm10"        ->  add_measurement(Monitor, Cord_or_Name, Date, Measurement#measurement{pm10 = Value}, Station);
    "temperature" ->  add_measurement(Monitor, Cord_or_Name, Date, Measurement#measurement{temperature = Value}, Station);
    "pressure"    ->  add_measurement(Monitor, Cord_or_Name, Date, Measurement#measurement{pressure = Value}, Station);
    "humidity"    ->  add_measurement(Monitor, Cord_or_Name, Date, Measurement#measurement{humidity = Value}, Station);
    _             ->  Others = Measurement#measurement.others,
                      add_measurement(Monitor, Cord_or_Name, Date, Measurement#measurement{others = Others++[Value]}, Station)

  end.


 % ID = get_ID(Cord_or_Name, Monitor),
  %maps:put

%  }


%remove_value(Monitor, ID, Date, Type) ->.
%get_one_value(Monitor, ID, Date, Type) ->.
%get_station_mean(Monitor, ID, Type) ->.
%get_daily_mean(Monitor, Type, Date)->.
get_measurment(Station,Date)->
  maps:get(Date,Station#station.measurement, #measurement{}).

get_ID(Cord_or_Name, Monitor) ->
  case Cord_or_Name of
    {_,_} ->maps:get(Cord_or_Name, Monitor#monitor.by_cord);
      _   ->maps:get(Cord_or_Name, Monitor#monitor.by_name)
  end.

get_station(Monitor, Cord_Or_Name)->
  maps:get(get_ID(Cord_Or_Name, Monitor),Monitor#monitor.stations).
add_measurement(Monitor, Cord_or_Name, Date, Measurement, Station)->
  NewStation=Station#station{measurement = maps:put(Date,Measurement,Station#station.measurement)},
  Monitor#monitor{stations = maps:update(get_ID(Cord_or_Name,Monitor), NewStation, Monitor#monitor.stations)}.
test_creation_station()->
  M=create_monitor(),
  M1=add_station(M,"nazwa1",{12,31}),
  M2=add_station(M1,"nazwa2",{122,31}),
  M3=add_station(M2,"nazwa2",{122,318}),
  M4=add_station(M3,"nazwa3",{122,311}),
  M5=add_value(M4,"nazwa2","2017-04","pm2.5",23),
  M6=add_value(M5,"nazwa2","2017-04","pm10",23),
  M7=add_value(M6,"nazwa2","2017-04","temperature",30),
  M8=add_value(M7,"nazwa2","2017-04","pressure",70),
  M9=add_value(M8,"nazwa2","2017-04","humidity",60),
  M10=add_value(M9, {12,31},"2017-04","cośtam","ad"),
  M11=add_value(M10,"nazwa2","2017-05","pm2.5",45).



%%%createMonitor/0 - tworzy i zwraca nowy monitor zanieczyszczeń;
%%%addStation/3 - dodaje do monitora wpis o nowej stacji pomiarowej (nazwa i współrzędne geograficzne), zwraca zaktualizowany monitor;
%%%addValue/5 - dodaje odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru, wartość), zwraca zaktualizowany monitor;
%%%removeValue/4 - usuwa odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru), zwraca zaktualizowany monitor;
%%%getOneValue/4 - zwraca wartość pomiaru o zadanym typie, z zadanej daty i stacji;
%%%getStationMean/3 - zwraca średnią wartość parametru danego typu z zadanej stacji;
%%%getDailyMean/3 - z
