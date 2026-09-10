# PWM en Arty Z7-10

Proyecto de generación de una señal PWM utilizando una FPGA
Digilent Arty Z7-10 y Vivado 2018.1.

## Objetivo

Generar una señal PWM de 1 kHz con diferentes ciclos de trabajo
(duty cycle), controlados mediante botones de la placa.

## Hardware

- FPGA: Digilent Arty Z7-10
- FPGA: Zynq-7000
- Reloj del sistema: 125 MHz
- Frecuencia PWM: 1 kHz
- Salida PWM: Pmod JA1

## Ciclo de trabajo

El proyecto permite seleccionar:

- 0%
- 10%
- 20%
- 30%
- 40%
- 50%
- 60%
- 70%
- 80%
- 90%
- 100%

## Controles

| Botón | Función |
|---|---|
| BTN0 | Aumentar duty |
| BTN1 | Disminuir duty |
| BTN2 | Reservado para frecuencia |
| BTN3 | Reset |

## Archivos

```text
01_pwm/
├── fuentes/
│   ├── pwm.vhdl
│   └── pwm_tb.vhdl
├── constraints/
│   └── pwm_arty7.xdc
└── README.md