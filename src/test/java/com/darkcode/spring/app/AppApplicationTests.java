package com.darkcode.spring.app;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

class AppApplicationTests 
{
    private RedSocial redSocial;

    @BeforeEach
    void setUp() {
        // Carga el contexto Spring desde una clase de configuración
        ApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        redSocial = context.getBean(RedSocial.class);
    }

    @Test
    void contextLoads() 
    {
        assertThat(redSocial).isNotNull();
    }

    @Test
    void todasLasFotosEstanInyectadas() 
    {
        List<Foto> fotos = redSocial.getFotos();

        assertThat(fotos).isNotEmpty();

        boolean tieneOcio = fotos.stream().anyMatch(f -> f instanceof OcioFoto);
        boolean tieneTrabajo = fotos.stream().anyMatch(f -> f instanceof TrabajoFoto);
        boolean tieneArte = fotos.stream().anyMatch(f -> f instanceof ArteFoto);

        assertThat(tieneOcio).isTrue();
        assertThat(tieneTrabajo).isTrue();
        assertThat(tieneArte).isTrue();
    }
}
