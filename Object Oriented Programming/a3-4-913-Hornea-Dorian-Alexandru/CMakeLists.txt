cmake_minimum_required(VERSION 3.21)
project(a3_4_913_Hornea_Dorian_Alexandru C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(a3_4_913_Hornea_Dorian_Alexandru
        domain.c
        domain.h
        main.c
        repository.c
        repository.h
        service.c
        service.h
        dynamicArray.c
        dynamicArray.h
        ui.c
        ui.h)
