package com.darkcode.spring.app;


public class ArteFoto implements Foto 
{
    private final String nombre;

    public ArteFoto(String nombre) {
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
        return 'A'; 
    }
}