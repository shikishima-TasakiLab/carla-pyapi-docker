# CARLA-PythonAPI in Docker

## Environment

|Software      |Version  |
|--------------|:-------:|
|Docker        |19.03&le;|
|NVIDIA-Docker2|&minus;  |
|CARLA         |0.9.10.1 |

## Setup

```bash
git clone https://github.com/shikishima-TasakiLab/carla-pyapi-docker.git
cd carla-pyapi-docker
```

## Build Docker Image

```bash
./build-docker.sh
```

## Run Docker Image

```
./run-docker.sh
```
|Option          |Explanation                       |
|----------------|----------------------------------|
|`-h`, `--help`  |Display how to use                |
|`-s`, `--server`|Launch CARLA server simultaneously|
