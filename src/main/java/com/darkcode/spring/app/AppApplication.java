package com.darkcode.spring.app;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.*;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

public class AppApplication 
{
    public static void main(String[] args) throws Exception 
    {
        // Crear contexto Spring y registrar configuración 
        AnnotationConfigWebApplicationContext ctx =new AnnotationConfigWebApplicationContext();
        ctx.register(AppConfig.class);          // clase @Configuration
        ctx.scan("com.darkcode.spring.app");    // para que detecte @Component
        ctx.refresh();

        // Configurar DispatcherServlet
        DispatcherServlet servlet = new DispatcherServlet(ctx);

        // Montar Jetty server 
        Server server = new Server(8080);
        ServletContextHandler handler = new ServletContextHandler();
        handler.addServlet(new ServletHolder(servlet), "/*");
        server.setHandler(handler);

        // Arrancamos el servidor
        try {
            server.start();
            server.join();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            server.destroy();
        }
    }
}
