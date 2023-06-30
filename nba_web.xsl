<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:n="vse.cz:hosj03:nba"
    exclude-result-prefixes="xs n"
    version="2.0">
    
    <xsl:output method="html" version="5"/>
    <xsl:output method="html" version="5" name="html5"/>
    
    <xsl:template match="/">
        <html lang="cs">
            <head>
                <title>
                    NBA
                </title>
                
                <link rel="stylesheet" href="style.css"/>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="n:tymy">
        <section>
            <h1>NBA Týmy</h1>
            <ul id="tymList">
                <xsl:apply-templates/>
            </ul>
        </section>
    </xsl:template>
    
    <xsl:template match="n:tym">
        <li class="tym">
            <dl>
                <dt>
                    <xsl:text>Název</xsl:text>
                </dt>
                <dd>
                    <xsl:value-of select="n:nazev"/>
                </dd>
                <dt>
                    <xsl:text>Zkatka</xsl:text>
                </dt>
                <dd>
                    <xsl:value-of select="n:zkratka"/>
                </dd>
                <dt>
                    <xsl:text>Hráči</xsl:text>
                </dt>
                <dd>
                    <a href="{generate-id(n:hraci)}.html">
                        <xsl:text>Rozpis</xsl:text>
                    </a>
                    <xsl:apply-templates/>
                </dd>
            </dl>
        </li>
    </xsl:template>
    
    <xsl:template match="n:tym/n:hraci">
        <xsl:result-document href="{generate-id()}.html" format="html5">
            <html lang="cs">
                <head>
                    <title>
                        <xsl:text>Soupiska</xsl:text>
                    </title>
                    <link rel="stylesheet" href="style.css"/>
                </head>
                <body>
                    <a href="nba_hl.html">Hlavní stránka</a>
                    <h1>
                        <xsl:value-of select="../n:nazev"/>
                    </h1>
                    <ul id="hraci">
                        <xsl:apply-templates/>
                    </ul>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="n:hrac">
        <li class="hrac">
            <dl>
                <dt>
                    <xsl:text>Jméno</xsl:text>
                </dt>
                <dd>
                    <xsl:value-of select="n:jmeno"/>
                </dd>
                <dt>
                    <xsl:text>Přijmení</xsl:text>
                </dt>
                <dd>
                    <xsl:value-of select="n:prijmeni"/>
                </dd>
                <dt>
                    <xsl:text>Číslo dresu</xsl:text>
                </dt>
                <dd>
                    <xsl:value-of select="n:cisloDresu"/>
                </dd>
            </dl>
        </li>
    </xsl:template>
    
    <xsl:template match="n:zapasy">
        <section>
            <h1>NBA zápasy <xsl:value-of select="@sezonaZacatek"/> - <xsl:value-of select="@sezonaKonec"/></h1>
            <ol>
                <xsl:apply-templates/>
            </ol>
        </section>
    </xsl:template>
    
    <xsl:template match="n:zapas">
        <li class="zapas">
            <h2>
                <xsl:apply-templates select="n:domaci|n:hoste"/>
            </h2>
            <p>
                <xsl:value-of select="n:datum"/>
            </p>
            <p>
                <xsl:apply-templates select="n:vysledneSkore"/>
            </p>
            <a href="{generate-id(./n:prubeh)}.html">
                <xsl:text>Průběh</xsl:text>
            </a>
            <xsl:apply-templates select="n:prubeh"/>
        </li>
    </xsl:template>
    
    <xsl:template match="n:domaci">
        <xsl:value-of select="../../../n:tymy/n:tym[@id = current()/@id]/n:zkratka"/>
        <xsl:text> : </xsl:text>
    </xsl:template>
    
    <xsl:template match="n:hoste">
        <xsl:value-of select="../../../n:tymy/n:tym[@id = current()/@id]/n:zkratka"/>
    </xsl:template>
    
    <xsl:template match="n:vysledneSkore">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="n:vysledneSkore/n:domaci">
        <xsl:value-of select="."/>
        <xsl:text> : </xsl:text>
    </xsl:template>
    
    <xsl:template match="n:vysledneSkore/n:hoste">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="n:prubeh">
        <xsl:result-document href="{generate-id()}.html" format="html5">
            <html lang="cs">
                <head>
                    <title>
                        <xsl:text>Průběh</xsl:text>
                    </title>
                    <link rel="stylesheet" href="style.css"/>
                </head>
                <body>
                    <a href="nba_hl.html">Hlavní stránka</a>
                    <h1>
                        <xsl:value-of select="../../../n:tymy/n:tym[@id = current()/../n:domaci/@id]/n:nazev"/>
                        <xsl:text> : </xsl:text>
                        <xsl:value-of select="../../../n:tymy/n:tym[@id = current()/../n:hoste/@id]/n:nazev"/>
                    </h1>
                    <ol>
                        <xsl:apply-templates/>
                    </ol>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="n:ctvrtina">
        <li class="ctvrtina">
            <h2>
                <xsl:value-of select="@poradi"/>
                <xsl:text>. čtvrtina</xsl:text>
            </h2>
            <ul>
                <xsl:apply-templates/>
            </ul>
        </li>
    </xsl:template>
    
    <xsl:template match="n:kos">
        <xsl:variable name="tymvar">
            <xsl:choose>
                <xsl:when test="(n:tym = ../../../../../n:tymy/n:tym[@id = current()/../../../n:domaci/@id]/n:nazev)">
                   <xsl:text>domaci</xsl:text>
                </xsl:when>
                <xsl:when test="(n:tym = ../../../../../n:tymy/n:tym[@id = current()/../../../n:domaci/@id]/n:zkratka)">
                    <xsl:text>domaci</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>hoste</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <li class="kos {$tymvar}" >
            <h3>
                <xsl:text>Koš</xsl:text>
            </h3>
            <p>
                <xsl:value-of select="n:cas"/>
            </p>
            <p>
                <xsl:value-of select="n:body"/>
            </p>
            <p>
                <xsl:value-of select="n:tym"/>
            </p>
        </li>
    </xsl:template>
    
    <xsl:template match="n:faul">
        <li class="faul">
            <h3>
                <xsl:text>Faul</xsl:text>
            </h3>
            <p>
                <xsl:value-of select="n:cas"/>
            </p>
            <p>
                <xsl:value-of select="n:hrac"/>
            </p>
            <p>
                <xsl:value-of select="@typ"/>
            </p>
        </li>
    </xsl:template>
    
    <xsl:template match="n:nazev"/>
    
    <xsl:template match="n:zkratka"/>
    
</xsl:stylesheet>