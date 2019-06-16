/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dailynews.controller;

import java.io.IOException;
import java.io.StringWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

/**
 *
 * @author burakzengin
 */
@Service
public class Services {

    public List<News> getNews() throws MalformedURLException, ProtocolException, IOException {

        List<News> newsList = new ArrayList<>();
        String urlNews = "https://www.trtworld.com/europe";
        Document doc = Jsoup.connect(urlNews).get();

        // Headers
        Elements hTags = doc.select("h4");
        for (int i = 10; i <= hTags.size(); i++) {
            hTags.remove(hTags.size() - 1);
        }
        hTags.remove(0);
        hTags.remove(0);

        // Content
        Elements pTags = doc.select("p");
        for (int i = 10; i <= pTags.size(); i++) {
            pTags.remove(pTags.size() - 1);
        }

        // Images
        Elements imgTags = doc.getElementsByClass("img-responsive lazy preview");
        imgTags.remove(imgTags.size() - 1);
        imgTags.remove(imgTags.size() - 1);

        // Links
        Elements aTags = doc.getElementsByClass("col-xs-12 latestArticle no-gutters bg-w item");

        int i = 0;
        while (i < 12) {
            newsList.add(new News(hTags.get(i).toString(), pTags.get(i).toString(), imgTags.get(i).attr("data-src"), "https://www.trtworld.com" + aTags.get(i).select("a").attr("href")));
            i++;
        }

        //System.out.println(hTags.toString());
        //System.out.println(pTags.toString());
        //System.out.println(imgTags.toString());
        //System.out.println(aTags.get(i).select("a").attr("href"));
        return newsList;
    }

    public Currency getCurrency() throws MalformedURLException, ProtocolException, IOException {

        double usdToTl, usdToEur, tlToUsd, tlToEur, eurToTl, eurToUsd;

        String urlCurrency = "https://api.exchangeratesapi.io/latest?base=TRY";
        String body = Jsoup.connect(urlCurrency).ignoreContentType(true).execute().body();
        JSONObject jsonObj = new JSONObject(body);
        tlToUsd = jsonObj.getJSONObject("rates").getDouble("USD");
        tlToEur = jsonObj.getJSONObject("rates").getDouble("EUR");

        String urlCurrency2 = "https://api.exchangeratesapi.io/latest?base=USD";
        String body2 = Jsoup.connect(urlCurrency2).ignoreContentType(true).execute().body();
        JSONObject jsonObj2 = new JSONObject(body2);
        usdToTl = jsonObj2.getJSONObject("rates").getDouble("TRY");
        usdToEur = jsonObj2.getJSONObject("rates").getDouble("EUR");

        String urlCurrency3 = "https://api.exchangeratesapi.io/latest?base=EUR";
        String body3 = Jsoup.connect(urlCurrency3).ignoreContentType(true).execute().body();
        JSONObject jsonObj3 = new JSONObject(body3);
        eurToTl = jsonObj3.getJSONObject("rates").getDouble("TRY");
        eurToUsd = jsonObj3.getJSONObject("rates").getDouble("USD");

        return new Currency(usdToTl, usdToEur, tlToUsd, tlToEur, eurToTl, eurToUsd);
    }

    public int getWeather() throws MalformedURLException, IOException {

        String urlWeather = "http://api.openweathermap.org/data/2.5/weather?q=Manisa,tr&units=metric&appid=843bf59b9493d4c944bbd3d4c56de054";

        URL obj2 = new URL(urlWeather);
        HttpURLConnection con2 = (HttpURLConnection) obj2.openConnection();
        con2.setRequestMethod("GET");
        con2.setRequestProperty("User-Agent", "Mozilla/5.0");
        int responseCode2 = con2.getResponseCode();
        if (responseCode2 == 200) {
            StringWriter writer = new StringWriter();
            IOUtils.copy(con2.getInputStream(), writer, "UTF-8");
            String theString = writer.toString();
            JSONObject jsonObj = new JSONObject(theString);
            int weather = jsonObj.getJSONObject("main").getInt("temp");
            return weather;
        }
        con2.disconnect();
        return -1;
    }
}
