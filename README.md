
# Ejemplo de Inyección de Dependencias con Spring en Java

Este ejemplo ilustra una red social simple construida con **Spring Boot** para mostrar el uso de **Inyección de Dependencias** en Java. En esta red social, los usuarios pueden publicar fotos clasificadas por tipo: `Ocio`, `Trabajo` y `Arte`.

La idea central es mostrar cómo **Spring administra e inyecta objetos automáticamente**, utilizando diversas anotaciones como `@Component`, `@Autowired`, `@Bean`, `@Configuration` y `@SpringBootTest`.

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
* FotoComponent.java

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

### `FotoComponent.java`

```java
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

```

Clase especial anotada con `@Component` que representa una foto automática del sistema.
Se utiliza `@Component` para registrar automáticamente una instancia de tipo `Foto` en el contexto de Spring.

### `RedSocial.java`

```java
package com.darkcode.spring.app;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class RedSocial 
{
    private final List<Foto> fotos;

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
Clase que contiene una lista de fotos y un método para mostrarlas.
La anotación `@Service` en Spring se utiliza para marcar una clase como un componente de servicio, es decir, 
Spring detecta automáticamente esta clase durante el escaneo de paquetes y la registra en el contenedor como un **bean**, lo que permite que sea **inyectada en otras partes de la aplicación**.

### `FotoConfig.java`

```java
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
```

La clase **FotoConfig** es una clase de configuración de Spring que define beans para los diferentes tipos de Foto. La anotación `@Configuration` al inicio de la clase indica a Spring que contiene las definiciones de los **Beans**. Junto a `@Bean` le indicamos a Spring *explícitamente* los objetos `Foto` que debe gestionar.

### `RedSocialController.java`

```java
package com.darkcode.spring.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RedSocialController 
{
    @Autowired
    private RedSocial redSocial;

    @GetMapping("/fotos") // Asocia la ruta /fotos con el método
    public String mostrarFotosWeb() 
    {
        return redSocial.mostrarFotos();
    }
}
```

Controlador web con un endpoint que devuelve el resultado de `mostrarFotos()`.
La anotación `@RestController` le dice a Spring que esta clase es un controlador web y que todas las respuestas de sus métodos deben enviarse directamente como el cuerpo de la respuesta HTTP.
Con `@Autowired` inyectamos dependencias de forma automática. Gracias a que `RedSocial` está anotada con `@Service`, Spring la detecta y la puede inyectar aquí.
Y con `@GetMapping("/fotos")` mapeamos solicitudes HTTP GET al método **mostrarFotosWeb()**.

### `AppApplicationTests.java`

Test con `@SpringBootTest` que verifica que las fotos se inyectan correctamente.


## Implantación
---

- Para realizar los **test** y comprobar que se levanta la app en`http://localhost:8080/fotos`:
    1. En GitHub, ve a la sección **Actions**
    2. Selecciona en la barra lateral izquierda: `inyeccion.java-RITCHIE`
    3. Dale a **run workflow** y selecciona el botón verde donde pone **run workflow**

- Para **ejecutar** la app introduce los siguientes comandos en `temas/inyeccion/java`:
```bash
docker build -t redsocial-app .
docker run -p 8080:8080 redsocial-app
```
Al acceder a `http://localhost:8080/fotos` debería aparecer las fotos publicadas.

- Para borrarlo (limpieza) haz `Ctrl+C` en la terminal y ejecuta:
```bash
docker rm $(docker ps -a -q --filter ancestor=redsocial-app) 2>/dev/null
docker rmi redsocial-app
```

