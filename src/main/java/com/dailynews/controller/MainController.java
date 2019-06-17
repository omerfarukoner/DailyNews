/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dailynews.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import static javax.ws.rs.core.HttpHeaders.USER_AGENT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author burakzengin
 */
@Controller
public class MainController {

    @Autowired
    private Services services;

    @RequestMapping(value = {"/", "/home"})
    public String Home(Model m) throws IOException {

        URL obj = new URL("https://dailynewsserver.herokuapp.com");
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        // optional default is GET
        con.setRequestMethod("GET");
        //add request header
        con.setRequestProperty("User-Agent", USER_AGENT);

        m.addAttribute("currency", services.getCurrency());
        m.addAttribute("weather", services.getWeather());
        m.addAttribute("news", services.getNews());
        return "home";
    }
}
