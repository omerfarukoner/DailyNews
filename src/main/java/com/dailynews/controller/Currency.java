/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dailynews.controller;

/**
 *
 * @author burakzengin
 */
public class Currency {

    double usdToTl;
    double usdToEur;
    double tlToUsd;
    double tlToEur;
    double eurToTl;
    double eurToUsd;

    public Currency(double usdToTl, double usdToEur, double tlToUsd, double tlToEur, double eurToTl, double eurToUsd) {
        this.usdToTl = usdToTl;
        this.usdToEur = usdToEur;
        this.tlToUsd = tlToUsd;
        this.tlToEur = tlToEur;
        this.eurToTl = eurToTl;
        this.eurToUsd = eurToUsd;
    }

    public double getUsdToTl() {
        return usdToTl;
    }

    public void setUsdToTl(double usdToTl) {
        this.usdToTl = usdToTl;
    }

    public double getUsdToEur() {
        return usdToEur;
    }

    public void setUsdToEur(double usdToEur) {
        this.usdToEur = usdToEur;
    }

    public double getTlToUsd() {
        return tlToUsd;
    }

    public void setTlToUsd(double tlToUsd) {
        this.tlToUsd = tlToUsd;
    }

    public double getTlToEur() {
        return tlToEur;
    }

    public void setTlToEur(double tlToEur) {
        this.tlToEur = tlToEur;
    }

    public double getEurToTl() {
        return eurToTl;
    }

    public void setEurToTl(double eurToTl) {
        this.eurToTl = eurToTl;
    }

    public double getEurToUsd() {
        return eurToUsd;
    }

    public void setEurToUsd(double eurToUsd) {
        this.eurToUsd = eurToUsd;
    }

}
