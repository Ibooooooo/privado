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
