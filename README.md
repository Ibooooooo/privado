
# Ejemplo de Inyección de Dependencias con Spring en Java

Este ejemplo ilustra una red social simple construida con **Spring Framework** para mostrar el uso de **Inyección de Dependencias** en Java. En esta red social, los usuarios pueden publicar fotos clasificadas por tipo: `Ocio`, `Trabajo` y `Arte`.

## Implementación
---

El paquete principal del proyecto es:

```
com.darkcode.spring.app
```

### `Foto.java`

```java
package com.darkcode.spring.app;

public interface Foto 
{
    String getNombre();
    char getImagen();
} 
```

Interfaz común que define los métodos `getNombre()` y `getImagen()`.

Implementada por:
* OcioFoto.java
* ArteFoto.java
* TrabajoFoto.java

### `OcioFoto, ArteFoto y TrabajoFoto.java`

```java
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
```

`ArteFoto.java` y `TrabajoFoto.java` son prácticamente idénticas a `OcioFoto.java` la principal diferencia es que el método **getImagen()** devuelve una letra dependiendo del tipo de la foto.


### `RedSocial.java`

```java
package com.darkcode.spring.app;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class RedSocial 
{
    private final List<Foto> fotos;

    @Autowired
    public RedSocial(List<Foto> fotos) 
    {
        this.fotos = fotos;
    }

    public List<Foto> getFotos()
    {
        return fotos;
    }

    public String mostrarFotos() 
    {
        StringBuilder sb = new StringBuilder();
        for (Foto foto : fotos) {
            sb.append("<b>").append(foto.getNombre()).append("</b><br>");
            sb.append("<pre>");
            sb.append("+--------+\n");
            sb.append("|        |\n");
            sb.append("|   ").append(foto.getImagen()).append("    |\n");
            sb.append("|        |\n");
            sb.append("+--------+\n");
            sb.append("</pre><br>");
        }
        return sb.toString();
    }   
}
```
La clase RedSocial es un componente de servicio (anotado con `@Service`) que gestiona una colección de objetos Foto, los cuales representan diferentes tipos de imágenes.
Utilizamos `@Autowired` para que Spring realice la inyección automática de las fotos en su constructor. 
Tiene un método **mostrarFotos()** que genera una representación visual (en HTML simple) de cada foto.

### `RedSocialController.java`

```java
package com.darkcode.spring.app;

import org.springframework.web.bind.annotation.*;

@RestController           
public class RedSocialController 
{
    private final RedSocial redSocial;

    public RedSocialController(RedSocial redSocial) {
        this.redSocial = redSocial;      
    }

    @GetMapping("/fotos")
    public String mostrarFotosWeb() 
    {
        return redSocial.mostrarFotos();
    }
}

```

Controlador web con un endpoint que devuelve el resultado de `mostrarFotos()`.


La anotación `@RestController` le dice a Spring que esta clase es un controlador web y que todas las respuestas de sus métodos deben enviarse directamente como el cuerpo de la respuesta HTTP.
Con `@GetMapping("/fotos")` mapeamos solicitudes HTTP GET al método **mostrarFotosWeb()**.

### `AppConfig.java`

```java
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
```

La clase `AppConfig` es una clase de configuración de Spring (anotada con `@Configuration`) que define explícitamente los **beans** utilizados en la aplicación. También carga propiedades desde un archivo externo usando `@PropertySource`.

Lee los valores definidos en el archivo `application.properties`, donde se especifican listas de nombres para las distintas categorías de fotos (foto.ocio, foto.trabajo, foto.arte).

* Método fotos(...):
    - Utiliza las propiedades cargadas para crear objetos de tipo OcioFoto, TrabajoFoto y ArteFoto.

    - Devuelve una lista de objetos Foto con todos ellos.

    - Esta lista será inyectada automáticamente en otros componentes gracias a Spring.

* Bean RedSocial:

    - Declara una instancia de **RedSocial** inyectándole la lista de fotos generada por el método anterior.

* Bean RedSocialController:

    - Crea un controlador pasando la instancia de **RedSocial**, lo que permite acceder a la lógica de negocio desde el controlador web.

### `application.properties`

El archivo `application.properties` se utiliza para configurar los nombres de las fotos que se cargarán automáticamente al iniciar la aplicación.

Se encuentra en `src/main/resources/` y contiene lo siguiente:
```bash
spring.application.name=app

foto.ocio=Vacaciones en la playa,Excursión al bosque
foto.trabajo=Presentación en la empresa,Proyecto en equipo
foto.ocio=Excursión a la montaña
foto.arte=Pintura surrealista,Exposición de arte moderno
```

### `AppApplicationTests.java`

```java
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
```

La clase `AppApplicationTests` valida que la aplicación se configure correctamente y que las dependencias principales estén inyectadas por Spring.
Se ha usado `JUnit 5` y `AssertJ`.

## Implantación
---

- Para realizar los **test** y comprobar que se levanta la app en`http://localhost:8080`:
    1. En GitHub, ve a la sección **Actions**
    2. Selecciona en la barra lateral izquierda: `inyeccion.java-RITCHIE`
    3. Dale a **run workflow** y selecciona el botón verde donde pone **run workflow**

- Para **ejecutar** la app introduce los siguientes comandos en `temas/inyeccion/java`:
```bash
docker build -t redsocial-app .
docker run -p 8080:8080 redsocial-app
```
Al acceder a `http://localhost:8080` debería aparecer las fotos publicadas.

- Para borrarlo (limpieza) haz `Ctrl+C` en la terminal y ejecuta:
```bash
docker rm $(docker ps -a -q --filter ancestor=redsocial-app) 2>/dev/null
docker rmi redsocial-app
```