package com.darkcode.spring.app;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.*;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

public class AppApplication 
{
    public static void main(String[] args) throws Exception 
    {
        /* 1. Crear contexto Spring y registrar configuración */
        AnnotationConfigWebApplicationContext ctx =new AnnotationConfigWebApplicationContext();
        ctx.register(AppConfig.class);          // tu clase @Configuration
        ctx.scan("com.darkcode.spring.app");    // para que detecte @Component
        ctx.refresh();

        /* 2. Configurar DispatcherServlet */
        DispatcherServlet servlet = new DispatcherServlet(ctx);

        /* 3. Montar Jetty */
        Server server = new Server(8080);
        ServletContextHandler handler = new ServletContextHandler();
        handler.addServlet(new ServletHolder(servlet), "/*");
        server.setHandler(handler);

        /* 4. Arrancar */
        server.start();
        System.out.println("Servidor iniciado en http://localhost:8080");
        server.join();
    }
}
