package com.darkcode.spring.app;

import org.springframework.stereotype.Component;

@Component
public class FotoComponent implements Foto 
{
    @Override
    public String getNombre() 
    {
        return "Foto credada por Spring automáticamente";
    }

    @Override
    public char getImagen() 
    {
        return 'S';
    }
}
