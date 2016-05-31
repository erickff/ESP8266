wifi.setmode(wifi.STATION)
wifi.sta.config("NOME_REDE","SENHA_REDE")
wifi.sta.connect()

-- Definicao de pino do DHT22
PIN = 4 --  data pin, GPIO2
dht22 = require("dht22_min")
chipserial = node.chipid()

-- Cria e roda o web server
srv=net.createServer(net.TCP, 4)
print("Server created on " .. wifi.sta.getip())
srv:listen(80,function(conn)
conn:on("receive",function(conn,request)
print(request)

-- Le as informacoes do sensor de temperatura
dht22.read(PIN)
t = dht22.getTemperature()
h = dht22.getHumidity()

conn:send('<html>')
conn:send('<title>NodeMCU - Arduino e Cia</title></head>')
conn:send('<meta http-equiv="refresh" content="5">')
conn:send('<body bgcolor=\"#ffffff\">')
conn:send('<center>')
conn:send('<table bgcolor=\"#0000ff\" width=\"90%\" border=\"0\">')
conn:send('<tr>')
conn:send('  <td><font size=\"3\" face=\"arial, helvetica\" color=\"#ffffff\"><center>Temperatura</center></font></td>')
conn:send('</tr>')
conn:send('<tr>')
conn:send('  <td><font size=\"7\" face=\"arial, helvetica\" color=\"#ffffff\"><center>'..((t-(t % 10)) / 10).."."..(t % 10)..'&deg;C</center></font></td>')
conn:send('</tr>')
conn:send('<tr>')
conn:send('  <td><font size=\"3\" face=\"arial, helvetica\" color=\"#ffffff\"><center>Umidade</center></font></td>')
conn:send('</tr>')
conn:send('<tr>')
conn:send('  <td><font size=\"5\" face=\"arial, helvetica\" color=\"#ffffff\"><center>'..((h - (h % 10)) / 10).."."..(h % 10)..'%</center></font></td>')
conn:send('</tr>')
conn:send('</table>')
conn:send('</center>')
conn:send('</body></html>')
end)