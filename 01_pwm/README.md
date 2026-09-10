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

## Medición experimental

La señal PWM fue medida físicamente en la salida JA1 de la
Arty Z7-10 mediante un osciloscopio.

La frecuencia medida fue de aproximadamente 1,000 kHz para
todos los valores de duty cycle.

| Duty seleccionado | Duty medido | Frecuencia |
|---:|---:|---:|
| 10% | 10,4% | 1,000 kHz |
| 30% | 30,4% | 1,000 kHz |
| 50% | 50,4% | 1,000 kHz |
| 70% | 70,4% | 1,000 kHz |
| 90% | 90,4% | 1,000 kHz |

### 10%

![PWM 10%](images/pwm_10.png)

### 30%

![PWM 30%](images/pwm_30.png)

### 50%

![PWM 50%](images/pwm_50.png)

### 70%

![PWM 70%](images/pwm_70.png)

### 90%

![PWM 90%](images/pwm_90.png)