package com.darkcode.spring.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RedSocialController 
{
    @Autowired
    private RedSocial redSocial;

    @GetMapping("/fotos")
    public String mostrarFotosWeb() 
    {
        return redSocial.mostrarFotos();
    }
}
