package com.darkcode.spring.app;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FotoConfig 
{
    @Bean
    public Foto fotoOcio1() 
    {
        return new OcioFoto("Vacaciones en la playa");
    }

    @Bean
    public Foto fotoTrabajo1() 
    {
        return new TrabajoFoto("Presentación en la empresa");
    }

    @Bean
    public Foto fotoArte1()
    {
        return new ArteFoto("Pintura surrealista");
    }

    @Bean
    public Foto fotoOcio2() 
    {
        return new OcioFoto("Excursión al bosque");
    }

    @Bean
    public Foto fotoTrabajo2() 
    {
        return new TrabajoFoto("Proyecto en equipo");
    }

    @Bean
    public Foto fotoArte2() 
    {
        return new ArteFoto("Exposición de arte moderno");
    }
}
