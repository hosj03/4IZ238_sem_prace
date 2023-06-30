<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:n="vse.cz:hosj03:nba"
    exclude-result-prefixes="xs n"
    version="2.0">
    
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <fo:root font-family="Arial" language="cs">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="a4" page-height="297mm" page-width="210mm" margin="10mm">
                    <fo:region-body margin="5mm"/>
                    <fo:region-before extent="5mm"/>
                    <fo:region-after extent="5mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="a4">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="right">
                        <xsl:text>Jakub Hošek</xsl:text>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center">
                        <fo:page-number/>
                        <xsl:text>. Strana</xsl:text>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" font-family="Arial">
                    <xsl:apply-templates/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <xsl:template match="n:tymy">
        <fo:block font-size="140%" font-weight="bold" id="idTymyTabulka">
            NBA Týmy
        </fo:block>
        <fo:table border="1px solid gray" width="90%" padding="1em" padding-top="5px" padding-bottom="5px">
            <fo:table-header font-weight="bold">
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            ID
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            Název
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            Zkratka
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:for-each select="n:tym">
                    <xsl:sort select="@id" data-type="number"></xsl:sort>
                    <fo:table-row>
                        <xsl:if test="position() mod 2">
                            <xsl:attribute name="background-color">
                                <xsl:text>rgb(200, 200, 200)</xsl:text>
                            </xsl:attribute>
                        </xsl:if>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="@id"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="n:nazev"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="n:zkratka"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                          <fo:block>
                              <fo:basic-link internal-destination="idHraciTymu{@id}" color="blue">
                                  Soupiska
                              </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>
        <fo:block font-size="140%" font-weight="bold" space-before="1em">
            Soupisky týmů
        </fo:block>
        <xsl:apply-templates select="n:tym/n:hraci"/>
    </xsl:template>
    
    <xsl:template match="n:hraci">
        <fo:block font-size="110%" font-weight="bold" id="idHraciTymu{../@id}" keep-with-next="always">
            <xsl:value-of select="../n:nazev"/>
        </fo:block>
        <fo:table border="1px solid gray" width="90%" padding="1em" padding-top="5px" padding-bottom="5px" table-layout="fixed">
            <fo:table-column column-width="30%"/>
            <fo:table-column column-width="30%"/>
            <fo:table-column column-width="30%"/>
            <fo:table-header font-weight="bold">
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            Jméno
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            Příjmení
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            Číslo dresu
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:for-each select="n:hrac">
                    <xsl:sort select="n:prijmeni" data-type="text"/>
                    <fo:table-row>
                        <xsl:if test="position() mod 2">
                            <xsl:attribute name="background-color">
                                <xsl:text>rgb(200, 200, 200)</xsl:text>
                            </xsl:attribute>
                        </xsl:if>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="n:jmeno"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="n:prijmeni"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="n:cisloDresu"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>
        <fo:block text-align="right" keep-with-previous="always">
            <fo:basic-link internal-destination="idTymyTabulka">
                <fo:external-graphic src="url(file:///E:\Škola\VŠE\4. semestr\XML - Teorie a praxe značkovacích jazyků (4IZ238)\semestralni_prace\dum.png)" width="2.5%" height="5%" content-width="2.5%" content-height="3%" vertical-align="middle" text-align="center"/>
            </fo:basic-link>
        </fo:block>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="n:zapasy">
        <fo:block font-size="140%" font-weight="bold" page-break-before="always" id="idSezony{@sezonaZacatek}">
            Sezóna od <xsl:value-of select="@sezonaZacatek"/> do <xsl:value-of select="@sezonaKonec"/>
        </fo:block>
        <fo:table border="1px solid gray" width="95%" padding="1em" padding-top="5px" padding-bottom="5px" table-layout="fixed">
            <fo:table-column column-width="55%"/>
            <fo:table-column column-width="18%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="10%"/>
            <fo:table-header font-weight="bold">
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            Týmy
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            Datum konání
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            Výsledek
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:for-each select="n:zapas">
                    <xsl:sort select="n:datum" data-type="number"/>
                    <fo:table-row>
                        <xsl:if test="position() mod 2">
                            <xsl:attribute name="background-color">
                                <xsl:text>rgb(200, 200, 200)</xsl:text>
                            </xsl:attribute>
                        </xsl:if>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="../../n:tymy/n:tym[@id = current()/n:domaci/@id]/n:nazev"/>
                                <xsl:text> : </xsl:text>
                                <xsl:value-of select="../../n:tymy/n:tym[@id = current()/n:hoste/@id]/n:nazev"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="n:datum"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="n:vysledneSkore/n:domaci"/>
                                <xsl:text>:</xsl:text>
                                <xsl:value-of select="n:vysledneSkore/n:hoste"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <fo:basic-link internal-destination="idPrubehZapasu{n:domaci/@id}{n:hoste/@id}{n:datum}" color="blue">
                                    Průběh
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>
        <fo:block font-size="120%" font-weight="bold" padding-top="1em" keep-with-next="always">
            Průběhy zápasů
        </fo:block>
        <xsl:apply-templates select="n:zapas/n:prubeh"/>
    </xsl:template>
    
    <xsl:template match="n:prubeh">
        <fo:block font-size="120%" font-weight="bold" padding-top="1em" keep-with-next="always" id="idPrubehZapasu{../n:domaci/@id}{../n:hoste/@id}{../n:datum}">
            <xsl:value-of select="../../../n:tymy/n:tym[@id = current()/../n:domaci/@id]/n:zkratka"/>
            <xsl:text> : </xsl:text>
            <xsl:value-of select="../../../n:tymy/n:tym[@id = current()/../n:hoste/@id]/n:zkratka"/>
        </fo:block>
        <xsl:for-each select="n:ctvrtina">
            <xsl:sort select="@poradi" data-type="number"/>
            <fo:block font-size="110%" font-weight="bold" padding-top="1em" keep-with-next="always">
                <xsl:value-of select="@poradi"/>. čtvrtina
            </fo:block>
            <fo:table width="90%" padding="1em" padding-top="5px" padding-bottom="5px" table-layout="fixed">
                <fo:table-column column-width="20%"/>
                <fo:table-column column-width="40%"/>
                <fo:table-column column-width="10%"/>
                <fo:table-column column-width="20%"/>
                <fo:table-header font-weight="bold">
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                Čas
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                Hráč
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                Akce
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                Popis
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:apply-templates/>
                </fo:table-body>
            </fo:table>
            <fo:block text-align="right" keep-with-previous="always">
                <fo:basic-link internal-destination="idSezony{../../../@sezonaZacatek}">
                    <fo:block>
                        <fo:external-graphic src="url(file:///E:\Škola\VŠE\4. semestr\XML - Teorie a praxe značkovacích jazyků (4IZ238)\semestralni_prace\dum.png)" width="2.5%" height="5%" content-width="2.5%" content-height="3%" vertical-align="middle" text-align="center"/>
                    </fo:block>
                </fo:basic-link>
            </fo:block>
        </xsl:for-each>
        
        
    </xsl:template>
    
    <xsl:template match="n:kos">
        <fo:table-row>
            <xsl:choose>
                <xsl:when test="(n:tym = ../../../../../n:tymy/n:tym[@id = current()/../../../n:domaci/@id]/n:nazev)">
                    <xsl:attribute name="background-color">
                        <xsl:text>rgb(0, 60, 150)</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="color">
                        <xsl:text>rgb(255, 255, 255)</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="(n:tym = ../../../../../n:tymy/n:tym[@id = current()/../../../n:domaci/@id]/n:zkratka)">
                    <xsl:attribute name="background-color">
                        <xsl:text>rgb(0, 60, 150)</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="color">
                        <xsl:text>rgb(255, 255, 255)</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="background-color">
                        <xsl:text>rgb(60, 255, 220)</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="n:cas"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="n:hrac"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    koš
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="n:body"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="n:faul">
        <fo:table-row>
            <xsl:attribute name="background-color">
                <xsl:text>rgb(255, 90, 90)</xsl:text>
            </xsl:attribute>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="n:cas"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="n:hrac"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    faul
                </fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <fo:block>
                    <xsl:value-of select="@typ"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="n:hrac"/>
    
    
</xsl:stylesheet>