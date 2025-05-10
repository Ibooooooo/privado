package com.darkcode.spring.app;

public class TrabajoFoto implements Foto 
{
    private final String nombre;

    public TrabajoFoto(String nombre) {
        this.nombre = nombre;
    }

    @Override
    public String getNombre() 
    {
        return nombre;
    }

    @Override
    public char getImagen() 
    {
        return 'T'; 
    }
}