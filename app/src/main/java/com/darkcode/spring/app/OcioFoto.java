package com.darkcode.spring.app;

public class OcioFoto implements Foto 
{

    private final String nombre;

    public OcioFoto(String nombre) {
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
        return 'O';
    }
}