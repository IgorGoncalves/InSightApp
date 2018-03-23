# InSight

[![video](http://img.youtube.com/vi/CUIuW1hwwu8/0.jpg)](http://www.youtube.com/watch?v=CUIuW1hwwu8)


## A locomoção em novos ambientes

Quando apresentado a um novo ambiente interno, o deficiente visual pode contar
poucos rescursos de localização, atualmente:

- Piso texturizado
- Placas com mapa em alto-relevo para memorização


## Os problemas

- Piso texturizado indica uma zona segura para onde ir, mas não dá indicativos do
local onde se está

- Placas em altorelevo podem ser confusas e o deficiente pode nunca sequer encontrá-las

![grafico de pessoas com deficiencia visual](https://github.com/IgorGoncalves/insight.github.io/blob/master/assets/grafico_pessoas.png?raw=true)

## O que propomos

A proposta do nosso projeto é mapear e fornecer informações de localização em
ambientes internos, facilitando a locomoção de pessoas portadoras de deficiência
visual


## Como ?

Usando um app conectado a a tecnologia dos iBeacon's que seriam usados para
estimar a posição da pessoa e dos locais ao redor dela

![desenho de proposta](https://github.com/IgorGoncalves/insight.github.io/blob/master/desenho-projeto.jpg?raw=true)


## iBeacon

iBeacon é um disponsitivo que emite sinais Bluetooth que são captados pelos smatphones
que que tem a tecnologia de Bluetooth 4.0 (low energie)  ou superior. Podemos assim
estimar a distancia do beacon ao smartphone baseado na potência do sinal recebido

![beacon](https://igorgoncalves.github.io/insight.github.io/assets/beacon_blue.png)


## Posicionamento
Para estimar o posicionamento da pessoa em relaço as entradas e pontos de cogitamos algumas técnicas

### Posicionamento dos Beacons

Inicialmente pensamos em utilizar o posicionamento dos beacons para triangular a posição da pessoa em relaço a 3 beacons, mas encontramos então uma soluço mais simples.

![beacon](https://github.com/IgorGoncalves/insight.github.io/blob/master/assets/beaconsTriangle.png?raw=true)

### Bússola

Conhecendo a posição possível dos beacons em referência a sua posição relativa ao
celular e o polo magnético da terra podemos estimar a direção do local

![bussola](https://igorgoncalves.github.io/insight.github.io/assets/compass.png )


## Resultado

Ao fim dos 3 dias desenvolvimento pudemos criar um MVP capaz de tringular a posição do usuário e dizer os locais que estão na sua frente.

![imagem de protóripo](https://github.com/IgorGoncalves/insight.github.io/blob/master/assets/navtab.png?raw=true)
