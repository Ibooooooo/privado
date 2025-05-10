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