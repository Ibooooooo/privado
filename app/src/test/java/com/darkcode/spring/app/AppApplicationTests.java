package com.darkcode.spring.app;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class AppApplicationTests 
{
    @Autowired
    private RedSocial redSocial;

    @Test
    void contextLoads() 
	{
        // Nos aseguramos que la red social fue inyectada correctamente
        assertThat(redSocial).isNotNull();
    }

    @Test
    void todasLasFotosEstanInyectadas() 
	{
        List<Foto> fotos = redSocial.getFotos();

        // Esperamos al menos 1 foto por tipo
        assertThat(fotos).isNotEmpty();

        boolean tieneOcio = fotos.stream().anyMatch(f -> f instanceof OcioFoto);
        boolean tieneTrabajo = fotos.stream().anyMatch(f -> f instanceof TrabajoFoto);
        boolean tieneArte = fotos.stream().anyMatch(f -> f instanceof ArteFoto);
        boolean tieneComponent = fotos.stream().anyMatch(f -> f instanceof FotoComponent);

        assertThat(tieneOcio).isTrue();
        assertThat(tieneTrabajo).isTrue();
        assertThat(tieneArte).isTrue();
        assertThat(tieneComponent).isTrue();
    }
}
