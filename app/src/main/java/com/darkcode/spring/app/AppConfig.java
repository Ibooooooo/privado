package com.darkcode.spring.app;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import java.util.*;

@Configuration
@PropertySource("classpath:application.properties")
public class AppConfig 
{
    @Bean
    public List<Foto> fotos(
            @Value("#{'${foto.ocio}'.split(',')}")  List<String> ocio,
            @Value("#{'${foto.trabajo}'.split(',')}") List<String> trabajo,
            @Value("#{'${foto.arte}'.split(',')}")    List<String> arte) 
    {
        List<Foto> lista = new ArrayList<>();
        ocio   .forEach(n -> lista.add(new OcioFoto(n.trim())));
        trabajo.forEach(n -> lista.add(new TrabajoFoto(n.trim())));
        arte   .forEach(n -> lista.add(new ArteFoto(n.trim())));
        return lista;
    }

    @Bean
    public RedSocial redSocial(List<Foto> fotos)
    {
        return new RedSocial(fotos);
    }

    @Bean
    public RedSocialController redSocialController(RedSocial servicio) 
    {
        return new RedSocialController(servicio);
    }
}
